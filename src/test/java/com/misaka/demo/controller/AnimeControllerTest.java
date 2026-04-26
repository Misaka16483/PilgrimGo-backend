package com.misaka.demo.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.misaka.demo.config.JwtAuthFilter;
import com.misaka.demo.config.SecurityConfig;
import com.misaka.demo.entity.Anime;
import com.misaka.demo.entity.Spot;
import com.misaka.demo.service.AnimeService;
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

import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyBoolean;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(controllers = AnimeController.class,
        excludeFilters = @ComponentScan.Filter(type = FilterType.ASSIGNABLE_TYPE,
                classes = {SecurityConfig.class, JwtAuthFilter.class}))
@AutoConfigureMockMvc(addFilters = false)
class AnimeControllerTest {

    @Autowired private MockMvc mockMvc;

    @MockBean private AnimeService animeService;
    @MockBean private SpotService spotService;
    @MockBean private JwtUtil jwtUtil;

    private static Anime anime(int id, String cn, String jp, int spots) {
        Anime a = new Anime();
        a.setBangumiId(id);
        a.setTitleCn(cn);
        a.setTitleJp(jp);
        a.setPointsCount(spots);
        return a;
    }

    @Test
    void list_returnsPageResultMappedToAnimeVO() throws Exception {
        Page<Anime> page = new Page<>(1, 20);
        page.setRecords(List.of(anime(1, "中文", "ja", 5)));
        page.setTotal(1);
        when(animeService.search("kw", 0, 20)).thenReturn(page);

        mockMvc.perform(get("/api/anime").param("keyword", "kw"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.content[0].id").value(1))
                .andExpect(jsonPath("$.data.content[0].title").value("中文"))
                .andExpect(jsonPath("$.data.content[0].spotCount").value(5))
                .andExpect(jsonPath("$.data.totalElements").value(1))
                .andExpect(jsonPath("$.data.number").value(0))
                .andExpect(jsonPath("$.data.last").value(true));
    }

    @Test
    void list_usesDefaultPageAndSizeWhenOmitted() throws Exception {
        Page<Anime> page = new Page<>(1, 20);
        page.setRecords(List.of());
        page.setTotal(0);
        when(animeService.search(eq(null), eq(0), eq(20))).thenReturn(page);

        mockMvc.perform(get("/api/anime"))
                .andExpect(status().isOk());

        verify(animeService).search(null, 0, 20);
    }

    @Test
    void detail_returnsAnimeVO() throws Exception {
        when(animeService.findById(123)).thenReturn(anime(123, "中文", "ja", 3));

        mockMvc.perform(get("/api/anime/{id}", 123))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.id").value(123))
                .andExpect(jsonPath("$.data.title").value("中文"))
                .andExpect(jsonPath("$.data.spotCount").value(3));
    }

    @Test
    void detail_returns404WhenAnimeMissing() throws Exception {
        when(animeService.findById(999)).thenReturn(null);

        mockMvc.perform(get("/api/anime/{id}", 999))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(404))
                .andExpect(jsonPath("$.message").value("作品不存在或暂无巡礼数据"));
    }

    @Test
    void spots_returnsSpotVOListWithAnimeTitle() throws Exception {
        Anime a = anime(1, "中文", "ja", 1);
        Spot s = new Spot();
        s.setId(11L);
        s.setAnimeId(1);
        s.setName("聖地A");
        s.setLatitude(new BigDecimal("35.0"));
        s.setLongitude(new BigDecimal("139.0"));
        when(animeService.findById(1)).thenReturn(a);
        when(spotService.findByAnimeId(1, false)).thenReturn(List.of(s));

        mockMvc.perform(get("/api/anime/{id}/spots", 1))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data[0].id").value(11))
                .andExpect(jsonPath("$.data[0].animeId").value(1))
                .andExpect(jsonPath("$.data[0].animeTitle").value("中文"))
                .andExpect(jsonPath("$.data[0].name").value("聖地A"))
                .andExpect(jsonPath("$.data[0].latitude").value(35.0))
                .andExpect(jsonPath("$.data[0].longitude").value(139.0));
    }

    @Test
    void spots_passesForceParamThrough() throws Exception {
        when(animeService.findById(anyInt())).thenReturn(anime(1, "中文", "ja", 0));
        when(spotService.findByAnimeId(eq(1), eq(true))).thenReturn(List.of());

        mockMvc.perform(get("/api/anime/{id}/spots", 1).param("force", "true"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.data.length()").value(0));

        verify(spotService).findByAnimeId(1, true);
    }

    @Test
    void spots_returnsEmptyListWhenNoSpots() throws Exception {
        when(animeService.findById(1)).thenReturn(null);
        when(spotService.findByAnimeId(eq(1), anyBoolean())).thenReturn(List.of());

        mockMvc.perform(get("/api/anime/{id}/spots", 1))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.length()").value(0));
    }
}
