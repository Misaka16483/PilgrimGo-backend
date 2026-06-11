package com.misaka.demo.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.misaka.demo.client.ExternalAnimeClient;
import com.misaka.demo.client.ExternalAnimeClient.AnitabiPoint;
import com.misaka.demo.dto.MapAnimeOptionVO;
import com.misaka.demo.dto.MapBoundsVO;
import com.misaka.demo.dto.SpotMapCluster;
import com.misaka.demo.dto.SpotMapItemVO;
import com.misaka.demo.dto.SpotVO;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;

@Service
public class SpotService {

    private static final Logger log = LoggerFactory.getLogger(SpotService.class);
    private static final double DETAIL_ZOOM = 11.5;
    private static final int MAX_MAP_LIMIT = 300;
    private static final int MAX_MAP_ANIME_LIMIT = 80;
    private final AtomicBoolean mapLocationBackfillChecked = new AtomicBoolean(false);

    @Autowired
    private SpotMapper spotMapper;

    @Autowired
    private AnimeMapper animeMapper;

    @Autowired
    private AnimeService animeService;

    @Autowired
    private ExternalAnimeClient externalClient;

    public List<SpotMapItemVO> findMapItems(
            double minLat,
            double maxLat,
            double minLng,
            double maxLng,
            double zoom,
            int limit,
            Integer animeId) {
        if (!isValidBounds(minLat, maxLat, minLng, maxLng)) {
            return List.of();
        }

        ensureMapLocationsReady();

        int safeLimit = Math.min(Math.max(limit, 1), MAX_MAP_LIMIT);
        BigDecimal minLatBd = BigDecimal.valueOf(minLat).setScale(7, RoundingMode.HALF_UP);
        BigDecimal maxLatBd = BigDecimal.valueOf(maxLat).setScale(7, RoundingMode.HALF_UP);
        BigDecimal minLngBd = BigDecimal.valueOf(minLng).setScale(7, RoundingMode.HALF_UP);
        BigDecimal maxLngBd = BigDecimal.valueOf(maxLng).setScale(7, RoundingMode.HALF_UP);

        if (zoom >= DETAIL_ZOOM) {
            List<Spot> spots = spotMapper.selectInBounds(minLatBd, maxLatBd, minLngBd, maxLngBd, safeLimit, animeId);
            return toMapSpotItems(spots);
        }

        BigDecimal cellSize = BigDecimal.valueOf(resolveClusterCellSize(zoom));
        List<SpotMapCluster> clusters = spotMapper.selectClustersInBounds(
                minLatBd, maxLatBd, minLngBd, maxLngBd, cellSize, safeLimit, animeId);
        return clusters.stream().map(SpotMapItemVO::cluster).toList();
    }

    private void ensureMapLocationsReady() {
        if (!mapLocationBackfillChecked.compareAndSet(false, true)) {
            return;
        }

        int updated = spotMapper.backfillMissingLocations();
        if (updated > 0) {
            log.info("Backfilled PostGIS location for {} spots", updated);
        }
    }

    public Spot findById(long id) {
        return spotMapper.selectById(id);
    }

    public List<MapAnimeOptionVO> findMapAnimeOptions(int limit) {
        int safeLimit = Math.min(Math.max(limit, 1), MAX_MAP_ANIME_LIMIT);
        return animeMapper.selectMapAnimeOptions(safeLimit).stream()
                .map(MapAnimeOptionVO::from)
                .toList();
    }

    public MapBoundsVO findAnimeMapBounds(int animeId) {
        return spotMapper.selectMainBoundsByAnimeId(animeId);
    }

    public Anime findAnime(int animeId) {
        return animeMapper.selectById(animeId);
    }

    private List<SpotMapItemVO> toMapSpotItems(List<Spot> spots) {
        if (spots.isEmpty()) return List.of();
        Map<Integer, Anime> animeCache = new HashMap<>();
        return spots.stream()
                .map(s -> SpotMapItemVO.spot(s,
                        animeCache.computeIfAbsent(s.getAnimeId(), animeMapper::selectById)))
                .toList();
    }

    private boolean isValidBounds(double minLat, double maxLat, double minLng, double maxLng) {
        return Double.isFinite(minLat)
                && Double.isFinite(maxLat)
                && Double.isFinite(minLng)
                && Double.isFinite(maxLng)
                && minLat >= -90
                && maxLat <= 90
                && minLng >= -180
                && maxLng <= 180
                && minLat < maxLat
                && minLng < maxLng;
    }

    private double resolveClusterCellSize(double zoom) {
        if (zoom < 6) return 2.0;
        if (zoom < 9) return 1.0;
        if (zoom < 11) return 0.35;
        return 0.12;
    }

    /**
     * 取作品下所有取景地。
     * 使用 Anitabi lite 的 modified 时间戳判断作品是否有更新，
     * 一旦作品数据已更新，就重新同步 points/detail 到本地。
     */
    public List<Spot> findByAnimeId(int animeId, boolean force) {
        QueryWrapper<Spot> wrapper = animeSpotsWrapper(animeId);
        List<Spot> local = spotMapper.selectList(wrapper);
        if (!force && !local.isEmpty()) {
            return local;
        }
        if (!ensureSpotsSynced(animeId, force, local.size())) {
            return local;
        }
        return spotMapper.selectList(animeSpotsWrapper(animeId));
    }

    private QueryWrapper<Spot> animeSpotsWrapper(int animeId) {
        return new QueryWrapper<Spot>()
                .eq("anime_id", animeId)
                .orderByAsc("id");
    }

    public List<Spot> findByAnimeId(int animeId) {
        return findByAnimeId(animeId, false);
    }

    public List<Spot> findLocalByAnimeId(int animeId) {
        return spotMapper.selectList(animeSpotsWrapper(animeId));
    }

    public Page<Spot> findByAnimeIdPage(int animeId, boolean force, int page, int size) {
        return findByAnimeIdPage(animeId, force, page, size, false);
    }

    public Page<Spot> findByAnimeIdPage(int animeId, boolean force, int page, int size, boolean sync) {
        Long localCountValue = spotMapper.selectCount(new QueryWrapper<Spot>().eq("anime_id", animeId));
        int localCount = localCountValue == null ? 0 : localCountValue.intValue();
        if (sync && (force || localCount == 0)) {
            if (ensureSpotsSynced(animeId, force, localCount)) {
                Long updatedCount = spotMapper.selectCount(new QueryWrapper<Spot>().eq("anime_id", animeId));
                localCount = updatedCount == null ? 0 : updatedCount.intValue();
            }
        }
        Page<Spot> resultPage = new Page<>(page + 1, size, false);
        resultPage.setTotal(localCount);
        return spotMapper.selectPage(resultPage, animeSpotsWrapper(animeId));
    }

    public Page<SpotVO> findExternalByAnimeIdPage(int animeId, int page, int size) {
        Anime anime = animeService.findExternalOnlyById(animeId);
        Page<SpotVO> result = new Page<>(page + 1, size, false);
        if (anime == null) {
            result.setRecords(List.of());
            result.setTotal(0);
            return result;
        }

        List<SpotVO> all = externalClient.fetchAnitabiPoints(animeId).stream()
                .filter(point -> point.getId() != null && point.getGeo() != null && point.getGeo().size() == 2)
                .map(point -> toExternalSpotVO(point, animeId, anime))
                .toList();
        int from = Math.min(Math.max(page, 0) * Math.max(size, 1), all.size());
        int to = Math.min(from + Math.max(size, 1), all.size());
        result.setRecords(all.subList(from, to));
        result.setTotal(all.size());
        return result;
    }

    /**
     * 一键收录用：全量拉取 Anitabi 地标并落库（作品信息由调用方先行同步），
     * 返回同步后该作品的本地地标数。
     */
    public int syncSpotsFromAnitabi(int animeId) {
        List<AnitabiPoint> points = externalClient.fetchAnitabiPoints(animeId);
        int upserted = 0;
        for (AnitabiPoint point : points) {
            if (upsertFromAnitabi(point, animeId)) {
                upserted++;
            }
        }
        log.info("Import spots for anime {}: fetched={}, upserted={}", animeId, points.size(), upserted);
        Long count = spotMapper.selectCount(new QueryWrapper<Spot>().eq("anime_id", animeId));
        return count == null ? 0 : count.intValue();
    }

    private boolean ensureSpotsSynced(int animeId, boolean force, int localCount) {
        Anime beforeSync = animeMapper.selectById(animeId);

        Anime anime = force ? animeService.syncByBangumiId(animeId, true) : beforeSync;
        boolean needSync = force || localCount == 0;

        if (!needSync || anime == null) {
            return false;
        }

        try {
            List<AnitabiPoint> points = externalClient.fetchAnitabiPoints(animeId);
            log.info("Sync spots for anime {}: local={}, fetched={}",
                    animeId, localCount, points.size());
            if (points.isEmpty()) {
                return false;
            }
            int inserted = 0;
            for (AnitabiPoint point : points) {
                if (upsertFromAnitabi(point, animeId)) {
                    inserted++;
                }
            }
            log.info("Sync done for anime {}: upserted {} rows", animeId, inserted);
            return true;
        } catch (Exception e) {
            log.warn("Anitabi points sync failed for anime {}: {}", animeId, e.toString());
            return false;
        }
    }

    private SpotVO toExternalSpotVO(AnitabiPoint point, int animeId, Anime anime) {
        Spot spot = new Spot();
        spot.setId(-Math.abs((long) point.getId().hashCode()));
        spot.setAnimeId(animeId);
        spot.setAnitabiPointId(point.getId());
        spot.setName(point.getName());
        spot.setNameCn(point.getCn());
        spot.setImageUrl(point.getImage());
        spot.setEpisode(point.getEp());
        spot.setSceneSeconds(point.getS());
        spot.setLatitude(BigDecimal.valueOf(point.getGeo().get(0)));
        spot.setLongitude(BigDecimal.valueOf(point.getGeo().get(1)));
        spot.setOrigin(point.getOrigin());
        spot.setOriginUrl(point.getOriginURL());
        return SpotVO.from(spot, anime);
    }

    private boolean upsertFromAnitabi(AnitabiPoint point, int animeId) {
        if (point.getId() == null || point.getGeo() == null || point.getGeo().size() != 2) {
            return false;
        }

        try {
            Spot existing = spotMapper.selectByAnitabiPointId(point.getId());
            Spot spot = existing != null ? existing : new Spot();
            spot.setAnimeId(animeId);
            spot.setAnitabiPointId(point.getId());
            spot.setName(point.getName());
            spot.setNameCn(point.getCn());
            spot.setImageUrl(point.getImage());
            spot.setEpisode(point.getEp());
            spot.setSceneSeconds(point.getS());
            spot.setLatitude(BigDecimal.valueOf(point.getGeo().get(0)));
            spot.setLongitude(BigDecimal.valueOf(point.getGeo().get(1)));
            spot.setOrigin(point.getOrigin());
            spot.setOriginUrl(point.getOriginURL());

            if (existing == null) {
                if (spot.getName() == null || spot.getName().isBlank()) {
                    spot.setName(spot.getNameCn());
                }
                if (spot.getName() == null || spot.getName().isBlank()) {
                    return false;
                }
                spot.setCreatedAt(LocalDateTime.now());
                spotMapper.insert(spot);
            } else {
                spotMapper.updateById(spot);
            }
            spotMapper.updateLocationById(spot.getId());
            return true;
        } catch (Exception e) {
            log.warn("Upsert spot failed for point {} (anime {}): {}", point.getId(), animeId, e.toString());
            return false;
        }
    }
}
