package com.misaka.demo.controller;

import com.misaka.demo.dto.ApiResponse;
import com.misaka.demo.dto.MapAnimeOptionVO;
import com.misaka.demo.dto.SpotMapItemVO;
import com.misaka.demo.dto.SpotVO;
import com.misaka.demo.entity.Anime;
import com.misaka.demo.entity.Spot;
import com.misaka.demo.service.SpotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/spots")
public class SpotController {

    @Autowired
    private SpotService spotService;

    @GetMapping("/map")
    public ApiResponse<List<SpotMapItemVO>> mapItems(
            @RequestParam double minLat,
            @RequestParam double maxLat,
            @RequestParam double minLng,
            @RequestParam double maxLng,
            @RequestParam(defaultValue = "10") double zoom,
            @RequestParam(defaultValue = "180") int limit,
            @RequestParam(required = false) Integer animeId) {
        return ApiResponse.ok(spotService.findMapItems(minLat, maxLat, minLng, maxLng, zoom, limit, animeId));
    }

    @GetMapping("/map/anime")
    public ApiResponse<List<MapAnimeOptionVO>> mapAnimeOptions(
            @RequestParam(defaultValue = "50") int limit) {
        return ApiResponse.ok(spotService.findMapAnimeOptions(limit));
    }

    @GetMapping("/{id}")
    public ApiResponse<SpotVO> detail(@PathVariable("id") long id) {
        Spot s = spotService.findById(id);
        if (s == null) return ApiResponse.error(404, "取景地不存在");
        Anime a = spotService.findAnime(s.getAnimeId());
        return ApiResponse.ok(SpotVO.from(s, a));
    }
}
