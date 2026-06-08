package com.misaka.demo.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.misaka.demo.dto.RouteUploadRequest;
import com.misaka.demo.dto.RouteUploadRequest.GeoPointDTO;
import com.misaka.demo.dto.RouteUploadRequest.TrackPointDTO;
import com.misaka.demo.dto.RouteUploadRequest.WaypointDTO;
import com.misaka.demo.entity.Anime;
import com.misaka.demo.entity.Route;
import com.misaka.demo.entity.RoutePoint;
import com.misaka.demo.entity.User;
import com.misaka.demo.entity.Waypoint;
import com.misaka.demo.service.RouteService;
import com.misaka.demo.util.JwtUtil;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc(addFilters = false)
class RouteControllerTest {

    @Autowired private MockMvc mockMvc;
    @Autowired private ObjectMapper objectMapper;

    @MockBean private RouteService routeService;
    @MockBean private JwtUtil jwtUtil;

    private static Route route(long id, long userId, int animeId) {
        Route r = new Route();
        r.setId(id);
        r.setUserId(userId);
        r.setAnimeId(animeId);
        r.setTitle("路径");
        r.setDescription("desc");
        r.setDistanceKm(new BigDecimal("0.20"));
        r.setEstimatedMinutes(5);
        r.setAvgRating(BigDecimal.ZERO);
        r.setRatingCount(0);
        r.setStatus("pending");
        r.setCreatedAt(LocalDateTime.of(2026, 5, 6, 12, 0, 0));
        return r;
    }

    private static User user(long id, String nickname) {
        User u = new User();
        u.setId(id);
        u.setNickname(nickname);
        return u;
    }

    private static Anime anime(int id, String titleCn) {
        Anime a = new Anime();
        a.setBangumiId(id);
        a.setTitleCn(titleCn);
        return a;
    }

    private static RoutePoint point(int seq, double lat, double lng) {
        RoutePoint p = new RoutePoint();
        p.setSequence(seq);
        p.setLatitude(BigDecimal.valueOf(lat));
        p.setLongitude(BigDecimal.valueOf(lng));
        return p;
    }

    private static Waypoint waypoint(double lat, double lng) {
        Waypoint w = new Waypoint();
        w.setLatitude(BigDecimal.valueOf(lat));
        w.setLongitude(BigDecimal.valueOf(lng));
        w.setPhotoUrl("img.png");
        w.setInstruction("desc");
        w.setWaypointType("photo");
        return w;
    }

    private static RouteUploadRequest sampleUploadBody() {
        RouteUploadRequest req = new RouteUploadRequest();
        req.setAnimeId(100);
        req.setTitle("路径一");
        TrackPointDTO p1 = new TrackPointDTO();
        p1.setLatitude(35.0);
        p1.setLongitude(139.0);
        p1.setTimestamp(1_000L);
        TrackPointDTO p2 = new TrackPointDTO();
        p2.setLatitude(35.001);
        p2.setLongitude(139.001);
        p2.setTimestamp(11_000L);
        req.setTrackPoints(List.of(p1, p2));
        WaypointDTO w = new WaypointDTO();
        GeoPointDTO loc = new GeoPointDTO();
        loc.setLatitude(35.0005);
        loc.setLongitude(139.0005);
        w.setLocation(loc);
        w.setOrderIndex(0);
        req.setWaypoints(List.of(w));
        return req;
    }

    @Test
    void upload_returnsRouteVOAndPullsRelatedDataFromService() throws Exception {
        Route saved = route(42L, 7L, 100);
        when(routeService.uploadRoute(eq(7L), any(RouteUploadRequest.class))).thenReturn(saved);
        when(routeService.findAnime(100)).thenReturn(anime(100, "中文标题"));
        when(routeService.findAuthor(7L)).thenReturn(user(7L, "Alice"));
        when(routeService.findPoints(42L))
                .thenReturn(List.of(point(0, 35.0, 139.0), point(1, 35.001, 139.001)));
        when(routeService.findWaypoints(42L)).thenReturn(List.of(waypoint(35.0005, 139.0005)));

        mockMvc.perform(post("/api/routes")
                        .requestAttr("userId", 7L)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(sampleUploadBody())))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.id").value(42))
                .andExpect(jsonPath("$.data.animeId").value(100))
                .andExpect(jsonPath("$.data.animeTitle").value("中文标题"))
                .andExpect(jsonPath("$.data.authorId").value(7))
                .andExpect(jsonPath("$.data.authorName").value("Alice"))
                .andExpect(jsonPath("$.data.title").value("路径"))
                .andExpect(jsonPath("$.data.trackPoints.length()").value(2))
                .andExpect(jsonPath("$.data.waypoints.length()").value(1))
                .andExpect(jsonPath("$.data.waypoints[0].orderIndex").value(0))
                .andExpect(jsonPath("$.data.distance").value(200.0))
                .andExpect(jsonPath("$.data.duration").value(300));
    }

    @Test
    void upload_returns400WhenServiceThrows() throws Exception {
        when(routeService.uploadRoute(any(), any(RouteUploadRequest.class)))
                .thenThrow(new RuntimeException("轨迹点不足，无法生成路径"));

        mockMvc.perform(post("/api/routes")
                        .requestAttr("userId", 7L)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(sampleUploadBody())))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(400))
                .andExpect(jsonPath("$.message").value("轨迹点不足，无法生成路径"))
                .andExpect(jsonPath("$.data").doesNotExist());
    }

    @Test
    void upload_passesNullUserIdWhenAttributeMissing() throws Exception {
        when(routeService.uploadRoute(eq(null), any(RouteUploadRequest.class)))
                .thenThrow(new RuntimeException("未登录"));

        mockMvc.perform(post("/api/routes")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(sampleUploadBody())))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(400))
                .andExpect(jsonPath("$.message").value("未登录"));
    }

    @Test
    void detail_returnsRouteVO() throws Exception {
        Route r = route(42L, 7L, 100);
        when(routeService.findById(42L)).thenReturn(r);
        when(routeService.findAnime(100)).thenReturn(anime(100, "中文"));
        when(routeService.findAuthor(7L)).thenReturn(user(7L, "Alice"));
        when(routeService.findPoints(42L)).thenReturn(List.of(point(0, 35.0, 139.0)));
        when(routeService.findWaypoints(42L)).thenReturn(List.of());

        mockMvc.perform(get("/api/routes/{id}", 42))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.id").value(42))
                .andExpect(jsonPath("$.data.animeTitle").value("中文"))
                .andExpect(jsonPath("$.data.authorName").value("Alice"))
                .andExpect(jsonPath("$.data.trackPoints.length()").value(1))
                .andExpect(jsonPath("$.data.waypoints.length()").value(0))
                .andExpect(jsonPath("$.data.spotCount").value(0));
    }

    @Test
    void detail_returns404WhenRouteMissing() throws Exception {
        when(routeService.findById(99L)).thenReturn(null);

        mockMvc.perform(get("/api/routes/{id}", 99))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(404))
                .andExpect(jsonPath("$.message").value("路径不存在"))
                .andExpect(jsonPath("$.data").doesNotExist());
    }
}
