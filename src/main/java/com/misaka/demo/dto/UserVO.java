package com.misaka.demo.dto;

import com.misaka.demo.entity.User;
import lombok.Data;

@Data
public class UserVO {
    private Long id;
    private String nickname;
    private String avatarUrl;
    private String bio;
    private int checkInCount;
    private int routeCount;

    public static UserVO from(User user) {
        UserVO vo = new UserVO();
        vo.setId(user.getId());
        vo.setNickname(user.getNickname());
        vo.setAvatarUrl(user.getAvatarUrl());
        vo.setBio(user.getBio());
        vo.setCheckInCount(0);
        vo.setRouteCount(0);
        return vo;
    }
}
