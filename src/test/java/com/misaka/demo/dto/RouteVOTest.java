package com.misaka.demo.dto;

import com.misaka.demo.entity.Anime;
import com.misaka.demo.entity.Route;
import com.misaka.demo.entity.RoutePoint;
import com.misaka.demo.entity.RouteSpot;
import com.misaka.demo.entity.Spot;
import com.misaka.demo.entity.User;
import com.misaka.demo.entity.Waypoint;
import com.misaka.demo.service.RouteService;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class RouteVOTest {

    private Route baseRoute() {
        Route r = new Route();
        r.setId(42L);
        r.setUserId(7L);
        r.setAnimeId(100);
        r.setTitle("路径一");
        r.setDescription("desc");
        r.setDistanceKm(new BigDecimal("1.50"));
        r.setEstimatedMinutes(30);
        r.setAvgRating(new BigDecimal("4.5"));
        r.setRatingCount(12);
        r.setCreatedAt(LocalDateTime.of(2026, 5, 6, 12, 0, 0));
        return r;
    }

    private RoutePoint point(double lat, double lng, Double alt, LocalDateTime ts) {
        RoutePoint p = new RoutePoint();
        p.setLatitude(BigDecimal.valueOf(lat));
        p.setLongitude(BigDecimal.valueOf(lng));
        if (alt != null) p.setAltitude(BigDecimal.valueOf(alt));
        p.setRecordedAt(ts);
        return p;
    }

    private Waypoint waypoint(double lat, double lng, String img, String desc) {
        Waypoint w = new Waypoint();
        w.setId(11L);
        w.setLatitude(BigDecimal.valueOf(lat));
        w.setLongitude(BigDecimal.valueOf(lng));
        w.setPhotoUrl(img);
        w.setInstruction(desc);
        return w;
    }

    private RouteService.RouteSpotDetail spotDetail(long spotId, int visitOrder, String nameCn) {
        RouteSpot rs = new RouteSpot();
        rs.setSpotId(spotId);
        rs.setVisitOrder(visitOrder);
        Spot s = new Spot();
        s.setId(spotId);
        s.setNameCn(nameCn);
        return new RouteService.RouteSpotDetail(rs, s, List.of());
    }

    @Test
    void from_mapsAllFields() {
        Anime a = new Anime();
        a.setBangumiId(100);
        a.setTitleCn("中文");
        a.setTitleJp("日文");
        User author = new User();
        author.setId(7L);
        author.setNickname("Alice");

        RouteVO vo = RouteVO.from(
                baseRoute(),
                a,
                author,
                List.of(point(35.0, 139.0, 12.5, LocalDateTime.of(2026, 5, 6, 12, 0, 0))),
                List.of(waypoint(35.001, 139.001, "img.png", "看点")),
                List.of(spotDetail(500L, 0, "圣地一")));

        assertEquals(42L, vo.getId());
        assertEquals(100, vo.getAnimeId());
        assertEquals("中文", vo.getAnimeTitle());
        assertEquals(7L, vo.getAuthorId());
        assertEquals("Alice", vo.getAuthorName());
        assertEquals("路径一", vo.getTitle());
        assertEquals("desc", vo.getDescription());
        assertEquals(1500.0, vo.getDistance(), 1e-3); // km → m
        assertEquals(1800L, vo.getDuration()); // 30 分钟 → 1800 秒
        assertEquals(4.5, vo.getRating(), 1e-3);
        assertEquals(12, vo.getRatingCount());
        assertEquals(1, vo.getSpotCount()); // 由关联观景点 spots.size() 推导
        assertEquals(1, vo.getSpots().size());
        assertEquals(500L, vo.getSpots().get(0).getSpotId());
        assertEquals("圣地一", vo.getSpots().get(0).getName());
        assertNotNull(vo.getCreatedAt());

        assertEquals(1, vo.getTrackPoints().size());
        assertEquals(35.0, vo.getTrackPoints().get(0).getLatitude(), 1e-7);
        assertEquals(12.5, vo.getTrackPoints().get(0).getAltitude(), 1e-3);

        assertEquals(1, vo.getWaypoints().size());
        assertEquals(11L, vo.getWaypoints().get(0).getId());
        assertEquals(0, vo.getWaypoints().get(0).getOrderIndex()); // 由列表索引派生
        assertEquals("img.png", vo.getWaypoints().get(0).getImageUrl());
        assertEquals("看点", vo.getWaypoints().get(0).getDescription());
    }

    @Test
    void from_fallsBackToJapaneseAnimeTitleWhenChineseBlank() {
        Anime a = new Anime();
        a.setTitleCn(" ");
        a.setTitleJp("ja-only");

        RouteVO vo = RouteVO.from(baseRoute(), a, null, List.of(), List.of(), List.of());

        assertEquals("ja-only", vo.getAnimeTitle());
        assertNull(vo.getAuthorName());
    }

    @Test
    void from_handlesNullAnimeAndAuthor() {
        RouteVO vo = RouteVO.from(baseRoute(), null, null, List.of(), List.of(), null);
        assertNull(vo.getAnimeTitle());
        assertNull(vo.getAuthorName());
        assertTrue(vo.getSpots().isEmpty()); // null spotDetails → 空列表
        assertEquals(0, vo.getSpotCount());
    }

    @Test
    void from_handlesNullDistanceAndRatingFields() {
        Route r = baseRoute();
        r.setDistanceKm(null);
        r.setEstimatedMinutes(null);
        r.setAvgRating(null);
        r.setRatingCount(null);
        r.setCreatedAt(null);

        RouteVO vo = RouteVO.from(r, null, null, List.of(), List.of(), List.of());

        assertEquals(0.0, vo.getDistance(), 1e-9);
        assertEquals(0L, vo.getDuration());
        assertEquals(0.0, vo.getRating(), 1e-9);
        assertEquals(0, vo.getRatingCount());
        assertNull(vo.getCreatedAt());
    }

    @Test
    void from_orderIndexesWaypointsByListPosition() {
        List<Waypoint> wps = List.of(
                waypoint(35.0, 139.0, null, null),
                waypoint(35.1, 139.1, null, null),
                waypoint(35.2, 139.2, null, null));

        RouteVO vo = RouteVO.from(baseRoute(), null, null, List.of(), wps, List.of());

        assertEquals(3, vo.getWaypoints().size());
        assertEquals(0, vo.getWaypoints().get(0).getOrderIndex());
        assertEquals(1, vo.getWaypoints().get(1).getOrderIndex());
        assertEquals(2, vo.getWaypoints().get(2).getOrderIndex());
    }

    @Test
    void from_pointWithoutCoordinatesSerializesAsZero() {
        RoutePoint blank = new RoutePoint(); // 全部 null

        RouteVO vo = RouteVO.from(baseRoute(), null, null, List.of(blank), List.of(), List.of());

        assertEquals(1, vo.getTrackPoints().size());
        assertEquals(0.0, vo.getTrackPoints().get(0).getLatitude(), 1e-9);
        assertEquals(0.0, vo.getTrackPoints().get(0).getLongitude(), 1e-9);
        assertEquals(0L, vo.getTrackPoints().get(0).getTimestamp());
        assertNull(vo.getTrackPoints().get(0).getAltitude());
    }
}
