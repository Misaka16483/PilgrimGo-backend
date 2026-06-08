package com.misaka.demo.dto;

import com.misaka.demo.entity.User;
import lombok.Data;

@Data
public class UserVO {
    private Long id;
    private String username;
    private String nickname;
    private String phone;
    private String avatarUrl;
    private String bio;
    private int checkInCount;
    private int routeCount;

    /** 带统计数的构造方法 */
    public static UserVO from(User user, int checkInCount, int routeCount) {
        UserVO vo = new UserVO();
        vo.setId(user.getId());
        vo.setUsername(user.getUsername());
        vo.setNickname(user.getNickname());
        vo.setPhone(user.getPhone());
        vo.setAvatarUrl(user.getAvatarUrl());
        vo.setBio(user.getBio());
        vo.setCheckInCount(checkInCount);
        vo.setRouteCount(routeCount);
        return vo;
    }

    /** 兼容旧调用处（如登录/注册响应，此时统计数为 0） */
    public static UserVO from(User user) {
        return from(user, 0, 0);
    }
}
