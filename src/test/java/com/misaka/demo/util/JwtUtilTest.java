package com.misaka.demo.util;

import io.jsonwebtoken.Claims;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.test.util.ReflectionTestUtils;

import static org.junit.jupiter.api.Assertions.*;

class JwtUtilTest {

    private JwtUtil jwtUtil;

    @BeforeEach
    void setUp() {
        jwtUtil = new JwtUtil();
        ReflectionTestUtils.setField(jwtUtil, "secret",
                "PilgrimGoSecretKey2026BJTU2026XunliPlusApplicationJWT");
        ReflectionTestUtils.setField(jwtUtil, "expiration", 86400000L);
    }

    @Test
    void generateToken_returnsNonEmptyString() {
        String token = jwtUtil.generateToken(1L, "alice");
        assertNotNull(token);
        assertFalse(token.isBlank());
    }

    @Test
    void parseToken_recoversSubjectAndUsername() {
        String token = jwtUtil.generateToken(42L, "bob");
        Claims claims = jwtUtil.parseToken(token);
        assertEquals("42", claims.getSubject());
        assertEquals("bob", claims.get("username", String.class));
    }

    @Test
    void getUserId_returnsLongIdFromToken() {
        String token = jwtUtil.generateToken(123L, "carol");
        assertEquals(123L, jwtUtil.getUserId(token));
    }

    @Test
    void isValid_returnsTrueForFreshToken() {
        String token = jwtUtil.generateToken(1L, "alice");
        assertTrue(jwtUtil.isValid(token));
    }

    @Test
    void isValid_returnsFalseForGarbageToken() {
        assertFalse(jwtUtil.isValid("not-a-token"));
        assertFalse(jwtUtil.isValid(""));
        assertFalse(jwtUtil.isValid("aaa.bbb.ccc"));
    }

    @Test
    void isValid_returnsFalseWhenSignatureMismatches() {
        String token = jwtUtil.generateToken(1L, "alice");

        JwtUtil other = new JwtUtil();
        ReflectionTestUtils.setField(other, "secret",
                "AnotherCompletelyDifferentSecretKeyThatIsLongEnough123456");
        ReflectionTestUtils.setField(other, "expiration", 86400000L);

        assertFalse(other.isValid(token));
    }

    @Test
    void isValid_returnsFalseWhenTokenIsExpired() throws InterruptedException {
        ReflectionTestUtils.setField(jwtUtil, "expiration", 1L); // 1 ms
        String token = jwtUtil.generateToken(1L, "alice");
        Thread.sleep(50);
        assertFalse(jwtUtil.isValid(token));
    }
}
