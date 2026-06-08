package com.misaka.demo.controller;

import com.misaka.demo.dto.ApiResponse;
import com.misaka.demo.service.FusionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/fusion")
public class FusionController {

    @Autowired
    private FusionService fusionService;

    /**
     * 生成融合图：将动漫截图中的角色抠出，叠加到实景照片上。
     *
     * @param body animeUrl  动漫截图 URL（公开可访问）
     *             realUrl   实景照片 URL（公开可访问）
     * @return fusionImage  data:image/jpeg;base64,... 的融合结果图
     */
    @PostMapping
    public ApiResponse<Map<String, String>> fusion(@RequestBody Map<String, String> body) {
        String animeUrl = body.get("animeUrl");
        String realUrl  = body.get("realUrl");

        if (animeUrl == null || animeUrl.isBlank() || realUrl == null || realUrl.isBlank()) {
            return ApiResponse.error(400, "animeUrl 和 realUrl 均为必填");
        }

        try {
            String fusionImage = fusionService.generateFusion(animeUrl, realUrl);
            return ApiResponse.ok(Map.of("fusionImage", fusionImage));
        } catch (Exception e) {
            return ApiResponse.error(500, "融合图生成失败：" + e.getMessage());
        }
    }
}
