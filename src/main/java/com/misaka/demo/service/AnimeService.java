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
    private static final int FALLBACK_THRESHOLD = 3; // 本地命中少于该数 → 触发兜底外部搜索

    @Autowired
    private AnimeMapper animeMapper;

    @Autowired
    private ExternalAnimeClient externalClient;

    /** 关键字搜索；命中不足走 Bangumi+Anitabi 兜底并落库。 */
    public Page<Anime> search(String keyword, int page, int size) {
        Page<Anime> p = new Page<>(page + 1, size); // MP 页码从 1 起，前端 0 起
        if (keyword == null || keyword.isBlank()) {
            return animeMapper.selectPage(p, new QueryWrapper<Anime>().orderByDesc("synced_at"));
        }

        Page<Anime> result = animeMapper.selectPage(p, likeWrapper(keyword));

        // 仅在第一页且本地命中过少时触发外部兜底
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

    public Anime findById(int bangumiId) {
        Anime a = animeMapper.selectById(bangumiId);
        if (a != null) return a;
        // 数据库没有 → 现取并落库
        AnitabiLite lite = externalClient.fetchAnitabiLite(bangumiId);
        if (lite == null) return null;
        a = upsertFromAnitabi(lite, null);
        return a;
    }

    private QueryWrapper<Anime> likeWrapper(String kw) {
        String like = "%" + kw.trim() + "%";
        return new QueryWrapper<Anime>()
                .like("title_cn", like).or()
                .like("title_jp", like).or()
                .like("title_en", like).or()
                .like("abbr", like);
    }

    /** 调 Bangumi 搜索，对每条结果尝试拉 Anitabi 并落库。 */
    private void fetchAndPersistFromExternal(String keyword) {
        List<BangumiSearchItem> items = externalClient.searchBangumi(keyword, 10);
        for (BangumiSearchItem it : items) {
            if (it.getId() == null) continue;
            AnitabiLite lite = externalClient.fetchAnitabiLite(it.getId());
            if (lite == null) continue; // 没巡礼数据就跳过，避免脏数据
            upsertFromAnitabi(lite, it);
        }
    }

    private Anime upsertFromAnitabi(AnitabiLite lite, BangumiSearchItem bgm) {
        Anime existing = animeMapper.selectById(lite.getId());
        Anime a = existing != null ? existing : new Anime();
        a.setBangumiId(lite.getId());
        if (lite.getCn() != null && !lite.getCn().isBlank()) a.setTitleCn(lite.getCn());
        else if (bgm != null && bgm.getNameCn() != null && !bgm.getNameCn().isBlank()) a.setTitleCn(bgm.getNameCn());
        if (lite.getTitle() != null) a.setTitleJp(lite.getTitle());
        else if (bgm != null) a.setTitleJp(bgm.getName());
        a.setCity(lite.getCity());
        a.setCoverUrl(lite.getCover());
        a.setColor(lite.getColor());
        if (lite.getGeo() != null && lite.getGeo().size() == 2) {
            a.setDefaultLat(BigDecimal.valueOf(lite.getGeo().get(0)));
            a.setDefaultLng(BigDecimal.valueOf(lite.getGeo().get(1)));
        }
        if (lite.getZoom() != null) a.setDefaultZoom(BigDecimal.valueOf(lite.getZoom()));
        a.setPointsCount(lite.getPointsLength() == null ? 0 : lite.getPointsLength());
        a.setAnitabiModified(lite.getModified());
        a.setSyncedAt(LocalDateTime.now());

        if (existing == null) {
            // titleJp 是 NOT NULL，缺失就用中文兜底
            if (a.getTitleJp() == null || a.getTitleJp().isBlank()) a.setTitleJp(a.getTitleCn());
            animeMapper.insert(a);
        } else {
            animeMapper.updateById(a);
        }
        return a;
    }
}
