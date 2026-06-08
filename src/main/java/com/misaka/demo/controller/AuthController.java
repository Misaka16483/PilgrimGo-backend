package com.misaka.demo.controller;

import com.misaka.demo.dto.*;
import com.misaka.demo.entity.User;
import com.misaka.demo.service.SmsService;
import com.misaka.demo.service.UserService;
import com.misaka.demo.util.JwtUtil;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired(required = false)
    private SmsService smsService;

    /** 用户名注册 */
    @PostMapping("/register")
    public ApiResponse<LoginResponse> register(@Valid @RequestBody RegisterRequest req) {
        User user = userService.register(req.getUsername(), req.getPassword(), req.getNickname());
        String token = jwtUtil.generateToken(user.getId(), user.getUsername());
        return ApiResponse.ok(new LoginResponse(token, UserVO.from(user)));
    }

    /** 用户名登录 */
    @PostMapping("/login")
    public ApiResponse<LoginResponse> login(@Valid @RequestBody LoginRequest req) {
        User user = userService.authenticate(req.getUsername(), req.getPassword());
        String token = jwtUtil.generateToken(user.getId(), user.getUsername());
        return ApiResponse.ok(new LoginResponse(token, UserVO.from(user)));
    }

    /** 短信验证码注册 */
    @PostMapping("/register/sms")
    public ApiResponse<LoginResponse> registerWithSms(@RequestBody RegisterWithSmsRequest req) {
        if (!smsService.verifyCode(req.getPhone(), req.getSmsCode(), "REGISTER")) {
            return ApiResponse.error(400, "验证码错误");
        }
        User user = userService.registerWithPhone(req.getPhone(), req.getPassword(), req.getNickname());
        String token = jwtUtil.generateToken(user.getId(), user.getUsername());
        return ApiResponse.ok(new LoginResponse(token, UserVO.from(user)));
    }

    /** 短信验证码登录 */
    @PostMapping("/login/sms")
    public ApiResponse<LoginResponse> loginWithSms(@RequestBody LoginWithSmsRequest req) {
        try {
            log.info("收到短信登录请求: phone={}, code={}", req.getPhone(), req.getCode() != null ? "***" : "null");
            if (smsService == null) {
                log.error("SmsService 未注入");
                return ApiResponse.error(500, "短信服务未就绪");
            }
            if (!smsService.verifyCode(req.getPhone(), req.getCode(), "LOGIN")) {
                return ApiResponse.error(400, "验证码错误");
            }
            User user = userService.findByPhone(req.getPhone());
            if (user == null) {
                return ApiResponse.error(404, "该手机号未注册");
            }
            String token = jwtUtil.generateToken(user.getId(), user.getUsername());
            return ApiResponse.ok(new LoginResponse(token, UserVO.from(user)));
        } catch (Exception e) {
            log.error("短信登录异常: ", e);
            return ApiResponse.error(500, "登录失败: " + e.getMessage());
        }
    }

    /** 获取当前用户信息 */
    @GetMapping("/me")
    public ApiResponse<UserVO> me(@RequestAttribute("userId") Long userId) {
        User user = userService.findById(userId);
        if (user == null) {
            return ApiResponse.error(404, "用户不存在");
        }
        int checkInCount = userService.countCheckIns(userId);
        int routeCount = userService.countRoutes(userId);
        return ApiResponse.ok(UserVO.from(user, checkInCount, routeCount));
    }

    /** 修改密码（需旧密码验证） */
    @PutMapping("/password")
    public ApiResponse<String> changePassword(@RequestAttribute("userId") Long userId,
                                               @RequestBody ChangePasswordRequest req) {
        userService.changePassword(userId, req.getOldPassword(), req.getNewPassword());
        return ApiResponse.ok("密码修改成功");
    }

    /** 短信验证码重置密码 */
    @PostMapping("/forgot-password")
    public ApiResponse<String> forgotPassword(@RequestBody ForgotPasswordRequest req) {
        if (!smsService.verifyCode(req.getPhone(), req.getSmsCode(), "RESET_PASSWORD")) {
            return ApiResponse.error(400, "验证码错误");
        }
        userService.resetPassword(req.getPhone(), req.getNewPassword());
        return ApiResponse.ok("密码重置成功");
    }
}
