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
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * 跨模块集成测试：短信验证码、密码管理
 * 注：SMS 接口依赖阿里云 Dypnsapi SDK，无法在 H2 测试环境独立运行
 */
@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
@DisplayName("短信与密码管理集成测试")
public class SmsAuthIntegrationTest {

    @Autowired private MockMvc mockMvc;
    @Autowired private ObjectMapper objectMapper;

    private static int seqNum = 0;
    private String authToken;

    private static String shortUser() {
        return "su" + (System.currentTimeMillis() % 100000) + "_" + (++seqNum);
    }

    @BeforeAll
    void registerAndLogin() throws Exception {
        String username = shortUser();
        RegisterRequest reg = new RegisterRequest();
        reg.setUsername(username);
        reg.setPassword("password123");
        reg.setNickname("短信测试用户");

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

    // ==================== 短信发送与验证 ====================

    @Test
    @DisplayName("POST /api/sms/send - 发送短信验证码")
    @org.junit.jupiter.api.Disabled("SmsService 依赖阿里云 Dypnsapi SDK，H2 环境下 SDK 初始化失败（无真实 AK/SK），需 Testcontainers + 阿里云 Sandbox")
    void smsSend_Success() throws Exception {
        mockMvc.perform(post("/api/sms/send")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"phone\":\"13800138000\",\"type\":\"REGISTER\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    @Test
    @DisplayName("POST /api/sms/send - 手机号格式错误")
    @org.junit.jupiter.api.Disabled("SmsService 依赖阿里云 Dypnsapi SDK，H2 环境下 SDK 初始化失败")
    void smsSend_InvalidPhone() throws Exception {
        mockMvc.perform(post("/api/sms/send")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"phone\":\"12345\",\"type\":\"REGISTER\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(400));
    }

    @Test
    @DisplayName("POST /api/sms/verify - 验证短信验证码")
    @org.junit.jupiter.api.Disabled("SmsService 依赖阿里云 Dypnsapi SDK，H2 环境下 SDK 初始化失败")
    void smsVerify_Success() throws Exception {
        mockMvc.perform(post("/api/sms/verify")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"phone\":\"13800138000\",\"code\":\"000000\",\"type\":\"REGISTER\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    // ==================== 密码管理 ====================

    @Test
    @DisplayName("PUT /api/auth/password - 修改密码成功")
    void changePassword_Success() throws Exception {
        mockMvc.perform(put("/api/auth/password")
                .header("Authorization", "Bearer " + authToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"oldPassword\":\"password123\",\"newPassword\":\"newpass456\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    @Test
    @DisplayName("PUT /api/auth/password - 旧密码错误")
    void changePassword_WrongOld() throws Exception {
        mockMvc.perform(put("/api/auth/password")
                .header("Authorization", "Bearer " + authToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"oldPassword\":\"wrongpass\",\"newPassword\":\"newpass789\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(400));
    }

    @Test
    @DisplayName("PUT /api/auth/password - 未登录拒绝")
    void changePassword_WithoutAuth() throws Exception {
        mockMvc.perform(put("/api/auth/password")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"oldPassword\":\"old\",\"newPassword\":\"new\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(500));
    }

    // ==================== 跨模块场景：改密后重新登录 ====================

    @Test
    @DisplayName("修改密码 → 用旧密码登录失败 → 用新密码登录成功")
    void changePasswordThenReLogin() throws Exception {
        // 1. 注册新用户
        String username = shortUser();
        RegisterRequest reg = new RegisterRequest();
        reg.setUsername(username);
        reg.setPassword("oldpass123");
        reg.setNickname("改密测试");

        MvcResult result = mockMvc.perform(post("/api/auth/register")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(reg)))
                .andExpect(status().isOk())
                .andReturn();

        String resp = result.getResponse().getContentAsString();
        ApiResponse<?> apiResp = objectMapper.readValue(resp, ApiResponse.class);
        @SuppressWarnings("unchecked")
        java.util.Map<String, Object> data = (java.util.Map<String, Object>) apiResp.getData();
        String token = (String) data.get("token");

        // 2. 修改密码
        mockMvc.perform(put("/api/auth/password")
                .header("Authorization", "Bearer " + token)
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"oldPassword\":\"oldpass123\",\"newPassword\":\"newpass456\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));

        // 3. 用旧密码登录 → 失败
        LoginRequest oldLogin = new LoginRequest();
        oldLogin.setUsername(username);
        oldLogin.setPassword("oldpass123");
        mockMvc.perform(post("/api/auth/login")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(oldLogin)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(400));

        // 4. 用新密码登录 → 成功
        LoginRequest newLogin = new LoginRequest();
        newLogin.setUsername(username);
        newLogin.setPassword("newpass456");
        mockMvc.perform(post("/api/auth/login")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(newLogin)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.token").exists());
    }
}
