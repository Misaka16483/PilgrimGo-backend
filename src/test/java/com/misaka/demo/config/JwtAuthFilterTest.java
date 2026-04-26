package com.misaka.demo.config;

import com.misaka.demo.util.JwtUtil;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.util.ReflectionTestUtils;

import java.io.IOException;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class JwtAuthFilterTest {

    private JwtUtil jwtUtil;
    private JwtAuthFilter filter;

    @BeforeEach
    void setUp() {
        jwtUtil = mock(JwtUtil.class);
        filter = new JwtAuthFilter();
        ReflectionTestUtils.setField(filter, "jwtUtil", jwtUtil);
    }

    private static MockHttpServletRequest req(String method, String uri) {
        MockHttpServletRequest r = new MockHttpServletRequest(method, uri);
        r.setRequestURI(uri);
        return r;
    }

    @Test
    void loginPathBypassesAuth() throws ServletException, IOException {
        MockHttpServletRequest request = req("POST", "/api/auth/login");
        MockHttpServletResponse response = new MockHttpServletResponse();
        FilterChain chain = mock(FilterChain.class);

        filter.doFilter(request, response, chain);

        verify(chain).doFilter(request, response);
        assertEquals(200, response.getStatus());
        verifyNoInteractions(jwtUtil);
    }

    @Test
    void registerPathBypassesAuth() throws ServletException, IOException {
        MockHttpServletRequest request = req("POST", "/api/auth/register");
        MockHttpServletResponse response = new MockHttpServletResponse();
        FilterChain chain = mock(FilterChain.class);

        filter.doFilter(request, response, chain);

        verify(chain).doFilter(request, response);
        verifyNoInteractions(jwtUtil);
    }

    @Test
    void publicAnimeGetIsAllowedWithoutToken() throws ServletException, IOException {
        MockHttpServletRequest request = req("GET", "/api/anime/123");
        MockHttpServletResponse response = new MockHttpServletResponse();
        FilterChain chain = mock(FilterChain.class);

        filter.doFilter(request, response, chain);

        verify(chain).doFilter(request, response);
        assertNull(request.getAttribute("userId"));
    }

    @Test
    void publicSpotsGetAttachesUserIdWhenTokenProvided() throws ServletException, IOException {
        MockHttpServletRequest request = req("GET", "/api/spots/nearby");
        request.addHeader("Authorization", "Bearer good-token");
        MockHttpServletResponse response = new MockHttpServletResponse();
        FilterChain chain = mock(FilterChain.class);
        when(jwtUtil.isValid("good-token")).thenReturn(true);
        when(jwtUtil.getUserId("good-token")).thenReturn(42L);

        filter.doFilter(request, response, chain);

        verify(chain).doFilter(request, response);
        assertEquals(42L, request.getAttribute("userId"));
    }

    @Test
    void publicSpotsGetIgnoresInvalidTokenWithout401() throws ServletException, IOException {
        MockHttpServletRequest request = req("GET", "/api/spots/1");
        request.addHeader("Authorization", "Bearer bad");
        MockHttpServletResponse response = new MockHttpServletResponse();
        FilterChain chain = mock(FilterChain.class);
        when(jwtUtil.isValid("bad")).thenReturn(false);

        filter.doFilter(request, response, chain);

        verify(chain).doFilter(request, response);
        assertNull(request.getAttribute("userId"));
        assertEquals(200, response.getStatus());
    }

    @Test
    void protectedRequestWithValidTokenAttachesUserIdAndProceeds() throws ServletException, IOException {
        MockHttpServletRequest request = req("GET", "/api/auth/me");
        request.addHeader("Authorization", "Bearer good");
        MockHttpServletResponse response = new MockHttpServletResponse();
        FilterChain chain = mock(FilterChain.class);
        when(jwtUtil.isValid("good")).thenReturn(true);
        when(jwtUtil.getUserId("good")).thenReturn(7L);

        filter.doFilter(request, response, chain);

        verify(chain).doFilter(request, response);
        assertEquals(7L, request.getAttribute("userId"));
    }

    @Test
    void protectedRequestWithoutTokenReturns401Json() throws ServletException, IOException {
        MockHttpServletRequest request = req("POST", "/api/anime/1/check-in");
        MockHttpServletResponse response = new MockHttpServletResponse();
        FilterChain chain = mock(FilterChain.class);

        filter.doFilter(request, response, chain);

        verify(chain, never()).doFilter(any(), any());
        assertEquals(401, response.getStatus());
        assertEquals("application/json;charset=UTF-8", response.getContentType());
        String body = response.getContentAsString();
        assertTrue(body.contains("\"code\":401"));
        assertTrue(body.contains("未登录"));
    }

    @Test
    void protectedRequestWithInvalidTokenReturns401() throws ServletException, IOException {
        MockHttpServletRequest request = req("POST", "/api/anime/1/check-in");
        request.addHeader("Authorization", "Bearer bad");
        MockHttpServletResponse response = new MockHttpServletResponse();
        FilterChain chain = mock(FilterChain.class);
        when(jwtUtil.isValid("bad")).thenReturn(false);

        filter.doFilter(request, response, chain);

        verify(chain, never()).doFilter(any(), any());
        assertEquals(401, response.getStatus());
    }

    @Test
    void protectedRequestWithMalformedAuthHeaderReturns401() throws ServletException, IOException {
        MockHttpServletRequest request = req("POST", "/api/anime/1/check-in");
        request.addHeader("Authorization", "Basic dXNlcjpwYXNz");
        MockHttpServletResponse response = new MockHttpServletResponse();
        FilterChain chain = mock(FilterChain.class);

        filter.doFilter(request, response, chain);

        assertEquals(401, response.getStatus());
        verifyNoInteractions(jwtUtil);
    }
}
