package com.misaka.demo.dto;

import com.misaka.demo.entity.User;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class UserVOTest {

    @Test
    void from_copiesPublicFieldsAndDefaultsCounts() {
        User user = new User();
        user.setId(7L);
        user.setNickname("misaka");
        user.setAvatarUrl("http://example.com/a.png");
        user.setBio("hello");
        user.setPasswordHash("should-not-leak");

        UserVO vo = UserVO.from(user);

        assertEquals(7L, vo.getId());
        assertEquals("misaka", vo.getNickname());
        assertEquals("http://example.com/a.png", vo.getAvatarUrl());
        assertEquals("hello", vo.getBio());
        assertEquals(0, vo.getCheckInCount());
        assertEquals(0, vo.getRouteCount());
    }

    @Test
    void from_handlesNullOptionalFields() {
        User user = new User();
        user.setId(1L);

        UserVO vo = UserVO.from(user);

        assertEquals(1L, vo.getId());
        assertNull(vo.getNickname());
        assertNull(vo.getAvatarUrl());
        assertNull(vo.getBio());
    }
}
