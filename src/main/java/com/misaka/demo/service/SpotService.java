package com.misaka.demo.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.misaka.demo.client.ExternalAnimeClient;
import com.misaka.demo.client.ExternalAnimeClient.AnitabiPoint;
import com.misaka.demo.entity.Anime;
import com.misaka.demo.entity.Spot;
import com.misaka.demo.mapper.AnimeMapper;
import com.misaka.demo.mapper.SpotMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class SpotService {

    private static final Logger log = LoggerFactory.getLogger(SpotService.class);
    /** 用于经度边界换算的纬度安全 cos 下限，避免靠近极地时除零放大。 */
    private static final double MIN_COS_LAT = 0.01;

    @Autowired
    private SpotMapper spotMapper;

    @Autowired
    private AnimeMapper animeMapper;

    @Autowired
    private AnimeService animeService;

    @Autowired
    private ExternalAnimeClient externalClient;

    /**
     * 半径内取景地。radius 单位米；用纬经度边界框初筛，再按欧氏距离粗排，
     * 取景地数据规模小、半径不大时这样足够。
     */
    public List<Spot> findNearby(double lat, double lng, int radiusMeters, int limit) {
        double latDelta = radiusMeters / 111_000.0;
        double cos = Math.cos(Math.toRadians(lat));
        double lngDelta = radiusMeters / (111_000.0 * Math.max(Math.abs(cos), MIN_COS_LAT));
        BigDecimal latBd = BigDecimal.valueOf(lat).setScale(7, RoundingMode.HALF_UP);
        BigDecimal lngBd = BigDecimal.valueOf(lng).setScale(7, RoundingMode.HALF_UP);
        return spotMapper.selectNearby(
                latBd,
                lngBd,
                latBd.subtract(BigDecimal.valueOf(latDelta)),
                latBd.add(BigDecimal.valueOf(latDelta)),
                lngBd.subtract(BigDecimal.valueOf(lngDelta)),
                lngBd.add(BigDecimal.valueOf(lngDelta)),
                limit);
    }

    public Spot findById(long id) {
        return spotMapper.selectById(id);
    }

    public Anime findAnime(int animeId) {
        return animeMapper.selectById(animeId);
    }

    /**
     * 取作品下所有取景地。
     * 缺失或不齐时（本地数 &lt; anime.pointsCount）触发 Anitabi 同步并落库。
     * force=true 强制重拉一次（用于排错或手动刷新）。
     */
    public List<Spot> findByAnimeId(int animeId, boolean force) {
        List<Spot> local = spotMapper.selectList(
                new QueryWrapper<Spot>().eq("anime_id", animeId));

        // 本地齐全且未强制刷新则直接返回
        Anime anime = animeService.findById(animeId);
        int expected = anime == null || anime.getPointsCount() == null ? 0 : anime.getPointsCount();
        boolean needSync = force || local.isEmpty() || (expected > 0 && local.size() < expected);

        if (!needSync) return local;
        if (anime == null) return local; // 作品在 Anitabi 也找不到，直接给本地有的

        try {
            List<AnitabiPoint> points = externalClient.fetchAnitabiPoints(animeId);
            log.info("Sync spots for anime {}: local={}, expected={}, fetched={}",
                    animeId, local.size(), expected, points.size());
            if (points.isEmpty()) return local;
            int inserted = 0;
            for (AnitabiPoint p : points) {
                if (upsertFromAnitabi(p, animeId)) inserted++;
            }
            log.info("Sync done for anime {}: upserted {} rows", animeId, inserted);
            return spotMapper.selectList(new QueryWrapper<Spot>().eq("anime_id", animeId));
        } catch (Exception e) {
            log.warn("Anitabi points sync failed for anime {}: {}", animeId, e.toString());
            return local;
        }
    }

    public List<Spot> findByAnimeId(int animeId) {
        return findByAnimeId(animeId, false);
    }

    /** 返回 true 表示这条记录被 insert 或 update 成功落库。 */
    private boolean upsertFromAnitabi(AnitabiPoint p, int animeId) {
        if (p.getId() == null || p.getGeo() == null || p.getGeo().size() != 2) return false;
        try {
            Spot existing = spotMapper.selectByAnitabiPointId(p.getId());
            Spot s = existing != null ? existing : new Spot();
            s.setAnimeId(animeId);
            s.setAnitabiPointId(p.getId());
            s.setName(p.getName());
            s.setNameCn(p.getCn());
            s.setImageUrl(p.getImage());
            s.setEpisode(p.getEp());
            s.setSceneSeconds(p.getS());
            s.setLatitude(BigDecimal.valueOf(p.getGeo().get(0)));
            s.setLongitude(BigDecimal.valueOf(p.getGeo().get(1)));
            s.setOrigin(p.getOrigin());
            s.setOriginUrl(p.getOriginURL());
            if (existing == null) {
                // name 为 NOT NULL，缺失就用中文兜底
                if (s.getName() == null || s.getName().isBlank()) s.setName(s.getNameCn());
                if (s.getName() == null || s.getName().isBlank()) return false;
                s.setCreatedAt(LocalDateTime.now());
                spotMapper.insert(s);
            } else {
                spotMapper.updateById(s);
            }
            return true;
        } catch (Exception e) {
            log.warn("Upsert spot failed for point {} (anime {}): {}", p.getId(), animeId, e.toString());
            return false;
        }
    }
}
