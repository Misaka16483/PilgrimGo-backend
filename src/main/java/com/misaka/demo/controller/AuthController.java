package com.misaka.demo.controller;

import com.misaka.demo.dto.*;
import com.misaka.demo.entity.User;
import com.misaka.demo.service.SmsService;
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

    @Autowired
    private SmsService smsService;

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

    @PostMapping("/register/sms")
    public ApiResponse<LoginResponse> registerWithSms(@RequestBody RegisterWithSmsRequest req) {
        try {
            // 验证手机号格式
            if (!isValidPhone(req.getPhone())) {
                return ApiResponse.error(400, "手机号格式不正确");
            }

            // 验证短信验证码
            boolean verified = smsService.verifyCode(req.getPhone(), req.getSmsCode(), "REGISTER");
            if (!verified) {
                return ApiResponse.error(400, "短信验证码错误或已过期");
            }

            // 使用手机号作为用户名注册
            User user = userService.registerWithPhone(req.getPhone(), req.getPassword(), req.getNickname());
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

    @PostMapping("/login/sms")
    public ApiResponse<LoginResponse> loginWithSms(@RequestBody SmsVerifyRequest req) {
        try {
            // 验证手机号格式
            if (!isValidPhone(req.getPhone())) {
                return ApiResponse.error(400, "手机号格式不正确");
            }

            // 验证短信验证码
            boolean verified = smsService.verifyCode(req.getPhone(), req.getCode(), "LOGIN");
            if (!verified) {
                return ApiResponse.error(400, "短信验证码错误或已过期");
            }

            // 查找用户
            User user = userService.findByUsername(req.getPhone());
            if (user == null) {
                return ApiResponse.error(404, "用户不存在，请先注册");
            }

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

    private boolean isValidPhone(String phone) {
        return phone != null && phone.matches("^1[3-9]\\d{9}$");
    }
}
