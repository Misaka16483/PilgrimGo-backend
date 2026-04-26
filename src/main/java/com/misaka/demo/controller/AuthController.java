package com.misaka.demo.controller;

import com.misaka.demo.dto.*;
import com.misaka.demo.entity.User;
import com.misaka.demo.service.UserService;
import com.misaka.demo.util.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private JwtUtil jwtUtil;

    @PostMapping("/register")
    public ApiResponse<LoginResponse> register(@RequestBody RegisterRequest req) {
        try {
            User user = userService.register(req.getUsername(), req.getPassword(), req.getNickname());
            String token = jwtUtil.generateToken(user.getId(), user.getUsername());
            return ApiResponse.ok(new LoginResponse(token, UserVO.from(user)));
        } catch (RuntimeException e) {
            return ApiResponse.error(400, e.getMessage());
        }
    }

    @PostMapping("/login")
    public ApiResponse<LoginResponse> login(@RequestBody LoginRequest req) {
        try {
            User user = userService.authenticate(req.getUsername(), req.getPassword());
            String token = jwtUtil.generateToken(user.getId(), user.getUsername());
            return ApiResponse.ok(new LoginResponse(token, UserVO.from(user)));
        } catch (RuntimeException e) {
            return ApiResponse.error(401, e.getMessage());
        }
    }

    @GetMapping("/me")
    public ApiResponse<UserVO> me(@RequestAttribute("userId") Long userId) {
        User user = userService.findById(userId);
        if (user == null) {
            return ApiResponse.error(404, "用户不存在");
        }
        return ApiResponse.ok(UserVO.from(user));
    }
}
