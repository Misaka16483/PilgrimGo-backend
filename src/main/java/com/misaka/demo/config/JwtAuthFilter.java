package com.misaka.demo.config;

import com.misaka.demo.util.JwtUtil;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
public class JwtAuthFilter extends OncePerRequestFilter {

    @Autowired
    private JwtUtil jwtUtil;

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {
        String path = request.getRequestURI();

        // 放行不需要认证的路径
        if (path.startsWith("/api/auth/login") || path.startsWith("/api/auth/register")) {
            filterChain.doFilter(request, response);
            return;
        }

        // 公共只读接口（作品/取景地搜索 & 详情）允许匿名访问
        boolean isPublicGet = "GET".equalsIgnoreCase(request.getMethod())
                && (path.startsWith("/api/anime")
                    || path.startsWith("/api/spots"));
        if (isPublicGet) {
            tryAttachUserId(request);
            filterChain.doFilter(request, response);
            return;
        }

        String header = request.getHeader("Authorization");
        if (header != null && header.startsWith("Bearer ")) {
            String token = header.substring(7);
            if (jwtUtil.isValid(token)) {
                Long userId = jwtUtil.getUserId(token);
                request.setAttribute("userId", userId);
                filterChain.doFilter(request, response);
                return;
            }
        }

        // 非认证接口且无有效 token
        if (path.startsWith("/api/auth/") || path.startsWith("/api/v1/anime/search")
                || path.equals("/api/hello")) {
            filterChain.doFilter(request, response);
            return;
        }

        response.setStatus(401);
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write("{\"code\":401,\"message\":\"未登录\",\"data\":null}");
    }

    /** 已登录则把 userId 挂到请求上，未登录就静默跳过。供公共接口使用。 */
    private void tryAttachUserId(HttpServletRequest request) {
        String header = request.getHeader("Authorization");
        if (header == null || !header.startsWith("Bearer ")) return;
        String token = header.substring(7);
        if (jwtUtil.isValid(token)) {
            request.setAttribute("userId", jwtUtil.getUserId(token));
        }
    }
}
