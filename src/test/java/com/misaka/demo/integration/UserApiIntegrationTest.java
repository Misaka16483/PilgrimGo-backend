package com.misaka.demo.integration;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.misaka.demo.dto.ApiResponse;
import com.misaka.demo.dto.LoginRequest;
import com.misaka.demo.dto.RegisterRequest;
import com.misaka.demo.dto.UserStatsVO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * 成员A - 用户相关API集成测试
 * 使用H2内存数据库，完全隔离生产环境
 */
@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
@Transactional
@DisplayName("用户API集成测试")
public class UserApiIntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    private String authToken;
    private Long userId;

    /** 生成短用户名，避免超出 RegisterRequest @Size(max=20) */
    private static String shortUser(String prefix) {
        return prefix + (System.currentTimeMillis() % 100000);
    }

    @BeforeEach
    void setUp() throws Exception {
        RegisterRequest registerRequest = new RegisterRequest();
        registerRequest.setUsername(shortUser("tu"));
        registerRequest.setPassword("password123");
        registerRequest.setNickname("测试用户");

        MvcResult result = mockMvc.perform(post("/api/auth/register")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(registerRequest)))
                .andExpect(status().isOk())
                .andReturn();

        String response = result.getResponse().getContentAsString();
        ApiResponse<?> apiResponse = objectMapper.readValue(response, ApiResponse.class);
    }

    // ==================== 认证接口测试 ====================

    @Test
    @DisplayName("POST /api/auth/register - 用户注册成功")
    void register_Success() throws Exception {
        RegisterRequest request = new RegisterRequest();
        request.setUsername(shortUser("nu"));
        request.setPassword("password123");
        request.setNickname("新用户");

        mockMvc.perform(post("/api/auth/register")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data").exists())
                .andExpect(jsonPath("$.data.token").exists())
                .andExpect(jsonPath("$.data.user.nickname").value("新用户"));
    }

    @Test
    @DisplayName("POST /api/auth/register - 用户名已存在")
    void register_DuplicateUsername() throws Exception {
        String username = shortUser("du");
        RegisterRequest request = new RegisterRequest();
        request.setUsername(username);
        request.setPassword("password123");
        request.setNickname("用户");

        mockMvc.perform(post("/api/auth/register")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk());

        mockMvc.perform(post("/api/auth/register")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(400));
    }

    @Test
    @DisplayName("POST /api/auth/login - 用户登录成功")
    void login_Success() throws Exception {
        String username = shortUser("lu");
        String password = "password123";

        RegisterRequest registerRequest = new RegisterRequest();
        registerRequest.setUsername(username);
        registerRequest.setPassword(password);
        registerRequest.setNickname("登录用户");

        mockMvc.perform(post("/api/auth/register")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(registerRequest)))
                .andExpect(status().isOk());

        LoginRequest loginRequest = new LoginRequest();
        loginRequest.setUsername(username);
        loginRequest.setPassword(password);

        mockMvc.perform(post("/api/auth/login")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(loginRequest)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data").exists())
                .andExpect(jsonPath("$.data.token").exists());
    }

    @Test
    @DisplayName("POST /api/auth/login - 密码错误")
    void login_WrongPassword() throws Exception {
        LoginRequest request = new LoginRequest();
        request.setUsername("nonexist");
        request.setPassword("wrongpw");

        // GlobalExceptionHandler wraps RuntimeException with code 400
        mockMvc.perform(post("/api/auth/login")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(400));
    }

    // ==================== 用户信息接口测试 ====================

    @Test
    @DisplayName("GET /api/auth/me - 获取个人信息（需要认证）")
    void getProfile_WithAuth() throws Exception {
        String token = registerAndLogin();

        mockMvc.perform(get("/api/auth/me")
                .header("Authorization", "Bearer " + token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.nickname").exists());
    }

    @Test
    @DisplayName("GET /api/auth/me - 未认证访问被拒绝")
    void getProfile_WithoutAuth() throws Exception {
        // /api/auth/* filter放行但无userId → MissingRequestAttributeException → code=500
        mockMvc.perform(get("/api/auth/me"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(500));
    }

    @Test
    @DisplayName("PUT /api/user/profile - 更新个人资料返回成功消息")
    void updateProfile_Success() throws Exception {
        String token = registerAndLogin();

        // ApiResponse<String> → data is "信息更新成功"
        mockMvc.perform(put("/api/user/profile")
                .header("Authorization", "Bearer " + token)
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"nickname\": \"新昵称\", \"bio\": \"新简介\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data").value("信息更新成功"));
    }

    // ==================== 巡礼统计接口测试 ====================

    @Test
    @DisplayName("GET /api/user/me/stats - 获取巡礼统计")
    @org.junit.jupiter.api.Disabled("H2不支持PostgreSQL的TO_CHAR函数，需Testcontainers PostgreSQL环境")
    void getUserStats() throws Exception {
        String token = registerAndLogin();

        mockMvc.perform(get("/api/user/me/stats")
                .header("Authorization", "Bearer " + token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.totalRoutes").exists())
                .andExpect(jsonPath("$.data.totalSpots").exists())
                .andExpect(jsonPath("$.data.totalAnimes").exists());
    }

    // ==================== 辅助方法 ====================

    private String registerAndLogin() throws Exception {
        String username = shortUser("te");
        RegisterRequest request = new RegisterRequest();
        request.setUsername(username);
        request.setPassword("password123");
        request.setNickname("测试用户");

        MvcResult result = mockMvc.perform(post("/api/auth/register")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andReturn();

        String response = result.getResponse().getContentAsString();
        ApiResponse<?> apiResponse = objectMapper.readValue(response, ApiResponse.class);

        @SuppressWarnings("unchecked")
        java.util.Map<String, Object> data = (java.util.Map<String, Object>) apiResponse.getData();
        if (data == null || !data.containsKey("token")) {
            LoginRequest loginRequest = new LoginRequest();
            loginRequest.setUsername(username);
            loginRequest.setPassword("password123");

            MvcResult loginResult = mockMvc.perform(post("/api/auth/login")
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(objectMapper.writeValueAsString(loginRequest)))
                    .andExpect(status().isOk())
                    .andReturn();

            String loginResponse = loginResult.getResponse().getContentAsString();
            ApiResponse<?> loginApiResponse = objectMapper.readValue(loginResponse, ApiResponse.class);
            @SuppressWarnings("unchecked")
            java.util.Map<String, Object> loginData = (java.util.Map<String, Object>) loginApiResponse.getData();
            if (loginData == null) {
                throw new RuntimeException("无法获取登录 token，注册/登录均失败: " + loginResponse);
            }
            return (String) loginData.get("token");
        }
        return (String) data.get("token");
    }
}
