package com.misaka.demo.controller;

import com.misaka.demo.config.JwtAuthFilter;
import com.misaka.demo.config.SecurityConfig;
import com.misaka.demo.dto.MapAnimeOptionVO;
import com.misaka.demo.dto.SpotMapItemVO;
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

import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

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
    void mapItems_returnsLayeredMapItems() throws Exception {
        SpotMapItemVO item = new SpotMapItemVO();
        item.setType("cluster");
        item.setCount(12);
        item.setLatitude(35.0);
        item.setLongitude(139.0);
        when(spotService.findMapItems(
                eq(30.0), eq(40.0), eq(130.0), eq(145.0), eq(6.0), eq(180), eq(null)))
                .thenReturn(List.of(item));

        mockMvc.perform(get("/api/spots/map")
                        .param("minLat", "30")
                        .param("maxLat", "40")
                        .param("minLng", "130")
                        .param("maxLng", "145")
                        .param("zoom", "6"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data[0].type").value("cluster"))
                .andExpect(jsonPath("$.data[0].count").value(12));
    }

    @Test
    void mapItems_passesAnimeFilter() throws Exception {
        SpotMapItemVO item = new SpotMapItemVO();
        item.setType("spot");
        item.setId(7L);
        item.setLatitude(35.0);
        item.setLongitude(139.0);
        when(spotService.findMapItems(
                eq(30.0), eq(40.0), eq(130.0), eq(145.0), eq(13.0), eq(180), eq(215425)))
                .thenReturn(List.of(item));

        mockMvc.perform(get("/api/spots/map")
                        .param("minLat", "30")
                        .param("maxLat", "40")
                        .param("minLng", "130")
                        .param("maxLng", "145")
                        .param("zoom", "13")
                        .param("animeId", "215425"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data[0].type").value("spot"))
                .andExpect(jsonPath("$.data[0].id").value(7));
    }

    @Test
    void mapAnimeOptions_returnsDisplayableAnime() throws Exception {
        MapAnimeOptionVO option = new MapAnimeOptionVO();
        option.setId(328609);
        option.setTitle("孤独摇滚！");
        when(spotService.findMapAnimeOptions(eq(50))).thenReturn(List.of(option));

        mockMvc.perform(get("/api/spots/map/anime"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data[0].id").value(328609))
                .andExpect(jsonPath("$.data[0].title").value("孤独摇滚！"));
    }

    @Test
    void detail_returnsSpotVO() throws Exception {
        Spot s = spot(1, 100, "圣地", 35.0, 139.0);
        Anime a = new Anime();
        a.setTitleCn("中文");
        when(spotService.findById(1L)).thenReturn(s);
        when(spotService.findAnime(100)).thenReturn(a);

        mockMvc.perform(get("/api/spots/{id}", 1))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.id").value(1))
                .andExpect(jsonPath("$.data.animeTitle").value("中文"))
                .andExpect(jsonPath("$.data.name").value("圣地"));
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
