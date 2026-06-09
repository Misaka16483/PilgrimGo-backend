package com.misaka.demo.controller;

import com.misaka.demo.dto.ApiResponse;
import com.misaka.demo.dto.CheckInRequest;
import com.misaka.demo.dto.CheckInVO;
import com.misaka.demo.entity.CheckIn;
import com.misaka.demo.service.CheckInService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/checkins")
public class CheckInController {

    @Autowired
    private CheckInService checkInService;

    @PostMapping
    public ApiResponse<CheckIn> create(@RequestAttribute("userId") Long userId,
                                        @RequestBody CheckInRequest req) {
        try {
            CheckIn checkIn = checkInService.create(userId, req);
            return ApiResponse.ok(checkIn);
        } catch (RuntimeException e) {
            return ApiResponse.error(400, e.getMessage());
        }
    }

    @GetMapping("/feed")
    public ApiResponse<List<CheckInVO>> feed(
            @RequestAttribute("userId") Long userId,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {
        return ApiResponse.ok(checkInService.getFeed(userId, page, size));
    }

    /** "我的打卡"：当前登录用户自己发布的打卡列表，分页。 */
    @GetMapping("/mine")
    public ApiResponse<List<CheckInVO>> mine(
            @RequestAttribute("userId") Long userId,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {
        return ApiResponse.ok(checkInService.getMine(userId, page, size));
    }

    @GetMapping
    public ApiResponse<List<CheckInVO>> bySpot(
            @RequestAttribute("userId") Long userId,
            @RequestParam Long spotId,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {
        return ApiResponse.ok(checkInService.getBySpot(userId, spotId, page, size));
    }

    @PostMapping("/{id}/like")
    public ApiResponse<CheckInService.LikeResult> like(
            @RequestAttribute("userId") Long userId,
            @PathVariable Long id) {
        return ApiResponse.ok(checkInService.like(userId, id));
    }
}