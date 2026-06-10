package com.misaka.demo.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.misaka.demo.dto.UserStatsVO;
import com.misaka.demo.entity.CheckIn;
import com.misaka.demo.entity.Route;
import com.misaka.demo.entity.User;
import com.misaka.demo.mapper.CheckInMapper;
import com.misaka.demo.mapper.RouteMapper;
import com.misaka.demo.mapper.UserMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * 成员A - UserService 完整单元测试
 * 测试范围：用户认证、用户管理、巡礼统计
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("UserService 单元测试")
public class UserServiceCompleteTest {

    @Mock
    private UserMapper userMapper;

    @Mock
    private RouteMapper routeMapper;

    @Mock
    private CheckInMapper checkInMapper;

    @Mock
    private PasswordEncoder passwordEncoder;

    @InjectMocks
    private UserService userService;

    private User testUser;
    private static final Long TEST_USER_ID = 1L;
    private static final String TEST_USERNAME = "testuser";
    private static final String TEST_PASSWORD = "password123";
    private static final String TEST_ENCODED_PASSWORD = "$2a$10$encoded";

    @BeforeEach
    void setUp() {
        testUser = new User();
        testUser.setId(TEST_USER_ID);
        testUser.setUsername(TEST_USERNAME);
        testUser.setPasswordHash(TEST_ENCODED_PASSWORD);
        testUser.setNickname("测试用户");
        testUser.setCreatedAt(LocalDateTime.now());
        testUser.setUpdatedAt(LocalDateTime.now());
    }

    // ==================== 用户注册测试 ====================

    @Test
    @DisplayName("用户名密码注册成功")
    void register_WithUsername_Success() {
        // Given
        when(userMapper.selectOne(any(QueryWrapper.class))).thenReturn(null);
        when(passwordEncoder.encode(TEST_PASSWORD)).thenReturn(TEST_ENCODED_PASSWORD);
        when(userMapper.insert(any(User.class))).thenReturn(1);

        // When
        User result = userService.register(TEST_USERNAME, TEST_PASSWORD, "测试昵称");

        // Then
        assertNotNull(result);
        assertEquals(TEST_USERNAME, result.getUsername());
        assertEquals("测试昵称", result.getNickname());
        assertEquals(TEST_ENCODED_PASSWORD, result.getPasswordHash());
        verify(userMapper).insert(any(User.class));
    }

    @Test
    @DisplayName("注册失败-用户名已存在")
    void register_DuplicateUsername_ThrowsException() {
        // Given - findByUsername 返回已存在的用户
        User existingUser = new User();
        existingUser.setId(999L);
        existingUser.setUsername(TEST_USERNAME);
        when(userMapper.selectOne(any(QueryWrapper.class))).thenReturn(existingUser);

        // When & Then
        RuntimeException exception = assertThrows(RuntimeException.class, () -> {
            userService.register(TEST_USERNAME, TEST_PASSWORD, "测试昵称");
        });
        assertEquals("用户名已存在", exception.getMessage());
    }

    @Test
    @DisplayName("手机号注册成功")
    void registerWithPhone_Success() {
        // Given
        String phone = "13800138000";
        when(userMapper.selectOne(any(QueryWrapper.class))).thenReturn(null);
        when(passwordEncoder.encode(TEST_PASSWORD)).thenReturn(TEST_ENCODED_PASSWORD);
        when(userMapper.insert(any(User.class))).thenReturn(1);

        // When
        User result = userService.registerWithPhone(phone, TEST_PASSWORD, "手机用户");

        // Then
        assertNotNull(result);
        assertEquals("user_" + phone, result.getUsername());
        assertEquals(phone, result.getPhone());
        verify(userMapper).insert(any(User.class));
    }

    // ==================== 用户登录测试 ====================

    @Test
    @DisplayName("用户名密码登录成功")
    void authenticate_Success() {
        // Given
        when(userMapper.selectOne(any(QueryWrapper.class))).thenReturn(testUser);
        when(passwordEncoder.matches(TEST_PASSWORD, TEST_ENCODED_PASSWORD)).thenReturn(true);

        // When
        User result = userService.authenticate(TEST_USERNAME, TEST_PASSWORD);

        // Then
        assertNotNull(result);
        assertEquals(TEST_USER_ID, result.getId());
        assertEquals(TEST_USERNAME, result.getUsername());
    }

    @Test
    @DisplayName("登录失败-密码错误")
    void authenticate_WrongPassword_ThrowsException() {
        // Given
        when(userMapper.selectOne(any(QueryWrapper.class))).thenReturn(testUser);
        when(passwordEncoder.matches("wrongpassword", TEST_ENCODED_PASSWORD)).thenReturn(false);

        // When & Then
        RuntimeException exception = assertThrows(RuntimeException.class, () -> {
            userService.authenticate(TEST_USERNAME, "wrongpassword");
        });
        assertEquals("用户名或密码错误", exception.getMessage());
    }

    @Test
    @DisplayName("登录失败-用户不存在")
    void authenticate_UserNotFound_ThrowsException() {
        // Given
        when(userMapper.selectOne(any(QueryWrapper.class))).thenReturn(null);

        // When & Then
        RuntimeException exception = assertThrows(RuntimeException.class, () -> {
            userService.authenticate("nonexistent", TEST_PASSWORD);
        });
        assertEquals("用户名或密码错误", exception.getMessage());
    }

    // ==================== 用户信息管理测试 ====================

    @Test
    @DisplayName("更新个人资料成功")
    void updateProfile_Success() {
        // Given
        when(userMapper.selectById(TEST_USER_ID)).thenReturn(testUser);
        when(userMapper.updateById(any(User.class))).thenReturn(1);

        // When
        User result = userService.updateProfile(TEST_USER_ID, "新昵称", "这是我的简介");

        // Then
        assertNotNull(result);
        assertEquals("新昵称", result.getNickname());
        assertEquals("这是我的简介", result.getBio());
        verify(userMapper).updateById(any(User.class));
    }

    @Test
    @DisplayName("更新头像成功")
    void updateAvatar_Success() {
        // Given
        String avatarUrl = "https://example.com/avatar.jpg";
        when(userMapper.selectById(TEST_USER_ID)).thenReturn(testUser);
        when(userMapper.updateById(any(User.class))).thenReturn(1);

        // When
        User result = userService.updateAvatar(TEST_USER_ID, avatarUrl);

        // Then
        assertNotNull(result);
        assertEquals(avatarUrl, result.getAvatarUrl());
    }

    @Test
    @DisplayName("更新资料失败-用户不存在")
    void updateProfile_UserNotFound_ThrowsException() {
        // Given
        when(userMapper.selectById(TEST_USER_ID)).thenReturn(null);

        // When & Then
        RuntimeException exception = assertThrows(RuntimeException.class, () -> {
            userService.updateProfile(TEST_USER_ID, "昵称", "简介");
        });
        assertEquals("用户不存在", exception.getMessage());
    }

    // ==================== 密码管理测试 ====================

    @Test
    @DisplayName("修改密码成功")
    void changePassword_Success() {
        // Given
        String newPassword = "newpassword123";
        when(userMapper.selectById(TEST_USER_ID)).thenReturn(testUser);
        when(passwordEncoder.matches(TEST_PASSWORD, TEST_ENCODED_PASSWORD)).thenReturn(true);
        when(passwordEncoder.encode(newPassword)).thenReturn("newencodedpassword");
        when(userMapper.updateById(any(User.class))).thenReturn(1);

        // When
        assertDoesNotThrow(() -> {
            userService.changePassword(TEST_USER_ID, TEST_PASSWORD, newPassword);
        });

        // Then
        verify(userMapper).updateById(any(User.class));
    }

    @Test
    @DisplayName("修改密码失败-旧密码错误")
    void changePassword_WrongOldPassword_ThrowsException() {
        // Given
        when(userMapper.selectById(TEST_USER_ID)).thenReturn(testUser);
        when(passwordEncoder.matches("wrongpassword", TEST_ENCODED_PASSWORD)).thenReturn(false);

        // When & Then
        RuntimeException exception = assertThrows(RuntimeException.class, () -> {
            userService.changePassword(TEST_USER_ID, "wrongpassword", "newpassword");
        });
        assertEquals("原密码错误", exception.getMessage());
    }

    // ==================== 密码重置测试（新增） ====================

    @Test
    @DisplayName("resetPassword 重置密码成功")
    void resetPassword_Success() {
        String phone = "13800138000";
        String newPassword = "newpwd123";
        when(userMapper.selectOne(any(QueryWrapper.class))).thenReturn(testUser);
        when(passwordEncoder.encode(newPassword)).thenReturn("newencoded");
        when(userMapper.updateById(any(User.class))).thenReturn(1);

        assertDoesNotThrow(() -> {
            userService.resetPassword(phone, newPassword);
        });
        verify(userMapper).updateById(any(User.class));
    }

    @Test
    @DisplayName("resetPassword 手机号未注册")
    void resetPassword_PhoneNotRegistered() {
        String phone = "13800138000";
        when(userMapper.selectOne(any(QueryWrapper.class))).thenReturn(null);

        RuntimeException ex = assertThrows(RuntimeException.class, () -> {
            userService.resetPassword(phone, "newpwd");
        });
        assertEquals("该手机号未注册", ex.getMessage());
    }

    // ==================== findByPhone 测试（新增） ====================

    @Test
    @DisplayName("findByPhone 根据手机号查到用户")
    void findByPhone_Found() {
        testUser.setPhone("13800138000");
        when(userMapper.selectOne(any(QueryWrapper.class))).thenReturn(testUser);

        User result = userService.findByPhone("13800138000");
        assertNotNull(result);
        assertEquals("13800138000", result.getPhone());
    }

    @Test
    @DisplayName("findByPhone 手机号不存在返回null")
    void findByPhone_NotFound() {
        when(userMapper.selectOne(any(QueryWrapper.class))).thenReturn(null);

        User result = userService.findByPhone("13900000000");
        assertNull(result);
    }

    // ==================== 手机号绑定测试 ====================

    @Test
    @DisplayName("绑定手机号成功")
    void bindPhone_Success() {
        // Given
        String phone = "13800138000";
        when(userMapper.selectById(TEST_USER_ID)).thenReturn(testUser);
        when(userMapper.updateById(any(User.class))).thenReturn(1);

        // When
        User result = userService.bindPhone(TEST_USER_ID, phone);

        // Then
        assertNotNull(result);
        assertEquals(phone, result.getPhone());
    }

    // ==================== 巡礼统计测试 ====================

    @Test
    @DisplayName("获取用户巡礼统计-有数据")
    void getUserStats_WithData_Success() {
        // Given
        when(routeMapper.selectCount(any(QueryWrapper.class))).thenReturn(5L);
        when(checkInMapper.selectCount(any(QueryWrapper.class))).thenReturn(10L);
        when(checkInMapper.selectDistinctSpotCountByUserId(TEST_USER_ID)).thenReturn(3);
        when(routeMapper.selectTotalDistanceByUserId(TEST_USER_ID)).thenReturn(new BigDecimal("15.5"));
        when(routeMapper.selectTotalDurationByUserId(TEST_USER_ID)).thenReturn(120);
        when(checkInMapper.selectMonthlyStatsByUserId(TEST_USER_ID)).thenReturn(createMonthlyStats());

        // When
        UserStatsVO stats = userService.getUserStats(TEST_USER_ID);

        // Then
        assertNotNull(stats);
        assertEquals(5, stats.getTotalRoutes());
        assertEquals(10, stats.getTotalSpots());
        assertEquals(3, stats.getTotalAnimes());
        assertEquals(15.5, stats.getTotalDistance());
        assertEquals(120, stats.getTotalDuration());
        assertNotNull(stats.getMonthlyStats());
        assertEquals(2, stats.getMonthlyStats().size());
    }

    @Test
    @DisplayName("获取用户巡礼统计-无数据返回0")
    void getUserStats_NoData_ReturnsZero() {
        // Given
        when(routeMapper.selectCount(any(QueryWrapper.class))).thenReturn(0L);
        when(checkInMapper.selectCount(any(QueryWrapper.class))).thenReturn(0L);
        when(checkInMapper.selectDistinctSpotCountByUserId(TEST_USER_ID)).thenReturn(null);
        when(routeMapper.selectTotalDistanceByUserId(TEST_USER_ID)).thenReturn(null);
        when(routeMapper.selectTotalDurationByUserId(TEST_USER_ID)).thenReturn(null);
        when(checkInMapper.selectMonthlyStatsByUserId(TEST_USER_ID)).thenReturn(new ArrayList<>());

        // When
        UserStatsVO stats = userService.getUserStats(TEST_USER_ID);

        // Then
        assertNotNull(stats);
        assertEquals(0, stats.getTotalRoutes());
        assertEquals(0, stats.getTotalSpots());
        assertEquals(0, stats.getTotalAnimes());
        assertEquals(0.0, stats.getTotalDistance());
        assertEquals(0, stats.getTotalDuration());
    }

    // ==================== 边界条件测试 ====================

    @Test
    @DisplayName("注册-用户名长度边界-最小2字符")
    void register_UsernameMinLength() {
        // Given
        String shortUsername = "ab";
        when(userMapper.selectOne(any(QueryWrapper.class))).thenReturn(null);
        when(passwordEncoder.encode(any())).thenReturn(TEST_ENCODED_PASSWORD);
        when(userMapper.insert(any(User.class))).thenReturn(1);

        // When & Then
        assertDoesNotThrow(() -> {
            userService.register(shortUsername, TEST_PASSWORD, "昵称");
        });
    }

    @Test
    @DisplayName("注册-密码长度边界-最小6字符")
    void register_PasswordMinLength() {
        // Given
        String shortPassword = "123456";
        when(userMapper.selectOne(any(QueryWrapper.class))).thenReturn(null);
        when(passwordEncoder.encode(shortPassword)).thenReturn(TEST_ENCODED_PASSWORD);
        when(userMapper.insert(any(User.class))).thenReturn(1);

        // When & Then
        assertDoesNotThrow(() -> {
            userService.register(TEST_USERNAME, shortPassword, "昵称");
        });
    }

    @Test
    @DisplayName("更新资料-昵称为空使用默认值")
    void updateProfile_EmptyNickname() {
        // Given
        when(userMapper.selectById(TEST_USER_ID)).thenReturn(testUser);
        when(userMapper.updateById(any(User.class))).thenReturn(1);

        // When
        User result = userService.updateProfile(TEST_USER_ID, "", "简介");

        // Then
        assertNotNull(result);
        // 根据业务逻辑，空昵称可能有默认值处理
    }

    // ==================== 辅助方法 ====================

    private List<Map<String, Object>> createMonthlyStats() {
        List<Map<String, Object>> stats = new ArrayList<>();
        
        Map<String, Object> month1 = new HashMap<>();
        month1.put("month", "2026-05");
        month1.put("count", 5);
        stats.add(month1);
        
        Map<String, Object> month2 = new HashMap<>();
        month2.put("month", "2026-04");
        month2.put("count", 3);
        stats.add(month2);
        
        return stats;
    }
}
