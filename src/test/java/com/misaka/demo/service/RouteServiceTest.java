package com.misaka.demo.service;

import com.misaka.demo.dto.RouteUploadRequest;
import com.misaka.demo.dto.RouteUploadRequest.GeoPointDTO;
import com.misaka.demo.dto.RouteUploadRequest.TrackPointDTO;
import com.misaka.demo.dto.RouteUploadRequest.WaypointDTO;
import com.misaka.demo.entity.Route;
import com.misaka.demo.entity.RoutePoint;
import com.misaka.demo.entity.Waypoint;
import com.misaka.demo.mapper.AnimeMapper;
import com.misaka.demo.mapper.RouteMapper;
import com.misaka.demo.mapper.RoutePointMapper;
import com.misaka.demo.mapper.UserMapper;
import com.misaka.demo.mapper.WaypointMapper;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;

@ExtendWith(MockitoExtension.class)
class RouteServiceTest {

    @Mock private RouteMapper routeMapper;
    @Mock private RoutePointMapper routePointMapper;
    @Mock private WaypointMapper waypointMapper;
    @Mock private AnimeMapper animeMapper;
    @Mock private UserMapper userMapper;

    @InjectMocks private RouteService routeService;

    private static TrackPointDTO point(double lat, double lng, long ts) {
        TrackPointDTO p = new TrackPointDTO();
        p.setLatitude(lat);
        p.setLongitude(lng);
        p.setTimestamp(ts);
        return p;
    }

    private static WaypointDTO waypoint(double lat, double lng, Integer order, String img, String desc) {
        WaypointDTO w = new WaypointDTO();
        GeoPointDTO loc = new GeoPointDTO();
        loc.setLatitude(lat);
        loc.setLongitude(lng);
        w.setLocation(loc);
        w.setOrderIndex(order);
        w.setImageUrl(img);
        w.setDescription(desc);
        return w;
    }

    private static RouteUploadRequest baseRequest() {
        RouteUploadRequest req = new RouteUploadRequest();
        req.setAnimeId(100);
        req.setTitle("路径一");
        req.setDescription("desc");
        req.setTrackPoints(new ArrayList<>(List.of(
                point(35.0, 139.0, 1_000L),
                point(35.001, 139.001, 11_000L))));
        req.setWaypoints(new ArrayList<>());
        return req;
    }

    @Test
    void uploadRoute_persistsRouteAndPointsAndWaypoints() {
        RouteUploadRequest req = baseRequest();
        req.getWaypoints().add(waypoint(35.0005, 139.0005, 0, "img.png", "中点"));

        Route saved = routeService.uploadRoute(7L, req);

        assertNotNull(saved);
        assertEquals(7L, saved.getUserId());
        assertEquals(100, saved.getAnimeId());
        assertEquals("路径一", saved.getTitle());
        assertEquals("desc", saved.getDescription());
        // 距离 ≈ 158m → 0.16km(四舍五入到两位)
        assertTrue(saved.getDistanceKm().doubleValue() > 0);
        // 末-首时间戳 = 10s → estimated_minutes 至少为 1
        assertEquals(1, saved.getEstimatedMinutes());
        assertEquals("pending", saved.getStatus());
        assertNotNull(saved.getRecordedAt());
        assertNotNull(saved.getCreatedAt());

        verify(routeMapper).insert(any(Route.class));
        verify(routePointMapper, times(2)).insert(any(RoutePoint.class));
        verify(waypointMapper, times(1)).insert(any(Waypoint.class));
    }

    @Test
    void uploadRoute_throwsWhenUserIdMissing() {
        RouteUploadRequest req = baseRequest();
        RuntimeException ex = assertThrows(RuntimeException.class,
                () -> routeService.uploadRoute(null, req));
        assertEquals("未登录", ex.getMessage());
        verify(routeMapper, never()).insert(any(Route.class));
    }

    @Test
    void uploadRoute_throwsWhenAnimeIdMissing() {
        RouteUploadRequest req = baseRequest();
        req.setAnimeId(null);
        RuntimeException ex = assertThrows(RuntimeException.class,
                () -> routeService.uploadRoute(1L, req));
        assertEquals("缺少动画 ID", ex.getMessage());
    }

    @Test
    void uploadRoute_throwsWhenTitleBlank() {
        RouteUploadRequest req = baseRequest();
        req.setTitle("   ");
        RuntimeException ex = assertThrows(RuntimeException.class,
                () -> routeService.uploadRoute(1L, req));
        assertEquals("路径标题不能为空", ex.getMessage());
    }

    @Test
    void uploadRoute_throwsWhenTrackPointsTooFew() {
        RouteUploadRequest req = baseRequest();
        req.setTrackPoints(List.of(point(35.0, 139.0, 0)));
        RuntimeException ex = assertThrows(RuntimeException.class,
                () -> routeService.uploadRoute(1L, req));
        assertEquals("轨迹点不足，无法生成路径", ex.getMessage());
    }

    @Test
    void uploadRoute_throwsWhenTrackPointsNull() {
        RouteUploadRequest req = baseRequest();
        req.setTrackPoints(null);
        assertThrows(RuntimeException.class,
                () -> routeService.uploadRoute(1L, req));
    }

    @Test
    void uploadRoute_skipsTrackPointsMissingLatLng() {
        RouteUploadRequest req = baseRequest();
        TrackPointDTO bad = new TrackPointDTO();
        bad.setTimestamp(2_000L);
        req.getTrackPoints().add(bad); // 第三个点缺经纬度，应被跳过

        routeService.uploadRoute(1L, req);

        // 只插入两个有效点
        verify(routePointMapper, times(2)).insert(any(RoutePoint.class));
    }

    @Test
    void uploadRoute_skipsWaypointsMissingLocation() {
        RouteUploadRequest req = baseRequest();
        WaypointDTO noLoc = new WaypointDTO();
        noLoc.setOrderIndex(0);
        WaypointDTO partialLoc = new WaypointDTO();
        GeoPointDTO incomplete = new GeoPointDTO();
        incomplete.setLatitude(35.0); // 缺 lng
        partialLoc.setLocation(incomplete);
        req.getWaypoints().add(noLoc);
        req.getWaypoints().add(partialLoc);

        routeService.uploadRoute(1L, req);

        verify(waypointMapper, never()).insert(any(Waypoint.class));
    }

    @Test
    void uploadRoute_waypointSequenceFallsBackToIndexWhenOrderIndexMissing() {
        RouteUploadRequest req = baseRequest();
        req.getWaypoints().add(waypoint(35.0, 139.0, null, null, null));
        req.getWaypoints().add(waypoint(35.001, 139.001, null, null, null));

        ArgumentCaptor<Waypoint> cap = ArgumentCaptor.forClass(Waypoint.class);
        routeService.uploadRoute(1L, req);

        verify(waypointMapper, times(2)).insert(cap.capture());
        List<Waypoint> saved = cap.getAllValues();
        assertEquals(0, saved.get(0).getSequence());
        assertEquals(1, saved.get(1).getSequence());
        assertEquals("photo", saved.get(0).getWaypointType());
    }

    @Test
    void uploadRoute_capturesRouteIdOnPointsAndWaypoints() {
        RouteUploadRequest req = baseRequest();
        req.getWaypoints().add(waypoint(35.0, 139.0, 0, null, null));

        // 模拟 MyBatis-Plus 在 insert 后回填主键
        org.mockito.Mockito.doAnswer(inv -> {
            Route r = inv.getArgument(0);
            r.setId(42L);
            return 1;
        }).when(routeMapper).insert(any(Route.class));

        routeService.uploadRoute(1L, req);

        ArgumentCaptor<RoutePoint> rpCap = ArgumentCaptor.forClass(RoutePoint.class);
        verify(routePointMapper, times(2)).insert(rpCap.capture());
        rpCap.getAllValues().forEach(rp -> assertEquals(42L, rp.getRouteId()));

        ArgumentCaptor<Waypoint> wpCap = ArgumentCaptor.forClass(Waypoint.class);
        verify(waypointMapper).insert(wpCap.capture());
        assertEquals(42L, wpCap.getValue().getRouteId());
    }

    @Test
    void uploadRoute_zeroDurationWhenTimestampsMissingOrInvalid() {
        RouteUploadRequest req = baseRequest();
        // 末 <= 首，应回退为 0；estimated_minutes 至少为 1（Math.max 兜底）
        req.getTrackPoints().get(0).setTimestamp(5_000L);
        req.getTrackPoints().get(1).setTimestamp(5_000L);

        Route saved = routeService.uploadRoute(1L, req);
        assertEquals(1, saved.getEstimatedMinutes());
    }

    @Test
    void uploadRoute_handlesNullWaypointsList() {
        RouteUploadRequest req = baseRequest();
        req.setWaypoints(null);

        routeService.uploadRoute(1L, req);

        verify(waypointMapper, never()).insert(any(Waypoint.class));
    }

    @Test
    void findById_delegatesToMapper() {
        Route r = new Route();
        r.setId(7L);
        org.mockito.Mockito.when(routeMapper.selectById(7L)).thenReturn(r);
        assertSame(r, routeService.findById(7L));
    }

    @Test
    void findPoints_delegatesToMapper() {
        List<RoutePoint> pts = List.of(new RoutePoint());
        org.mockito.Mockito.when(routePointMapper.selectByRouteId(7L)).thenReturn(pts);
        assertSame(pts, routeService.findPoints(7L));
    }

    @Test
    void findWaypoints_delegatesToMapper() {
        List<Waypoint> wps = List.of(new Waypoint());
        org.mockito.Mockito.when(waypointMapper.selectByRouteId(7L)).thenReturn(wps);
        assertSame(wps, routeService.findWaypoints(7L));
    }

    @Test
    void findAnime_delegatesToMapper() {
        com.misaka.demo.entity.Anime a = new com.misaka.demo.entity.Anime();
        org.mockito.Mockito.when(animeMapper.selectById(99)).thenReturn(a);
        assertSame(a, routeService.findAnime(99));
    }

    @Test
    void findAuthor_delegatesToMapper() {
        com.misaka.demo.entity.User u = new com.misaka.demo.entity.User();
        org.mockito.Mockito.when(userMapper.selectById(7L)).thenReturn(u);
        assertSame(u, routeService.findAuthor(7L));
    }
}
