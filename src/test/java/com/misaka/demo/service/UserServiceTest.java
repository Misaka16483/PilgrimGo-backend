package com.misaka.demo.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.misaka.demo.entity.User;
import com.misaka.demo.mapper.UserMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.crypto.password.PasswordEncoder;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class UserServiceTest {

    @Mock private UserMapper userMapper;
    @Mock private PasswordEncoder passwordEncoder;

    @InjectMocks private UserService userService;

    private User existing;

    @BeforeEach
    void setUp() {
        existing = new User();
        existing.setId(1L);
        existing.setUsername("alice");
        existing.setPasswordHash("HASH");
        existing.setNickname("Alice");
    }

    @Test
    void findByUsername_delegatesToMapperWithEqWrapper() {
        when(userMapper.selectOne(any(QueryWrapper.class))).thenReturn(existing);

        User u = userService.findByUsername("alice");

        assertSame(existing, u);
        verify(userMapper).selectOne(any(QueryWrapper.class));
    }

    @Test
    void findById_delegatesToMapper() {
        when(userMapper.selectById(1L)).thenReturn(existing);
        assertSame(existing, userService.findById(1L));
    }

    @Test
    void register_persistsHashedPasswordAndDefaultsNickname() {
        when(userMapper.selectOne(any(QueryWrapper.class))).thenReturn(null);
        when(passwordEncoder.encode("pw")).thenReturn("HASHED");

        User created = userService.register("bob", "pw", null);

        ArgumentCaptor<User> cap = ArgumentCaptor.forClass(User.class);
        verify(userMapper).insert(cap.capture());
        User saved = cap.getValue();
        assertEquals("bob", saved.getUsername());
        assertEquals("HASHED", saved.getPasswordHash());
        assertEquals("bob", saved.getNickname()); // null nickname falls back to username
        assertNotNull(saved.getCreatedAt());
        assertNotNull(saved.getUpdatedAt());
        assertSame(saved, created);
    }

    @Test
    void register_usesProvidedNicknameWhenGiven() {
        when(userMapper.selectOne(any(QueryWrapper.class))).thenReturn(null);
        when(passwordEncoder.encode(any())).thenReturn("HASHED");

        userService.register("bob", "pw", "Bobby");

        ArgumentCaptor<User> cap = ArgumentCaptor.forClass(User.class);
        verify(userMapper).insert(cap.capture());
        assertEquals("Bobby", cap.getValue().getNickname());
    }

    @Test
    void register_throwsWhenUsernameTaken() {
        when(userMapper.selectOne(any(QueryWrapper.class))).thenReturn(existing);

        RuntimeException ex = assertThrows(RuntimeException.class,
                () -> userService.register("alice", "pw", null));
        assertTrue(ex.getMessage().contains("用户名已存在"));
        verify(userMapper, never()).insert(any(User.class));
    }

    @Test
    void authenticate_returnsUserOnMatchingPassword() {
        when(userMapper.selectOne(any(QueryWrapper.class))).thenReturn(existing);
        when(passwordEncoder.matches("pw", "HASH")).thenReturn(true);

        assertSame(existing, userService.authenticate("alice", "pw"));
    }

    @Test
    void authenticate_throwsWhenUserMissing() {
        when(userMapper.selectOne(any(QueryWrapper.class))).thenReturn(null);

        RuntimeException ex = assertThrows(RuntimeException.class,
                () -> userService.authenticate("alice", "pw"));
        assertTrue(ex.getMessage().contains("用户名或密码错误"));
        verify(passwordEncoder, never()).matches(any(), any());
    }

    @Test
    void authenticate_throwsWhenPasswordWrong() {
        when(userMapper.selectOne(any(QueryWrapper.class))).thenReturn(existing);
        when(passwordEncoder.matches(eq("pw"), eq("HASH"))).thenReturn(false);

        RuntimeException ex = assertThrows(RuntimeException.class,
                () -> userService.authenticate("alice", "pw"));
        assertTrue(ex.getMessage().contains("用户名或密码错误"));
    }
}
