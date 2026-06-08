package com.misaka.demo.controller;

import com.misaka.demo.dto.ApiResponse;
import com.misaka.demo.dto.BindPhoneRequest;
import com.misaka.demo.dto.UpdateProfileRequest;
import com.misaka.demo.dto.UserStatsVO;
import com.misaka.demo.entity.User;
import com.misaka.demo.service.SmsService;
import com.misaka.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired(required = false)
    private SmsService smsService;

    /** 获取用户巡礼统计 */
    @GetMapping("/me/stats")
    public ApiResponse<UserStatsVO> getMyStats(@RequestAttribute("userId") Long userId) {
        UserStatsVO stats = userService.getUserStats(userId);
        return ApiResponse.ok(stats);
    }

    /** 修改个人信息（昵称、简介） */
    @PutMapping("/profile")
    public ApiResponse<String> updateProfile(@RequestAttribute("userId") Long userId,
                                              @RequestBody UpdateProfileRequest req) {
        User user = userService.findById(userId);
        if (user == null) {
            return ApiResponse.error(404, "用户不存在");
        }
        if (req.getNickname() != null) user.setNickname(req.getNickname());
        if (req.getBio() != null) user.setBio(req.getBio());
        userService.updateUser(user);
        return ApiResponse.ok("信息更新成功");
    }

    /** 绑定手机号 */
    @PostMapping("/bind-phone")
    public ApiResponse<String> bindPhone(@RequestAttribute("userId") Long userId,
                                          @RequestBody BindPhoneRequest req) {
        if (!smsService.verifyCode(req.getPhone(), req.getSmsCode(), "BIND_PHONE")) {
            return ApiResponse.error(400, "验证码错误");
        }
        User user = userService.findById(userId);
        if (user == null) {
            return ApiResponse.error(404, "用户不存在");
        }
        if (user.getPhone() != null && !user.getPhone().isEmpty()) {
            return ApiResponse.error(400, "已绑定手机号，如需更换请联系管理员");
        }
        user.setPhone(req.getPhone());
        userService.updateUser(user);
        return ApiResponse.ok("手机号绑定成功");
    }
}
