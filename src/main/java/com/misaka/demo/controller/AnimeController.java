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

    @GetMapping("/cached")
    public ApiResponse<List<AnimeVO>> cached(@RequestParam(defaultValue = "50") int limit) {
        return ApiResponse.ok(animeService.findCachedAnimeOptions(limit).stream()
                .map(AnimeVO::from)
                .toList());
    }

    @GetMapping("/external")
    public ApiResponse<PageResult<AnimeVO>> externalList(
            @RequestParam String keyword,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "12") int size) {
        Page<Anime> p = animeService.searchExternalOnly(keyword, page, size);
        return ApiResponse.ok(PageResult.from(p, AnimeVO::from));
    }

    @GetMapping("/external/{id}")
    public ApiResponse<AnimeVO> externalDetail(@PathVariable("id") int id) {
        Anime a = animeService.findExternalOnlyById(id);
        if (a == null) return ApiResponse.error(404, "外部作品暂不可用");
        return ApiResponse.ok(AnimeVO.from(a));
    }

    @GetMapping("/external/{id}/spots")
    public ApiResponse<PageResult<SpotVO>> externalSpots(
            @PathVariable("id") int id,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "12") int size) {
        Page<SpotVO> spots = spotService.findExternalByAnimeIdPage(id, page, size);
        return ApiResponse.ok(PageResult.from(spots, s -> s));
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
            @RequestParam(defaultValue = "false") boolean sync,
            @RequestParam(defaultValue = "false") boolean force) {
        Anime a = spotService.findAnime(id);
        if (a == null) {
            a = animeService.findById(id);
        }
        final Anime anime = a;

        if (page == null && size == null) {
            List<Spot> spots = spotService.findLocalByAnimeId(id);
            return ApiResponse.ok(spots.stream().map(s -> SpotVO.from(s, anime)).toList());
        }

        Page<Spot> spots = spotService.findByAnimeIdPage(
                id,
                false,
                page == null ? 0 : page,
                size == null ? 12 : size,
                sync);
        return ApiResponse.ok(PageResult.from(spots, s -> SpotVO.from(s, anime)));
    }
}
