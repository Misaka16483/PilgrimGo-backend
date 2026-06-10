package com.misaka.demo.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.misaka.demo.client.ExternalAnimeClient;
import com.misaka.demo.client.ExternalAnimeClient.AnitabiLite;
import com.misaka.demo.client.ExternalAnimeClient.BangumiSearchItem;
import com.misaka.demo.entity.Anime;
import com.misaka.demo.mapper.AnimeMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AnimeService {

    private static final Logger log = LoggerFactory.getLogger(AnimeService.class);
    private static final int FALLBACK_FETCH_LIMIT = 5;

    @Autowired
    private AnimeMapper animeMapper;

    @Autowired
    private ExternalAnimeClient externalClient;

    /**
     * 关键字搜索；本地命中不足时走 Bangumi 搜索兜底拿到 subjectID，
     * 再通过 Anitabi lite 写入本地。
     */
    public Page<Anime> search(String keyword, int page, int size) {
        String safeKeyword = keyword == null ? null : keyword.trim();
        if (safeKeyword != null && safeKeyword.isBlank()) {
            safeKeyword = null;
        }
        return animeMapper.selectSearchAnimeWithSpots(new Page<>(page + 1, size), safeKeyword);
    }

    public Page<Anime> searchAndSyncOfficial(String keyword, int page, int size) {
        if (keyword != null && !keyword.isBlank()) {
            try {
                fetchAndPersistFromExternal(keyword);
            } catch (Exception e) {
                log.warn("Official sync failed for '{}': {}", keyword, e.getMessage());
            }
        }
        return withActualSpotCounts(animeMapper.selectPage(new Page<>(page + 1, size), likeWrapper(keyword)));
    }

    public Page<Anime> searchExternalOnly(String keyword, int page, int size) {
        Page<Anime> result = new Page<>(page + 1, size);
        if (keyword == null || keyword.isBlank()) {
            result.setRecords(List.of());
            result.setTotal(0);
            return result;
        }

        List<Anime> records = externalClient.searchBangumi(keyword, Math.min(Math.max(size, 1), FALLBACK_FETCH_LIMIT)).stream()
                .filter(item -> item.getId() != null)
                .map(item -> toExternalAnime(item, externalClient.fetchAnitabiLite(item.getId())))
                .filter(anime -> anime != null)
                .toList();
        result.setRecords(records);
        result.setTotal(records.size());
        return result;
    }

    public Anime findExternalOnlyById(int bangumiId) {
        AnitabiLite lite = externalClient.fetchAnitabiLite(bangumiId);
        return toExternalAnime(null, lite);
    }

    public List<Anime> findCachedAnimeOptions(int limit) {
        int safeLimit = Math.min(Math.max(limit, 1), 100);
        return animeMapper.selectCachedAnimeOptions(safeLimit);
    }

    public Anime findById(int bangumiId) {
        return animeMapper.selectById(bangumiId);
    }

    public Anime syncByBangumiId(int bangumiId, boolean forceSync) {
        Anime existing = animeMapper.selectById(bangumiId);
        if (!shouldFetchAnimeFromExternal(existing, forceSync)) {
            return existing;
        }

        AnitabiLite lite = externalClient.fetchAnitabiLite(bangumiId);
        if (lite == null) {
            return existing;
        }

        if (!shouldSyncAnime(existing, lite, forceSync)) {
            return existing;
        }

        return upsertFromAnitabi(lite, null, existing);
    }

    private QueryWrapper<Anime> likeWrapper(String keyword) {
        String like = "%" + keyword.trim() + "%";
        return new QueryWrapper<Anime>()
                .like("title_cn", like).or()
                .like("title_jp", like).or()
                .like("title_en", like).or()
                .like("abbr", like);
    }

    private void fetchAndPersistFromExternal(String keyword) {
        List<BangumiSearchItem> items = externalClient.searchBangumi(keyword, FALLBACK_FETCH_LIMIT);
        for (BangumiSearchItem item : items) {
            if (item.getId() == null) {
                continue;
            }

            AnitabiLite lite = externalClient.fetchAnitabiLite(item.getId());
            if (lite == null) {
                continue;
            }

            Anime existing = animeMapper.selectById(lite.getId());
            if (!shouldSyncAnime(existing, lite, false)) {
                continue;
            }

            upsertFromAnitabi(lite, item, existing);
        }
    }

    private boolean shouldFetchAnimeFromExternal(Anime existing, boolean forceSync) {
        if (forceSync || existing == null) {
            return true;
        }
        return false;
    }

    private boolean shouldSyncAnime(Anime existing, AnitabiLite lite, boolean forceSync) {
        if (forceSync || existing == null) {
            return true;
        }

        if (lite.getModified() == null || existing.getAnitabiModified() == null) {
            return true;
        }

        return !lite.getModified().equals(existing.getAnitabiModified());
    }

    private Anime upsertFromAnitabi(AnitabiLite lite, BangumiSearchItem bangumi, Anime existing) {
        Anime anime = existing != null ? existing : new Anime();
        anime.setBangumiId(lite.getId());

        if (lite.getCn() != null && !lite.getCn().isBlank()) {
            anime.setTitleCn(lite.getCn());
        } else if (bangumi != null && bangumi.getNameCn() != null && !bangumi.getNameCn().isBlank()) {
            anime.setTitleCn(bangumi.getNameCn());
        }

        if (lite.getTitle() != null && !lite.getTitle().isBlank()) {
            anime.setTitleJp(lite.getTitle());
        } else if (bangumi != null) {
            anime.setTitleJp(bangumi.getName());
        }

        anime.setCity(lite.getCity());
        anime.setCoverUrl(lite.getCover());
        anime.setColor(lite.getColor());

        if (lite.getGeo() != null && lite.getGeo().size() == 2) {
            anime.setDefaultLat(BigDecimal.valueOf(lite.getGeo().get(0)));
            anime.setDefaultLng(BigDecimal.valueOf(lite.getGeo().get(1)));
        }

        if (lite.getZoom() != null) {
            anime.setDefaultZoom(BigDecimal.valueOf(lite.getZoom()));
        }

        anime.setPointsCount(resolveDisplaySpotCount(lite));
        anime.setAnitabiModified(lite.getModified());
        anime.setSyncedAt(LocalDateTime.now());

        if (existing == null) {
            if (anime.getTitleJp() == null || anime.getTitleJp().isBlank()) {
                anime.setTitleJp(anime.getTitleCn());
            }
            animeMapper.insert(anime);
        } else {
            animeMapper.updateById(anime);
        }

        return anime;
    }

    private int resolveDisplaySpotCount(AnitabiLite lite) {
        if (lite.getImagesLength() != null) {
            return lite.getImagesLength();
        }
        return lite.getPointsLength() == null ? 0 : lite.getPointsLength();
    }

    private Anime toExternalAnime(BangumiSearchItem bangumi, AnitabiLite lite) {
        if (lite == null) {
            return null;
        }
        Anime anime = new Anime();
        anime.setBangumiId(lite.getId());
        anime.setTitleCn(lite.getCn());
        anime.setTitleJp(lite.getTitle());
        if ((anime.getTitleCn() == null || anime.getTitleCn().isBlank()) && bangumi != null) {
            anime.setTitleCn(bangumi.getNameCn());
        }
        if ((anime.getTitleJp() == null || anime.getTitleJp().isBlank()) && bangumi != null) {
            anime.setTitleJp(bangumi.getName());
        }
        anime.setCity(lite.getCity());
        anime.setCoverUrl(lite.getCover());
        anime.setColor(lite.getColor());
        anime.setPointsCount(resolveDisplaySpotCount(lite));
        anime.setAnitabiModified(lite.getModified());
        return anime;
    }

    private Page<Anime> withActualSpotCounts(Page<Anime> page) {
        List<Anime> records = page.getRecords();
        if (records == null || records.isEmpty()) {
            return page;
        }

        List<Integer> animeIds = records.stream()
                .map(Anime::getBangumiId)
                .filter(id -> id != null)
                .distinct()
                .toList();
        if (animeIds.isEmpty()) {
            return page;
        }

        Map<Integer, Integer> spotCounts = new HashMap<>();
        for (Map<String, Object> row : animeMapper.selectSpotCountsByAnimeIds(animeIds)) {
            Integer animeId = toInteger(row.get("anime_id"));
            Integer spotCount = toInteger(row.get("spot_count"));
            if (animeId != null && spotCount != null) {
                spotCounts.put(animeId, spotCount);
            }
        }

        records.forEach(anime -> anime.setPointsCount(
                spotCounts.getOrDefault(anime.getBangumiId(), 0)));
        return page;
    }

    private Integer toInteger(Object value) {
        if (value instanceof Number number) {
            return number.intValue();
        }
        if (value instanceof String text && !text.isBlank()) {
            return Integer.parseInt(text);
        }
        return null;
    }
}
