package com.misaka.demo.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.misaka.demo.client.ExternalAnimeClient;
import com.misaka.demo.client.ExternalAnimeClient.AnitabiPoint;
import com.misaka.demo.dto.MapAnimeOptionVO;
import com.misaka.demo.dto.SpotMapCluster;
import com.misaka.demo.dto.SpotMapItemVO;
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

    public Page<Spot> findByAnimeIdPage(int animeId, boolean force, int page, int size) {
        Long localCountValue = spotMapper.selectCount(new QueryWrapper<Spot>().eq("anime_id", animeId));
        int localCount = localCountValue == null ? 0 : localCountValue.intValue();
        if (force || localCount == 0) {
            ensureSpotsSynced(animeId, force, localCount);
        }
        Page<Spot> resultPage = new Page<>(page + 1, size);
        return spotMapper.selectPage(resultPage, animeSpotsWrapper(animeId));
    }

    private boolean ensureSpotsSynced(int animeId, boolean force, int localCount) {
        Anime beforeSync = animeMapper.selectById(animeId);

        Anime anime = animeService.syncByBangumiId(animeId, force);
        boolean modifiedChanged = hasModifiedChanged(beforeSync, anime);
        int expected = anime == null || anime.getPointsCount() == null ? 0 : anime.getPointsCount();
        boolean needSync = force || localCount < expected || modifiedChanged;

        if (!needSync || anime == null) {
            return false;
        }

        try {
            List<AnitabiPoint> points = externalClient.fetchAnitabiPoints(animeId);
            log.info("Sync spots for anime {}: local={}, expected={}, fetched={}",
                    animeId, localCount, expected, points.size());
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

    private boolean hasModifiedChanged(Anime beforeSync, Anime afterSync) {
        if (beforeSync == null) {
            return afterSync != null;
        }
        if (afterSync == null) {
            return false;
        }
        if (beforeSync.getAnitabiModified() == null || afterSync.getAnitabiModified() == null) {
            return false;
        }
        return !beforeSync.getAnitabiModified().equals(afterSync.getAnitabiModified());
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
