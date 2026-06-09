package com.misaka.demo.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.misaka.demo.dto.RouteReviewVO;
import com.misaka.demo.dto.RouteUploadRequest;
import com.misaka.demo.entity.Anime;
import com.misaka.demo.entity.CheckIn;
import com.misaka.demo.entity.Route;
import com.misaka.demo.entity.RoutePoint;
import com.misaka.demo.entity.RouteRating;
import com.misaka.demo.entity.RouteSpot;
import com.misaka.demo.entity.Spot;
import com.misaka.demo.entity.User;
import com.misaka.demo.entity.Waypoint;
import com.misaka.demo.mapper.AnimeMapper;
import com.misaka.demo.mapper.CheckInMapper;
import com.misaka.demo.mapper.RouteMapper;
import com.misaka.demo.mapper.RoutePointMapper;
import com.misaka.demo.mapper.RouteRatingMapper;
import com.misaka.demo.mapper.RouteSpotMapper;
import com.misaka.demo.mapper.SpotMapper;
import com.misaka.demo.mapper.UserMapper;
import com.misaka.demo.mapper.WaypointMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class RouteService {

    /** 下限：低于这个轨迹点数视为无效录制。 */
    private static final int MIN_TRACK_POINTS = 2;

    @Autowired
    private RouteMapper routeMapper;

    @Autowired
    private RoutePointMapper routePointMapper;

    @Autowired
    private WaypointMapper waypointMapper;

    @Autowired
    private AnimeMapper animeMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private RouteSpotMapper routeSpotMapper;

    @Autowired
    private SpotMapper spotMapper;

    @Autowired
    private CheckInMapper checkInMapper;

    @Autowired
    private RouteRatingMapper routeRatingMapper;

    /**
     * 落库一条录制完成的路径：route 主表 + route_point 轨迹 + waypoint 转折点。
     * 距离/时长由轨迹点直接计算，避免相信客户端任意上传值。
     */
    @Transactional
    public Route uploadRoute(Long userId, RouteUploadRequest req) {
        if (userId == null) throw new RuntimeException("未登录");
        if (req.getAnimeId() == null) throw new RuntimeException("缺少动画 ID");
        if (req.getTitle() == null || req.getTitle().isBlank()) throw new RuntimeException("路径标题不能为空");
        List<RouteUploadRequest.TrackPointDTO> track = req.getTrackPoints();
        if (track == null || track.size() < MIN_TRACK_POINTS) {
            throw new RuntimeException("轨迹点不足，无法生成路径");
        }

        double distanceMeters = totalDistance(track);
        long durationSeconds = totalDuration(track);
        LocalDateTime startedAt = toLocal(track.get(0).getTimestamp());

        Route route = new Route();
        route.setUserId(userId);
        route.setAnimeId(req.getAnimeId());
        route.setTitle(req.getTitle().trim());
        route.setDescription(req.getDescription());
        route.setDistanceKm(BigDecimal.valueOf(distanceMeters / 1000.0)
                .setScale(2, RoundingMode.HALF_UP));
        route.setEstimatedMinutes((int) Math.max(1, Math.round(durationSeconds / 60.0)));
        route.setAvgRating(BigDecimal.ZERO);
        route.setRatingCount(0);
        route.setFollowCount(0);
        route.setStatus("pending");
        route.setRecordedAt(startedAt);
        route.setCreatedAt(LocalDateTime.now());
        routeMapper.insert(route);

        for (int i = 0; i < track.size(); i++) {
            RouteUploadRequest.TrackPointDTO p = track.get(i);
            if (p.getLatitude() == null || p.getLongitude() == null) continue;
            RoutePoint rp = new RoutePoint();
            rp.setRouteId(route.getId());
            rp.setSequence(i);
            rp.setLatitude(BigDecimal.valueOf(p.getLatitude()).setScale(7, RoundingMode.HALF_UP));
            rp.setLongitude(BigDecimal.valueOf(p.getLongitude()).setScale(7, RoundingMode.HALF_UP));
            if (p.getAltitude() != null) {
                rp.setAltitude(BigDecimal.valueOf(p.getAltitude()).setScale(2, RoundingMode.HALF_UP));
            }
            rp.setRecordedAt(toLocal(p.getTimestamp()));
            routePointMapper.insert(rp);
        }

        List<RouteUploadRequest.WaypointDTO> wps = req.getWaypoints();
        if (wps != null) {
            for (int i = 0; i < wps.size(); i++) {
                RouteUploadRequest.WaypointDTO w = wps.get(i);
                if (w == null || w.getLocation() == null
                        || w.getLocation().getLatitude() == null
                        || w.getLocation().getLongitude() == null) {
                    continue;
                }
                Waypoint wp = new Waypoint();
                wp.setRouteId(route.getId());
                wp.setSequence(w.getOrderIndex() == null ? i : w.getOrderIndex());
                wp.setLatitude(BigDecimal.valueOf(w.getLocation().getLatitude())
                        .setScale(7, RoundingMode.HALF_UP));
                wp.setLongitude(BigDecimal.valueOf(w.getLocation().getLongitude())
                        .setScale(7, RoundingMode.HALF_UP));
                wp.setPhotoUrl(w.getImageUrl());
                wp.setInstruction(w.getDescription());
                wp.setWaypointType("photo");
                waypointMapper.insert(wp);
            }
        }

        // 录制时选定的目标取景地全部写入 route_spot，按提交顺序作为 visit_order。
        // 即使作者没在某个 spot 拍照，跟走用户也能看到完整观景点清单。
        if (req.getSpotIds() != null && !req.getSpotIds().isEmpty()) {
            LinkedHashSet<Long> unique = new LinkedHashSet<>();
            int order = 0;
            for (Long spotId : req.getSpotIds()) {
                if (spotId == null || !unique.add(spotId)) continue;
                RouteSpot rs = new RouteSpot();
                rs.setRouteId(route.getId());
                rs.setSpotId(spotId);
                rs.setVisitOrder(order++);
                routeSpotMapper.insert(rs);
            }
        }

        // 录制期间走到取景地附近调 /api/checkins 的打卡都还没绑 route_id，这里回填。
        // 严格限制为当前用户、route_id 仍为空的记录，避免被恶意覆写他人/已绑定打卡。
        if (req.getCheckInIds() != null && !req.getCheckInIds().isEmpty()) {
            List<Long> ids = req.getCheckInIds().stream().filter(java.util.Objects::nonNull).toList();
            if (!ids.isEmpty()) {
                CheckIn patch = new CheckIn();
                patch.setRouteId(route.getId());
                UpdateWrapper<CheckIn> w = new UpdateWrapper<CheckIn>()
                        .in("id", ids)
                        .eq("user_id", userId)
                        .isNull("route_id");
                checkInMapper.update(patch, w);
            }
        }

        return route;
    }

    public Route findById(long id) {
        return routeMapper.selectById(id);
    }

    /** rateRoute 返回给前端的统计摘要：聚合后的均分/人数 + 当前用户自己这条评价。 */
    public record RatingSummary(double rating, int ratingCount, int myScore, String myComment) {}

    /**
     * 提交一次评分/评价：同一用户对同一路径只保留最新一条（覆盖式）。
     * 评论文字可空——纯打星也算有效评价。提交后回写 route 的均分与评分人数。
     */
    @Transactional
    public RatingSummary rateRoute(Long userId, long routeId, Integer score, String comment) {
        if (userId == null) throw new RuntimeException("未登录");
        if (score == null || score < 1 || score > 5) throw new RuntimeException("评分需在 1-5 之间");
        Route route = routeMapper.selectById(routeId);
        if (route == null) throw new RuntimeException("路径不存在");

        String trimmed = comment == null ? null : comment.trim();
        if (trimmed != null && trimmed.isEmpty()) trimmed = null;
        if (trimmed != null && trimmed.length() > 1000) {
            throw new RuntimeException("评论过长，请控制在 1000 字以内");
        }

        RouteRating existing = routeRatingMapper.selectOne(new QueryWrapper<RouteRating>()
                .eq("route_id", routeId)
                .eq("user_id", userId));
        if (existing == null) {
            RouteRating rr = new RouteRating();
            rr.setRouteId(routeId);
            rr.setUserId(userId);
            rr.setScore(score);
            rr.setComment(trimmed);
            rr.setCreatedAt(LocalDateTime.now());
            routeRatingMapper.insert(rr);
        } else {
            UpdateWrapper<RouteRating> w = new UpdateWrapper<RouteRating>()
                    .eq("id", existing.getId())
                    .set("score", score)
                    .set("comment", trimmed)
                    .set("created_at", LocalDateTime.now());
            routeRatingMapper.update(null, w);
        }

        routeRatingMapper.recalcRouteRating(routeId);
        Route updated = routeMapper.selectById(routeId);
        double avg = updated.getAvgRating() == null ? 0 : updated.getAvgRating().doubleValue();
        int count = updated.getRatingCount() == null ? 0 : updated.getRatingCount();
        return new RatingSummary(avg, count, score, trimmed);
    }

    /** 路径的评价列表（带评价人信息），分页；前端 0 起页码转成 limit/offset。 */
    public List<RouteReviewVO> listReviews(long routeId, int page, int size) {
        int limit = size <= 0 ? 20 : size;
        int offset = Math.max(0, page) * limit;
        return routeRatingMapper.selectReviews(routeId, limit, offset);
    }

    /**
     * 按作品分页查询路径列表。sort：rating=按评分高到低；newest=按创建时间倒序。
     * 仅返回已发布或 pending 的路径（status != 'rejected'），避免脏数据上前端。
     */
    public Page<Route> findByAnime(int animeId, int page, int size, String sort) {
        QueryWrapper<Route> q = new QueryWrapper<Route>()
                .eq("anime_id", animeId)
                .ne("status", "rejected");
        if ("newest".equalsIgnoreCase(sort)) {
            q.orderByDesc("created_at");
        } else {
            // 默认按评分高到低，相同评分按评分人数兜底，再按创建时间
            q.orderByDesc("avg_rating", "rating_count", "created_at");
        }
        Page<Route> p = new Page<>(page + 1, size); // MP 页码从 1 起，前端 0 起
        return routeMapper.selectPage(p, q);
    }

    /**
     * "我的路径"：当前用户发布的全部路径，按创建时间倒序分页。
     * 与按作品列表不同，这里包含 pending/rejected——作者要能看到自己未过审的路径。
     */
    public Page<Route> findByUser(long userId, int page, int size) {
        QueryWrapper<Route> q = new QueryWrapper<Route>()
                .eq("user_id", userId)
                .orderByDesc("created_at");
        Page<Route> p = new Page<>(page + 1, size); // MP 页码从 1 起，前端 0 起
        return routeMapper.selectPage(p, q);
    }

    public List<RoutePoint> findPoints(long routeId) {
        return routePointMapper.selectByRouteId(routeId);
    }

    public List<Waypoint> findWaypoints(long routeId) {
        return waypointMapper.selectByRouteId(routeId);
    }

    /**
     * 拉出一条路径关联的全部观景点（按 visit_order）并附带作者本人在该点的打卡照片。
     * 返回 Object[]{ routeSpot, spot, List&lt;CheckIn&gt; }，service 内部用，避免新建一票 DTO。
     */
    public List<RouteSpotDetail> findRouteSpots(long routeId, long authorUserId) {
        List<RouteSpot> rs = routeSpotMapper.selectByRouteId(routeId);
        if (rs.isEmpty()) return Collections.emptyList();

        List<Long> spotIds = rs.stream().map(RouteSpot::getSpotId).toList();
        Map<Long, Spot> spotById = spotMapper.selectBatchIds(spotIds).stream()
                .collect(Collectors.toMap(Spot::getId, s -> s));

        // 作者照片可能跨多个 spot，一次查全后按 spot_id 分桶
        Map<Long, List<CheckIn>> photosBySpot = checkInMapper
                .selectByRouteAndUser(routeId, authorUserId).stream()
                .filter(ci -> ci.getSpotId() != null)
                .collect(Collectors.groupingBy(CheckIn::getSpotId));

        return rs.stream()
                .map(item -> new RouteSpotDetail(
                        item,
                        spotById.get(item.getSpotId()),
                        photosBySpot.getOrDefault(item.getSpotId(), Collections.emptyList())))
                .toList();
    }

    /** RouteVO.from 拼装观景地块用的内部容器。 */
    public record RouteSpotDetail(RouteSpot routeSpot, Spot spot, List<CheckIn> authorPhotos) {}

    public Anime findAnime(int animeId) {
        return animeMapper.selectById(animeId);
    }

    public User findAuthor(long userId) {
        return userMapper.selectById(userId);
    }

    /** 累计相邻点之间的 Haversine 距离，单位：米。 */
    private static double totalDistance(List<RouteUploadRequest.TrackPointDTO> track) {
        double sum = 0;
        for (int i = 1; i < track.size(); i++) {
            RouteUploadRequest.TrackPointDTO a = track.get(i - 1);
            RouteUploadRequest.TrackPointDTO b = track.get(i);
            if (a.getLatitude() == null || a.getLongitude() == null
                    || b.getLatitude() == null || b.getLongitude() == null) continue;
            sum += haversineMeters(a.getLatitude(), a.getLongitude(),
                    b.getLatitude(), b.getLongitude());
        }
        return sum;
    }

    /** 末点 - 首点 的时间戳差，毫秒转秒，单调最长情况；上传时间戳异常则按 0 处理。 */
    private static long totalDuration(List<RouteUploadRequest.TrackPointDTO> track) {
        Long first = track.get(0).getTimestamp();
        Long last = track.get(track.size() - 1).getTimestamp();
        if (first == null || last == null || last <= first) return 0;
        return (last - first) / 1000L;
    }

    private static LocalDateTime toLocal(Long epochMillis) {
        if (epochMillis == null || epochMillis <= 0) return null;
        return LocalDateTime.ofInstant(Instant.ofEpochMilli(epochMillis), ZoneOffset.UTC);
    }

    private static double haversineMeters(double lat1, double lng1, double lat2, double lng2) {
        double r = 6_371_000.0;
        double dLat = Math.toRadians(lat2 - lat1);
        double dLng = Math.toRadians(lng2 - lng1);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2)
                + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
                * Math.sin(dLng / 2) * Math.sin(dLng / 2);
        return 2 * r * Math.asin(Math.min(1, Math.sqrt(a)));
    }
}