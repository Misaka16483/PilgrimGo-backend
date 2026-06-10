package com.misaka.demo.dto;

import com.misaka.demo.entity.Anime;
import com.misaka.demo.entity.CheckIn;
import com.misaka.demo.entity.Route;
import com.misaka.demo.entity.RoutePoint;
import com.misaka.demo.entity.Spot;
import com.misaka.demo.entity.User;
import com.misaka.demo.entity.Waypoint;
import com.misaka.demo.service.RouteService;
import lombok.Data;

import java.time.ZoneOffset;
import java.util.Collections;
import java.util.List;

/** 与前端 src/types/index.ts 中的 PilgrimRoute 对齐。 */
@Data
public class RouteVO {

    private Long id;
    private Integer animeId;
    private String animeTitle;
    private Long authorId;
    private String authorName;
    private String title;
    private String description;
    private List<GeoPointVO> trackPoints;
    private List<WaypointVO> waypoints;
    /** 录制时关联的观景点，按 visit_order；含作者本人在该点拍的实景图。 */
    private List<RouteSpotVO> spots;
    /** 距离，单位：米。前端 formatDistance 接受米。 */
    private double distance;
    /** 时长，单位：秒。前端 formatDuration 接受秒。 */
    private long duration;
    private double rating;
    private int ratingCount;
    /** 关联的取景地数量，前端列表卡片展示。 */
    private int spotCount;
    /** 是否对其他用户可见；"我的路径"里作者据此显示私密标记。
     *  用包装类型让 Lombok 生成 getIsPublic()，JSON 字段名才是 isPublic 而非 public。 */
    private Boolean isPublic;
    private String createdAt;

    public static RouteVO from(Route r,
                               Anime anime,
                               User author,
                               List<RoutePoint> points,
                               List<Waypoint> waypoints,
                               List<RouteService.RouteSpotDetail> spotDetails) {
        RouteVO v = new RouteVO();
        v.setId(r.getId());
        v.setAnimeId(r.getAnimeId());
        v.setAnimeTitle(anime == null ? null
                : (anime.getTitleCn() != null && !anime.getTitleCn().isBlank()
                        ? anime.getTitleCn() : anime.getTitleJp()));
        v.setAuthorId(r.getUserId());
        v.setAuthorName(author == null ? null : author.getNickname());
        v.setTitle(r.getTitle());
        v.setDescription(r.getDescription());
        v.setTrackPoints(points.stream().map(GeoPointVO::from).toList());
        v.setWaypoints(java.util.stream.IntStream.range(0, waypoints.size())
                .mapToObj(i -> WaypointVO.from(waypoints.get(i), i))
                .toList());
        List<RouteSpotVO> spotVOs = spotDetails == null ? Collections.emptyList()
                : spotDetails.stream().map(RouteSpotVO::from).toList();
        v.setSpots(spotVOs);
        v.setDistance(r.getDistanceKm() == null ? 0
                : r.getDistanceKm().doubleValue() * 1000.0);
        v.setDuration(r.getEstimatedMinutes() == null ? 0
                : r.getEstimatedMinutes().longValue() * 60L);
        v.setRating(r.getAvgRating() == null ? 0 : r.getAvgRating().doubleValue());
        v.setRatingCount(r.getRatingCount() == null ? 0 : r.getRatingCount());
        v.setSpotCount(spotVOs.size());
        v.setIsPublic(!Boolean.FALSE.equals(r.getIsPublic()));
        v.setCreatedAt(r.getCreatedAt() == null ? null
                : r.getCreatedAt().toInstant(ZoneOffset.UTC).toString());
        return v;
    }

    @Data
    public static class GeoPointVO {
        private double latitude;
        private double longitude;
        private Double altitude;
        private long timestamp;

        public static GeoPointVO from(RoutePoint p) {
            GeoPointVO v = new GeoPointVO();
            v.setLatitude(p.getLatitude() == null ? 0 : p.getLatitude().doubleValue());
            v.setLongitude(p.getLongitude() == null ? 0 : p.getLongitude().doubleValue());
            v.setAltitude(p.getAltitude() == null ? null : p.getAltitude().doubleValue());
            v.setTimestamp(p.getRecordedAt() == null ? 0
                    : p.getRecordedAt().toInstant(ZoneOffset.UTC).toEpochMilli());
            return v;
        }
    }

    @Data
    public static class WaypointVO {
        private Long id;
        private GeoPointVO location;
        private String imageUrl;
        private String description;
        private int orderIndex;

        public static WaypointVO from(Waypoint w, int orderIndex) {
            WaypointVO v = new WaypointVO();
            v.setId(w.getId());
            GeoPointVO loc = new GeoPointVO();
            loc.setLatitude(w.getLatitude() == null ? 0 : w.getLatitude().doubleValue());
            loc.setLongitude(w.getLongitude() == null ? 0 : w.getLongitude().doubleValue());
            v.setLocation(loc);
            v.setImageUrl(w.getPhotoUrl());
            v.setDescription(w.getInstruction());
            v.setOrderIndex(orderIndex);
            return v;
        }
    }

    /** 重放页"观景地"卡片用的视图：spot 基础信息 + 作者本人在此点的实拍照。 */
    @Data
    public static class RouteSpotVO {
        private Long spotId;
        private String name;
        /** Anitabi 抓的原画截图。 */
        private String animeImageUrl;
        private Double latitude;
        private Double longitude;
        private int visitOrder;
        private Integer episodeNumber;
        /** "mm:ss" 形式的场景时间，可空。 */
        private String sceneTime;
        /** 作者本人在该取景点的打卡照片，可能多张；空数组表示作者未在此点打卡。 */
        private List<AuthorPhotoVO> authorPhotos;

        public static RouteSpotVO from(RouteService.RouteSpotDetail d) {
            RouteSpotVO v = new RouteSpotVO();
            v.setSpotId(d.routeSpot().getSpotId());
            v.setVisitOrder(d.routeSpot().getVisitOrder() == null ? 0
                    : d.routeSpot().getVisitOrder());
            Spot s = d.spot();
            if (s != null) {
                v.setName(s.getNameCn() != null && !s.getNameCn().isBlank()
                        ? s.getNameCn() : s.getName());
                v.setAnimeImageUrl(s.getImageUrl());
                if (s.getLatitude() != null) v.setLatitude(s.getLatitude().doubleValue());
                if (s.getLongitude() != null) v.setLongitude(s.getLongitude().doubleValue());
                v.setEpisodeNumber(s.getEpisode());
                v.setSceneTime(formatSceneTime(s.getSceneSeconds()));
            }
            v.setAuthorPhotos(d.authorPhotos() == null ? Collections.emptyList()
                    : d.authorPhotos().stream().map(AuthorPhotoVO::from).toList());
            return v;
        }

        private static String formatSceneTime(Integer seconds) {
            if (seconds == null) return null;
            return String.format("%d:%02d", seconds / 60, seconds % 60);
        }
    }

    @Data
    public static class AuthorPhotoVO {
        private Long id;
        private String photoUrl;
        private String content;
        private String createdAt;

        public static AuthorPhotoVO from(CheckIn ci) {
            AuthorPhotoVO v = new AuthorPhotoVO();
            v.setId(ci.getId());
            v.setPhotoUrl(ci.getPhotoUrl());
            v.setContent(ci.getContent());
            v.setCreatedAt(ci.getCreatedAt() == null ? null
                    : ci.getCreatedAt().toInstant(ZoneOffset.UTC).toString());
            return v;
        }
    }
}