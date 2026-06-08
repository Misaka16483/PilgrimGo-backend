package com.misaka.demo.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.misaka.demo.dto.AnimeVO;
import com.misaka.demo.dto.ApiResponse;
import com.misaka.demo.dto.PageResult;
import com.misaka.demo.dto.SpotVO;
import com.misaka.demo.entity.Anime;
import com.misaka.demo.entity.Spot;
import com.misaka.demo.service.AnimeService;
import com.misaka.demo.service.SpotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/anime")
public class AnimeController {

    @Autowired
    private AnimeService animeService;

    @Autowired
    private SpotService spotService;

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

    @GetMapping("/{id}/spots")
    public ApiResponse<?> spots(
            @PathVariable("id") int id,
            @RequestParam(required = false) Integer page,
            @RequestParam(required = false) Integer size,
            @RequestParam(defaultValue = "false") boolean force) {
        Anime a = spotService.findAnime(id);
        if (a == null) {
            a = animeService.findById(id);
        }
        final Anime anime = a;

        if (page == null && size == null) {
            List<Spot> spots = spotService.findByAnimeId(id, force);
            return ApiResponse.ok(spots.stream().map(s -> SpotVO.from(s, anime)).toList());
        }

        Page<Spot> spots = spotService.findByAnimeIdPage(
                id,
                false,
                page == null ? 0 : page,
                size == null ? 12 : size);
        return ApiResponse.ok(PageResult.from(spots, s -> SpotVO.from(s, anime)));
    }
}
