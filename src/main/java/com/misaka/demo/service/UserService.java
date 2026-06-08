package com.misaka.demo.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.misaka.demo.dto.UserStatsVO;
import com.misaka.demo.entity.CheckIn;
import com.misaka.demo.entity.Route;
import com.misaka.demo.entity.User;
import com.misaka.demo.mapper.CheckInMapper;
import com.misaka.demo.mapper.RouteMapper;
import com.misaka.demo.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private CheckInMapper checkInMapper;

    @Autowired
    private RouteMapper routeMapper;

    public User findByUsername(String username) {
        return userMapper.selectOne(new QueryWrapper<User>().eq("username", username));
    }

    public User findById(Long id) {
        return userMapper.selectById(id);
    }

    public User register(String username, String password, String nickname) {
        if (findByUsername(username) != null) {
            throw new RuntimeException("用户名已存在");
        }
        User user = new User();
        user.setUsername(username);
        user.setPasswordHash(passwordEncoder.encode(password));
        user.setNickname(nickname != null ? nickname : username);
        user.setCreatedAt(LocalDateTime.now());
        user.setUpdatedAt(LocalDateTime.now());
        userMapper.insert(user);
        return user;
    }

    public User authenticate(String username, String password) {
        User user = findByUsername(username);
        if (user == null || !passwordEncoder.matches(password, user.getPasswordHash())) {
            throw new RuntimeException("用户名或密码错误");
        }
        return user;
    }

    /** 查询该用户的真实打卡数 */
    public int countCheckIns(Long userId) {
        return Math.toIntExact(checkInMapper.selectCount(
                new QueryWrapper<CheckIn>().eq("user_id", userId)));
    }

    /** 查询该用户的路径数 */
    public int countRoutes(Long userId) {
        return Math.toIntExact(routeMapper.selectCount(
                new QueryWrapper<Route>().eq("user_id", userId)));
    }

    /** 更新用户信息 */
    public User updateUser(User user) {
        user.setUpdatedAt(LocalDateTime.now());
        userMapper.updateById(user);
        return user;
    }

    /** 更新用户个人信息 */
    public User updateProfile(Long userId, String nickname, String bio) {
        User user = findById(userId);
        if (user == null) throw new RuntimeException("用户不存在");
        if (nickname != null) user.setNickname(nickname);
        if (bio != null) user.setBio(bio);
        return updateUser(user);
    }

    /** 更新用户头像 */
    public User updateAvatar(Long userId, String avatarUrl) {
        User user = findById(userId);
        if (user == null) throw new RuntimeException("用户不存在");
        user.setAvatarUrl(avatarUrl);
        return updateUser(user);
    }

    /** 绑定手机号 */
    public User bindPhone(Long userId, String phone) {
        User user = findById(userId);
        if (user == null) throw new RuntimeException("用户不存在");
        user.setPhone(phone);
        return updateUser(user);
    }

    /** 按手机号查用户 */
    public User findByPhone(String phone) {
        return userMapper.selectOne(new QueryWrapper<User>().eq("phone", phone));
    }

    /** 短信验证码注册 */
    public User registerWithPhone(String phone, String password, String nickname) {
        if (findByPhone(phone) != null) {
            throw new RuntimeException("该手机号已注册");
        }
        User user = new User();
        user.setPhone(phone);
        user.setUsername("user_" + phone);
        user.setPasswordHash(passwordEncoder.encode(password));
        user.setNickname(nickname != null ? nickname : phone);
        user.setCreatedAt(LocalDateTime.now());
        user.setUpdatedAt(LocalDateTime.now());
        userMapper.insert(user);
        return user;
    }

    /** 修改密码 */
    public void changePassword(Long userId, String oldPassword, String newPassword) {
        User user = findById(userId);
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }
        if (!passwordEncoder.matches(oldPassword, user.getPasswordHash())) {
            throw new RuntimeException("原密码错误");
        }
        user.setPasswordHash(passwordEncoder.encode(newPassword));
        user.setUpdatedAt(LocalDateTime.now());
        userMapper.updateById(user);
    }

    /** 短信重置密码 */
    public void resetPassword(String phone, String newPassword) {
        User user = findByPhone(phone);
        if (user == null) {
            throw new RuntimeException("该手机号未注册");
        }
        user.setPasswordHash(passwordEncoder.encode(newPassword));
        user.setUpdatedAt(LocalDateTime.now());
        userMapper.updateById(user);
    }

    public UserStatsVO getUserStats(Long userId) {
        UserStatsVO stats = new UserStatsVO();

        long routeCount = routeMapper.selectCount(
            new QueryWrapper<Route>().eq("user_id", userId)
        );
        stats.setTotalRoutes((int) routeCount);

        long checkInCount = checkInMapper.selectCount(
            new QueryWrapper<CheckIn>().eq("user_id", userId)
        );
        stats.setTotalSpots((int) checkInCount);

        Integer animeCount = checkInMapper.selectDistinctSpotCountByUserId(userId);
        stats.setTotalAnimes(animeCount != null ? animeCount : 0);

        BigDecimal totalDistance = routeMapper.selectTotalDistanceByUserId(userId);
        stats.setTotalDistance(totalDistance != null ? totalDistance.doubleValue() : 0.0);

        Integer totalDuration = routeMapper.selectTotalDurationByUserId(userId);
        stats.setTotalDuration(totalDuration != null ? totalDuration : 0);

        stats.setCurrentStreak(calculateStreak(userId));

        List<Map<String, Object>> monthlyData = checkInMapper.selectMonthlyStatsByUserId(userId);
        List<UserStatsVO.MonthlyStats> monthlyStats = new ArrayList<>();
        if (monthlyData != null) {
            for (Map<String, Object> data : monthlyData) {
                UserStatsVO.MonthlyStats ms = new UserStatsVO.MonthlyStats();
                ms.setMonth((String) data.get("month"));
                ms.setCheckInCount(((Number) data.get("count")).intValue());
                ms.setDistance(0.0);
                monthlyStats.add(ms);
            }
        }
        stats.setMonthlyStats(monthlyStats);

        return stats;
    }

    private int calculateStreak(Long userId) {
        LocalDateTime sevenDaysAgo = LocalDateTime.now().minusDays(7);
        Long recentCount = checkInMapper.selectCount(
            new QueryWrapper<CheckIn>()
                .eq("user_id", userId)
                .ge("created_at", sevenDaysAgo)
        );
        return recentCount > 0 ? 7 : 0;
    }
}
