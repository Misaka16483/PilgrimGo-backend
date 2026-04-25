package com.misaka.demo.controller;

import com.misaka.demo.dto.ApiResponse;
import com.misaka.demo.dto.SmsSendRequest;
import com.misaka.demo.dto.SmsVerifyRequest;
import com.misaka.demo.service.SmsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/sms")
public class SmsController {

    @Autowired
    private SmsService smsService;

    @PostMapping("/send")
    public ApiResponse<Map<String, Object>> sendCode(@RequestBody SmsSendRequest request) {
        try {
            // 验证手机号格式
            if (!isValidPhone(request.getPhone())) {
                return ApiResponse.error(400, "手机号格式不正确");
            }

            // 发送验证码
            String type = request.getType() != null ? request.getType() : "REGISTER";
            SmsService.SmsSendResult result = smsService.sendVerificationCode(request.getPhone(), type);

            if (!result.isSuccess()) {
                String errorMsg = result.getErrorMessage() != null ? result.getErrorMessage() : "未知错误";
                return ApiResponse.error(500, "发送失败: " + errorMsg);
            }

            Map<String, Object> data = new HashMap<>();
            data.put("message", "验证码发送成功");
            data.put("bizId", result.getBizId());
            
            // 注意：生产环境不应该返回验证码，这里仅用于测试
            if (result.getVerifyCode() != null) {
                data.put("verifyCode", result.getVerifyCode());
            }

            return ApiResponse.ok(data);
        } catch (RuntimeException e) {
            return ApiResponse.error(500, e.getMessage());
        }
    }

    @PostMapping("/verify")
    public ApiResponse<Map<String, Boolean>> verifyCode(@RequestBody SmsVerifyRequest request) {
        try {
            // 验证手机号格式
            if (!isValidPhone(request.getPhone())) {
                return ApiResponse.error(400, "手机号格式不正确");
            }

            // 验证验证码
            String type = request.getType() != null ? request.getType() : "REGISTER";
            boolean verified = smsService.verifyCode(request.getPhone(), request.getCode(), type);

            Map<String, Boolean> data = new HashMap<>();
            data.put("verified", verified);

            return ApiResponse.ok(data);
        } catch (RuntimeException e) {
            return ApiResponse.error(500, e.getMessage());
        }
    }

    private boolean isValidPhone(String phone) {
        return phone != null && phone.matches("^1[3-9]\\d{9}$");
    }
}
