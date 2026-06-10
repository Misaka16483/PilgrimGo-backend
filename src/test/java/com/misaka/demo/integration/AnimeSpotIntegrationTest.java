package com.misaka.demo.integration;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.misaka.demo.dto.ApiResponse;
import com.misaka.demo.dto.LoginRequest;
import com.misaka.demo.dto.RegisterRequest;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * 跨模块集成测试：作品浏览、取景地浏览
 * 覆盖成员 B/C 模块的核心 API 通路（Anime/Spot Controller → Service → Mapper → H2 DB）
 */
@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
@DisplayName("作品与取景地集成测试")
public class AnimeSpotIntegrationTest {

    @Autowired private MockMvc mockMvc;
    @Autowired private ObjectMapper objectMapper;
    @Autowired private JdbcTemplate jdbcTemplate;

    private static int seqNum = 0;

    private static String shortUser() {
        return "tu" + (System.currentTimeMillis() % 100000) + "_" + (++seqNum);
    }

    @BeforeAll
    void seedData() {
        // 插入测试用的 anime 数据
        jdbcTemplate.update(
            "MERGE INTO anime (bangumi_id, title_cn, title_jp, points_count) VALUES (?, ?, ?, ?)",
            1001, "测试作品一", "テスト作品一", 3);
        jdbcTemplate.update(
            "MERGE INTO anime (bangumi_id, title_cn, title_jp, points_count) VALUES (?, ?, ?, ?)",
            1002, "测试作品二", "テスト作品二", 0);
        jdbcTemplate.update(
            "MERGE INTO anime (bangumi_id, title_cn, title_jp, points_count) VALUES (?, ?, ?, ?)",
            1003, "灌篮高手测试", "SLAM DUNK", 2);

        // 插入测试用的 spot 数据
        jdbcTemplate.update(
            "INSERT INTO spot (anime_id, anitabi_point_id, name, name_cn, latitude, longitude, episode, scene_seconds) " +
            "SELECT ?, ?, ?, ?, ?, ?, ?, ? WHERE NOT EXISTS (SELECT 1 FROM spot WHERE anitabi_point_id = ?)",
            1001, "sp-001", "Spot A", "取景地A", 35.6895, 139.6917, 1, 120, "sp-001");
        jdbcTemplate.update(
            "INSERT INTO spot (anime_id, anitabi_point_id, name, name_cn, latitude, longitude, episode, scene_seconds) " +
            "SELECT ?, ?, ?, ?, ?, ?, ?, ? WHERE NOT EXISTS (SELECT 1 FROM spot WHERE anitabi_point_id = ?)",
            1001, "sp-002", "Spot B", "取景地B", 35.7100, 139.8100, 3, 300, "sp-002");
        jdbcTemplate.update(
            "INSERT INTO spot (anime_id, anitabi_point_id, name, name_cn, latitude, longitude, episode, scene_seconds) " +
            "SELECT ?, ?, ?, ?, ?, ?, ?, ? WHERE NOT EXISTS (SELECT 1 FROM spot WHERE anitabi_point_id = ?)",
            1003, "sp-003", "Spot C", "取景地C", 35.6500, 139.7000, 1, 60, "sp-003");
    }

    // ==================== 作品浏览（公开接口，无需认证） ====================

    @Test
    @DisplayName("GET /api/anime - 无关键词搜索返回全部作品")
    void animeList_NoKeyword() throws Exception {
        mockMvc.perform(get("/api/anime")
                .param("page", "0")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.content").isArray());
    }

    @Test
    @DisplayName("GET /api/anime - 关键词搜索匹配中文名")
    void animeList_KeywordMatchCN() throws Exception {
        mockMvc.perform(get("/api/anime")
                .param("keyword", "灌篮高手")
                .param("page", "0")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.content").isArray());
    }

    @Test
    @DisplayName("GET /api/anime/{id} - 作品详情存在")
    void animeDetail_Found() throws Exception {
        mockMvc.perform(get("/api/anime/{id}", 1001))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.title").value("测试作品一"));
    }

    @Test
    @DisplayName("GET /api/anime/{id} - 作品不存在")
    void animeDetail_NotFound() throws Exception {
        mockMvc.perform(get("/api/anime/{id}", 99999))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(404));
    }

    // ==================== 取景地浏览（公开接口） ====================

    @Test
    @DisplayName("GET /api/anime/{id}/spots - 获取作品取景地列表")
    void animeSpots_ReturnsList() throws Exception {
        mockMvc.perform(get("/api/anime/{id}/spots", 1001))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data").isArray());
    }

    @Test
    @DisplayName("GET /api/spots/{id} - 取景地详情")
    void spotDetail_Found() throws Exception {
        // 获取第一个 spot 的 ID
        Long spotId = jdbcTemplate.queryForObject(
            "SELECT id FROM spot WHERE anitabi_point_id = 'sp-001'", Long.class);

        // SpotVO.name 优先取 nameCn，所以这里显示中文名
        mockMvc.perform(get("/api/spots/{id}", spotId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.name").value("取景地A"));
    }

    @Test
    @DisplayName("GET /api/spots/{id} - 取景地不存在")
    void spotDetail_NotFound() throws Exception {
        mockMvc.perform(get("/api/spots/{id}", 99999))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(404));
    }

    @Test
    @DisplayName("GET /api/spots/map - 地图范围查询")
    @org.junit.jupiter.api.Disabled("H2 不支持 PostGIS 空间函数 (selectInBounds/selectClustersInBounds)，需 Testcontainers PostgreSQL 环境")
    void mapItems() throws Exception {
        mockMvc.perform(get("/api/spots/map")
                .param("minLat", "35.0")
                .param("maxLat", "36.0")
                .param("minLng", "139.0")
                .param("maxLng", "140.0"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    // ==================== 认证 + 作品联动 ====================

    @Test
    @DisplayName("登录后浏览作品详情")
    void loginThenBrowseAnime() throws Exception {
        String token = registerAndLogin();

        mockMvc.perform(get("/api/anime/{id}", 1001)
                .header("Authorization", "Bearer " + token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    private String registerAndLogin() throws Exception {
        String username = shortUser();
        RegisterRequest reg = new RegisterRequest();
        reg.setUsername(username);
        reg.setPassword("password123");
        reg.setNickname("集成测试用户");

        MvcResult result = mockMvc.perform(post("/api/auth/register")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(reg)))
                .andExpect(status().isOk())
                .andReturn();

        String resp = result.getResponse().getContentAsString();
        ApiResponse<?> apiResp = objectMapper.readValue(resp, ApiResponse.class);
        @SuppressWarnings("unchecked")
        java.util.Map<String, Object> data = (java.util.Map<String, Object>) apiResp.getData();
        if (data != null && data.containsKey("token")) {
            return (String) data.get("token");
        }

        LoginRequest login = new LoginRequest();
        login.setUsername(username);
        login.setPassword("password123");
        result = mockMvc.perform(post("/api/auth/login")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(login)))
                .andExpect(status().isOk())
                .andReturn();
        resp = result.getResponse().getContentAsString();
        apiResp = objectMapper.readValue(resp, ApiResponse.class);
        @SuppressWarnings("unchecked")
        java.util.Map<String, Object> loginData = (java.util.Map<String, Object>) apiResp.getData();
        return (String) loginData.get("token");
    }
}
