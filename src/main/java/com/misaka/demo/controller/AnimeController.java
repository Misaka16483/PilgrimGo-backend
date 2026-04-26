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
import java.util.stream.Collectors;

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

    /**
     * 作品下所有取景地，本地缺失或不齐时触发 Anitabi 同步并落库。
     * force=true 强制重拉一遍（手动刷新/排错用）。
     */
    @GetMapping("/{id}/spots")
    public ApiResponse<List<SpotVO>> spots(
            @PathVariable("id") int id,
            @RequestParam(defaultValue = "false") boolean force) {
        Anime a = animeService.findById(id);
        List<Spot> spots = spotService.findByAnimeId(id, force);
        List<SpotVO> vos = spots.stream()
                .map(s -> SpotVO.from(s, a))
                .collect(Collectors.toList());
        return ApiResponse.ok(vos);
    }
}
