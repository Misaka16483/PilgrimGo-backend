package com.misaka.demo.controller;

import com.misaka.demo.dto.ApiResponse;
import com.misaka.demo.dto.PresignRequest;
import com.misaka.demo.dto.PresignVO;
import com.misaka.demo.dto.StsCredentialsVO;
import com.misaka.demo.service.OssService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/oss")
public class OssController {

    @Autowired
    private OssService ossService;

    /**
     * 签发用于转折点图片直传的 STS 临时凭证。
     * 必须登录：JwtAuthFilter 已对 /api/oss/** 强制鉴权（不在公共白名单内）。
     */
    @GetMapping("/sts")
    public ApiResponse<StsCredentialsVO> waypointSts(@RequestAttribute("userId") Long userId) {
        try {
            return ApiResponse.ok(ossService.issueWaypointUploadCredentials(userId));
        } catch (RuntimeException e) {
            return ApiResponse.error(500, e.getMessage());
        }
    }

    /**
     * 转折点图片上传：服务端预签名 PUT URL。
     * 前端 PUT uploadUrl + body=文件二进制（Content-Type 头与返回值一致），
     * 上传成功后把 publicUrl 写到 waypoint.imageUrl/photoUrl。
     */
    @PostMapping("/presign")
    public ApiResponse<PresignVO> presignWaypoint(@RequestAttribute("userId") Long userId,
                                                  @RequestBody(required = false) PresignRequest req) {
        try {
            String ext = req == null ? null : req.getExt();
            String contentType = req == null ? null : req.getContentType();
            return ApiResponse.ok(ossService.presignWaypointUpload(userId, ext, contentType));
        } catch (RuntimeException e) {
            return ApiResponse.error(500, e.getMessage());
        }
    }
}
