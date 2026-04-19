package com.misaka.demo.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.misaka.demo.dto.AnimeVO;
import com.misaka.demo.dto.ApiResponse;
import com.misaka.demo.dto.PageResult;
import com.misaka.demo.entity.Anime;
import com.misaka.demo.service.AnimeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/anime")
public class AnimeController {

    @Autowired
    private AnimeService animeService;

    @GetMapping
    public ApiResponse<PageResult<AnimeVO>> list(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String region,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        // region 暂未参与查询，预留参数；命中走本地，不足兜底外部
        Page<Anime> p = animeService.search(keyword, page, size);
        return ApiResponse.ok(PageResult.from(p, AnimeVO::from));
    }

    @GetMapping("/{id}")
    public ApiResponse<AnimeVO> detail(@PathVariable("id") int id) {
        Anime a = animeService.findById(id);
        if (a == null) return ApiResponse.error(404, "作品不存在或暂无巡礼数据");
        return ApiResponse.ok(AnimeVO.from(a));
    }
}
