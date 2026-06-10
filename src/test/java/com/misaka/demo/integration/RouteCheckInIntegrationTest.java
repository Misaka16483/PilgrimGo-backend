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
 * 跨模块集成测试：路径上传与打卡互动
 * 覆盖成员 D 模块（Route/CheckIn Controller → Service → Mapper → H2 DB）
 * 路径/打卡接口需要登录（JwtAuthFilter 强制鉴权）
 */
@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
@DisplayName("路径与打卡集成测试")
public class RouteCheckInIntegrationTest {

    @Autowired private MockMvc mockMvc;
    @Autowired private ObjectMapper objectMapper;
    @Autowired private JdbcTemplate jdbcTemplate;

    private static int seqNum = 0;
    private String authToken;

    private static String shortUser() {
        return "ru" + (System.currentTimeMillis() % 100000) + "_" + (++seqNum);
    }

    @BeforeAll
    void seedAndLogin() throws Exception {
        // 插入测试用 anime + spot
        jdbcTemplate.update(
            "MERGE INTO anime (bangumi_id, title_cn, title_jp, points_count) VALUES (?, ?, ?, ?)",
            2001, "路径测试作品", "ルートテスト", 2);
        jdbcTemplate.update(
            "INSERT INTO spot (anime_id, anitabi_point_id, name, name_cn, latitude, longitude) " +
            "SELECT ?, ?, ?, ?, ?, ? WHERE NOT EXISTS (SELECT 1 FROM spot WHERE anitabi_point_id = ?)",
            2001, "rt-001", "Route Spot 1", "路径取景地1", 35.68, 139.69, "rt-001");
        jdbcTemplate.update(
            "INSERT INTO spot (anime_id, anitabi_point_id, name, name_cn, latitude, longitude) " +
            "SELECT ?, ?, ?, ?, ?, ? WHERE NOT EXISTS (SELECT 1 FROM spot WHERE anitabi_point_id = ?)",
            2001, "rt-002", "Route Spot 2", "路径取景地2", 35.70, 139.80, "rt-002");

        // 注册登录
        String username = shortUser();
        RegisterRequest reg = new RegisterRequest();
        reg.setUsername(username);
        reg.setPassword("password123");
        reg.setNickname("路径测试用户");

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
            authToken = (String) data.get("token");
            return;
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
        authToken = (String) loginData.get("token");
    }

    // ==================== 路径上传 ====================

    @Test
    @DisplayName("POST /api/routes - 上传路径成功")
    void uploadRoute_Success() throws Exception {
        String body = """
        {
            "animeId": 2001,
            "title": "秋叶原巡礼路径",
            "description": "从秋叶原站出发的巡礼路线",
            "trackPoints": [
                {"latitude":35.68, "longitude":139.69, "altitude":10.0, "timestamp":1700000000000},
                {"latitude":35.69, "longitude":139.70, "altitude":12.0, "timestamp":1700000001000},
                {"latitude":35.70, "longitude":139.80, "altitude":15.0, "timestamp":1700000002000}
            ],
            "waypoints": [
                {"location":{"latitude":35.68, "longitude":139.69}, "imageUrl":"", "description":"起点", "orderIndex":0},
                {"location":{"latitude":35.70, "longitude":139.80}, "imageUrl":"", "description":"终点", "orderIndex":1}
            ],
            "spotIds": [],
            "checkInIds": []
        }""";

        mockMvc.perform(post("/api/routes")
                .header("Authorization", "Bearer " + authToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(body))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.title").value("秋叶原巡礼路径"));
    }

    @Test
    @DisplayName("POST /api/routes - 未登录返回401")
    void uploadRoute_WithoutAuth() throws Exception {
        String body = """
        {
            "animeId": 2001,
            "title": "无认证路径",
            "trackPoints": [{"latitude":35.0, "longitude":139.0, "timestamp":1700000000000}],
            "waypoints": [],
            "spotIds": [],
            "checkInIds": []
        }""";

        // JwtAuthFilter 对 /api/routes 无白名单 → 401
        mockMvc.perform(post("/api/routes")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body))
                .andExpect(status().isUnauthorized());
    }

    // ==================== 路径查询 ====================

    @Test
    @DisplayName("GET /api/routes/{id} - 查看路径详情")
    void routeDetail() throws Exception {
        // 先上传一条路径获取 ID
        String body = """
        {
            "animeId": 2001,
            "title": "详情查询路径",
            "description": "测试",
            "trackPoints": [{"latitude":35.68, "longitude":139.69, "timestamp":1700000000000},{"latitude":35.69, "longitude":139.70, "timestamp":1700000001000}],
            "waypoints": [],
            "spotIds": [],
            "checkInIds": []
        }""";

        MvcResult result = mockMvc.perform(post("/api/routes")
                .header("Authorization", "Bearer " + authToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(body))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.id").isNumber())
                .andReturn();

        String resp = result.getResponse().getContentAsString();
        ApiResponse<?> apiResp = objectMapper.readValue(resp, ApiResponse.class);
        @SuppressWarnings("unchecked")
        java.util.Map<String, Object> data = (java.util.Map<String, Object>) apiResp.getData();
        int routeId = ((Number) data.get("id")).intValue();

        mockMvc.perform(get("/api/routes/{id}", routeId)
                .header("Authorization", "Bearer " + authToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.title").value("详情查询路径"));
    }

    @Test
    @DisplayName("GET /api/routes - 按作品列出路径（需登录）")
    void routeList_ByAnimeId() throws Exception {
        mockMvc.perform(get("/api/routes")
                .header("Authorization", "Bearer " + authToken)
                .param("animeId", "2001")
                .param("page", "0")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.content").isArray());
    }

    // ==================== 打卡功能 ====================

    @Test
    @DisplayName("POST /api/checkins - 创建打卡成功")
    void createCheckIn_Success() throws Exception {
        Long spotId = jdbcTemplate.queryForObject(
            "SELECT id FROM spot WHERE anitabi_point_id = 'rt-001'", Long.class);

        String body = String.format("""
        {
            "spotId": %d,
            "photoUrl": "https://img.example/photo.jpg",
            "content": "成功打卡！",
            "latitude": 35.68,
            "longitude": 139.69
        }""", spotId);

        mockMvc.perform(post("/api/checkins")
                .header("Authorization", "Bearer " + authToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(body))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    @Test
    @DisplayName("GET /api/checkins/feed - 获取动态流")
    void checkInFeed() throws Exception {
        mockMvc.perform(get("/api/checkins/feed")
                .header("Authorization", "Bearer " + authToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    @Test
    @DisplayName("POST /api/checkins/{id}/like - 点赞打卡")
    void checkInLike() throws Exception {
        Long spotId = jdbcTemplate.queryForObject(
            "SELECT id FROM spot WHERE anitabi_point_id = 'rt-001'", Long.class);

        // 先创建打卡
        String body = String.format("""
        {
            "spotId": %d,
            "photoUrl": "https://img.example/like_test.jpg",
            "content": "测试点赞",
            "latitude": 35.68,
            "longitude": 139.69
        }""", spotId);

        MvcResult result = mockMvc.perform(post("/api/checkins")
                .header("Authorization", "Bearer " + authToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(body))
                .andExpect(status().isOk())
                .andReturn();

        String resp = result.getResponse().getContentAsString();
        ApiResponse<?> apiResp = objectMapper.readValue(resp, ApiResponse.class);
        @SuppressWarnings("unchecked")
        java.util.Map<String, Object> data = (java.util.Map<String, Object>) apiResp.getData();
        int checkInId = ((Number) data.get("id")).intValue();

        // 点赞
        mockMvc.perform(post("/api/checkins/{id}/like", checkInId)
                .header("Authorization", "Bearer " + authToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    // ==================== 跨模块联动 ====================

    @Test
    @DisplayName("注册 → 登录 → 浏览作品 → 上传路径 → 打卡 → 查路径列表 全链路")
    void fullUserJourney() throws Exception {
        // 1. 浏览作品
        mockMvc.perform(get("/api/anime/{id}", 2001)
                .header("Authorization", "Bearer " + authToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));

        // 2. 获取取景地
        mockMvc.perform(get("/api/anime/{id}/spots", 2001)
                .header("Authorization", "Bearer " + authToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));

        // 3. 上传路径
        Long spotId = jdbcTemplate.queryForObject(
            "SELECT id FROM spot WHERE anitabi_point_id = 'rt-001'", Long.class);

        String routeBody = String.format("""
        {
            "animeId": 2001,
            "title": "全链路测试路径",
            "description": "端到端集成测试",
            "trackPoints": [
                {"latitude":35.68, "longitude":139.69, "timestamp":1700000000000},
                {"latitude":35.70, "longitude":139.80, "timestamp":1700000001000}
            ],
            "waypoints": [],
            "spotIds": [%d],
            "checkInIds": []
        }""", spotId);

        mockMvc.perform(post("/api/routes")
                .header("Authorization", "Bearer " + authToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(routeBody))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));

        // 4. 打卡
        String checkinBody = String.format("""
        {
            "spotId": %d,
            "photoUrl": "https://img.example/e2e.jpg",
            "content": "全链路打卡",
            "latitude": 35.68,
            "longitude": 139.69
        }""", spotId);

        mockMvc.perform(post("/api/checkins")
                .header("Authorization", "Bearer " + authToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(checkinBody))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));

        // 5. 查看路径列表
        mockMvc.perform(get("/api/routes")
                .header("Authorization", "Bearer " + authToken)
                .param("animeId", "2001")
                .param("page", "0")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));

        // 6. 查看动态流
        mockMvc.perform(get("/api/checkins/feed")
                .header("Authorization", "Bearer " + authToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }
}
