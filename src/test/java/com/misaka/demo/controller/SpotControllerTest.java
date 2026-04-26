package com.misaka.demo.controller;

import com.misaka.demo.config.JwtAuthFilter;
import com.misaka.demo.config.SecurityConfig;
import com.misaka.demo.entity.Anime;
import com.misaka.demo.entity.Spot;
import com.misaka.demo.service.SpotService;
import com.misaka.demo.util.JwtUtil;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.FilterType;
import org.springframework.test.web.servlet.MockMvc;

import java.math.BigDecimal;
import java.util.List;

import static org.mockito.ArgumentMatchers.anyDouble;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(controllers = SpotController.class,
        excludeFilters = @ComponentScan.Filter(type = FilterType.ASSIGNABLE_TYPE,
                classes = {SecurityConfig.class, JwtAuthFilter.class}))
@AutoConfigureMockMvc(addFilters = false)
class SpotControllerTest {

    @Autowired private MockMvc mockMvc;

    @MockBean private SpotService spotService;
    @MockBean private JwtUtil jwtUtil;

    private static Spot spot(long id, int animeId, String name, double lat, double lng) {
        Spot s = new Spot();
        s.setId(id);
        s.setAnimeId(animeId);
        s.setName(name);
        s.setLatitude(BigDecimal.valueOf(lat));
        s.setLongitude(BigDecimal.valueOf(lng));
        return s;
    }

    @Test
    void nearby_returnsSpotVOListWithDefaultRadius() throws Exception {
        Anime a = new Anime();
        a.setTitleCn("中文");
        when(spotService.findNearby(eq(35.0), eq(139.0), eq(5000), anyInt()))
                .thenReturn(List.of(spot(1, 100, "A", 35.0, 139.0)));
        when(spotService.findAnime(100)).thenReturn(a);

        mockMvc.perform(get("/api/spots/nearby")
                        .param("latitude", "35.0")
                        .param("longitude", "139.0"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data[0].id").value(1))
                .andExpect(jsonPath("$.data[0].animeTitle").value("中文"));
    }

    @Test
    void nearby_passesExplicitRadius() throws Exception {
        when(spotService.findNearby(eq(35.0), eq(139.0), eq(1000), anyInt()))
                .thenReturn(List.of());

        mockMvc.perform(get("/api/spots/nearby")
                        .param("latitude", "35.0")
                        .param("longitude", "139.0")
                        .param("radius", "1000"))
                .andExpect(status().isOk());

        verify(spotService).findNearby(eq(35.0), eq(139.0), eq(1000), anyInt());
    }

    @Test
    void nearby_returnsEmptyArrayWhenNoSpots() throws Exception {
        when(spotService.findNearby(anyDouble(), anyDouble(), anyInt(), anyInt()))
                .thenReturn(List.of());

        mockMvc.perform(get("/api/spots/nearby")
                        .param("latitude", "0")
                        .param("longitude", "0"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.data.length()").value(0));
    }

    @Test
    void nearby_cachesAnimeLookupAcrossSpots() throws Exception {
        Anime a = new Anime();
        a.setTitleCn("中文");
        when(spotService.findNearby(anyDouble(), anyDouble(), anyInt(), anyInt()))
                .thenReturn(List.of(
                        spot(1, 100, "A", 35.0, 139.0),
                        spot(2, 100, "B", 35.1, 139.1),
                        spot(3, 100, "C", 35.2, 139.2)));
        when(spotService.findAnime(100)).thenReturn(a);

        mockMvc.perform(get("/api/spots/nearby")
                        .param("latitude", "35.0")
                        .param("longitude", "139.0"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.data.length()").value(3));

        // controller's HashMap-based cache → only one mapper call for the shared animeId
        verify(spotService, times(1)).findAnime(100);
    }

    @Test
    void detail_returnsSpotVO() throws Exception {
        Spot s = spot(1, 100, "聖地", 35.0, 139.0);
        Anime a = new Anime();
        a.setTitleCn("中文");
        when(spotService.findById(1L)).thenReturn(s);
        when(spotService.findAnime(100)).thenReturn(a);

        mockMvc.perform(get("/api/spots/{id}", 1))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.id").value(1))
                .andExpect(jsonPath("$.data.animeTitle").value("中文"))
                .andExpect(jsonPath("$.data.name").value("聖地"));
    }

    @Test
    void detail_returns404WhenSpotMissing() throws Exception {
        when(spotService.findById(99L)).thenReturn(null);

        mockMvc.perform(get("/api/spots/{id}", 99))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(404))
                .andExpect(jsonPath("$.message").value("取景地不存在"));
    }
}
