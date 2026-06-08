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
import java.util.List;

@Service
public class AnimeService {

    private static final Logger log = LoggerFactory.getLogger(AnimeService.class);
    private static final int FALLBACK_THRESHOLD = 1;
    private static final int FALLBACK_FETCH_LIMIT = 10;
    private static final long ANIME_SYNC_TTL_HOURS = 12;

    @Autowired
    private AnimeMapper animeMapper;

    @Autowired
    private ExternalAnimeClient externalClient;

    /**
     * 关键字搜索；本地命中不足时走 Bangumi 搜索兜底拿到 subjectID，
     * 再通过 Anitabi lite 写入本地。
     */
    public Page<Anime> search(String keyword, int page, int size) {
        Page<Anime> resultPage = new Page<>(page + 1, size);
        if (keyword == null || keyword.isBlank()) {
            return animeMapper.selectPage(resultPage, new QueryWrapper<Anime>().orderByDesc("synced_at"));
        }

        Page<Anime> result = animeMapper.selectPage(resultPage, likeWrapper(keyword));

        if (page == 0 && result.getRecords().size() < FALLBACK_THRESHOLD) {
            try {
                fetchAndPersistFromExternal(keyword);
                result = animeMapper.selectPage(new Page<>(1, size), likeWrapper(keyword));
            } catch (Exception e) {
                log.warn("External fallback failed for '{}': {}", keyword, e.getMessage());
            }
        }

        return result;
    }

    public Page<Anime> searchAndSyncOfficial(String keyword, int page, int size) {
        if (keyword != null && !keyword.isBlank()) {
            try {
                fetchAndPersistFromExternal(keyword);
            } catch (Exception e) {
                log.warn("Official sync failed for '{}': {}", keyword, e.getMessage());
            }
        }
        return animeMapper.selectPage(new Page<>(page + 1, size), likeWrapper(keyword));
    }

    public Anime findById(int bangumiId) {
        return syncByBangumiId(bangumiId, false);
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
        return existing.getSyncedAt() != null
                && existing.getSyncedAt().isBefore(LocalDateTime.now().minusHours(ANIME_SYNC_TTL_HOURS));
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
}
