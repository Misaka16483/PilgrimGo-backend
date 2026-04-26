package com.misaka.demo.controller;

import com.misaka.demo.dto.ApiResponse;
import com.misaka.demo.dto.SpotVO;
import com.misaka.demo.entity.Anime;
import com.misaka.demo.entity.Spot;
import com.misaka.demo.service.SpotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/spots")
public class SpotController {

    private static final int NEARBY_LIMIT = 200;

    @Autowired
    private SpotService spotService;

    /** 半径搜索：返回坐标附近的取景地，给地图标注使用。 */
    @GetMapping("/nearby")
    public ApiResponse<List<SpotVO>> nearby(
            @RequestParam double latitude,
            @RequestParam double longitude,
            @RequestParam(defaultValue = "5000") int radius) {
        List<Spot> spots = spotService.findNearby(latitude, longitude, radius, NEARBY_LIMIT);
        return ApiResponse.ok(toVOList(spots));
    }

    @GetMapping("/{id}")
    public ApiResponse<SpotVO> detail(@PathVariable("id") long id) {
        Spot s = spotService.findById(id);
        if (s == null) return ApiResponse.error(404, "取景地不存在");
        Anime a = spotService.findAnime(s.getAnimeId());
        return ApiResponse.ok(SpotVO.from(s, a));
    }

    /** 批量塞 anime title，避免每条 spot 各打一次 anime 表。 */
    private List<SpotVO> toVOList(List<Spot> spots) {
        if (spots.isEmpty()) return List.of();
        Map<Integer, Anime> animeCache = new HashMap<>();
        return spots.stream()
                .map(s -> SpotVO.from(s,
                        animeCache.computeIfAbsent(s.getAnimeId(), spotService::findAnime)))
                .collect(Collectors.toList());
    }
}
