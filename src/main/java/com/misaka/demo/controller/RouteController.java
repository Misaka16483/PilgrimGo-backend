package com.misaka.demo.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.misaka.demo.dto.ApiResponse;
import com.misaka.demo.dto.PageResult;
import com.misaka.demo.dto.RouteRatingRequest;
import com.misaka.demo.dto.RouteReviewVO;
import com.misaka.demo.dto.RouteUploadRequest;
import com.misaka.demo.dto.RouteVO;
import com.misaka.demo.entity.Anime;
import com.misaka.demo.entity.Route;
import com.misaka.demo.entity.RoutePoint;
import com.misaka.demo.entity.User;
import com.misaka.demo.entity.Waypoint;
import com.misaka.demo.service.RouteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;

@RestController
@RequestMapping("/api/routes")
public class RouteController {

    @Autowired
    private RouteService routeService;

    /** 上传录制完成的路径。需登录，作者取自 JWT filter 挂到 request 上的 userId。 */
    @PostMapping
    public ApiResponse<RouteVO> upload(@RequestAttribute(value = "userId", required = false) Long userId,
                                       @RequestBody RouteUploadRequest req) {
        try {
            Route route = routeService.uploadRoute(userId, req);
            return ApiResponse.ok(toVO(route));
        } catch (RuntimeException e) {
            return ApiResponse.error(400, e.getMessage());
        }
    }

    /**
     * "我的路径"：当前登录用户发布的路径列表，按创建时间倒序分页。
     * 同样跳过 trackPoints，列表卡片用不到完整轨迹。
     */
    @GetMapping("/mine")
    public ApiResponse<PageResult<RouteVO>> mine(
            @RequestAttribute(value = "userId", required = false) Long userId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        if (userId == null) return ApiResponse.error(401, "未登录");
        Page<Route> p = routeService.findByUser(userId, page, size);
        return ApiResponse.ok(PageResult.from(p,
                route -> toListVO(route, routeService.findAnime(route.getAnimeId()))));
    }

    @GetMapping("/{id}")
    public ApiResponse<RouteVO> detail(@PathVariable("id") long id) {
        Route route = routeService.findById(id);
        if (route == null) return ApiResponse.error(404, "路径不存在");
        return ApiResponse.ok(toVO(route));
    }

    /** 给路径评分并可附文字评论。同一用户重复提交是覆盖最新一条。需登录。 */
    @PostMapping("/{id}/rate")
    public ApiResponse<RouteService.RatingSummary> rate(
            @RequestAttribute(value = "userId", required = false) Long userId,
            @PathVariable("id") long id,
            @RequestBody RouteRatingRequest req) {
        try {
            return ApiResponse.ok(routeService.rateRoute(userId, id, req.getScore(), req.getComment()));
        } catch (RuntimeException e) {
            return ApiResponse.error(400, e.getMessage());
        }
    }

    /** 路径的全部评价（评分 + 评论）列表，按"有评论优先、再按时间倒序"。 */
    @GetMapping("/{id}/reviews")
    public ApiResponse<List<RouteReviewVO>> reviews(
            @PathVariable("id") long id,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        return ApiResponse.ok(routeService.listReviews(id, page, size));
    }

    /**
     * 按作品列出已有巡礼路径，供作品详情页"已有路径"区块使用。
     * 列表视图省略 trackPoints，避免单次响应携带海量轨迹点。
     */
    @GetMapping
    public ApiResponse<PageResult<RouteVO>> list(
            @RequestParam("animeId") int animeId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(defaultValue = "rating") String sort) {
        Page<Route> p = routeService.findByAnime(animeId, page, size, sort);
        Anime anime = routeService.findAnime(animeId);
        return ApiResponse.ok(PageResult.from(p, route -> toListVO(route, anime)));
    }

    private RouteVO toVO(Route route) {
        Anime anime = routeService.findAnime(route.getAnimeId());
        User author = route.getUserId() == null ? null : routeService.findAuthor(route.getUserId());
        List<RoutePoint> points = routeService.findPoints(route.getId());
        List<Waypoint> waypoints = routeService.findWaypoints(route.getId());
        var spots = route.getUserId() == null ? Collections.<com.misaka.demo.service.RouteService.RouteSpotDetail>emptyList()
                : routeService.findRouteSpots(route.getId(), route.getUserId());
        return RouteVO.from(route, anime, author, points, waypoints, spots);
    }

    /** 列表场景 VO：跳过轨迹点查询，作者按需查；anime 由调用方传入避免 N+1。
     *  spots 仍然查（列表卡片要 spotCount + 缩略图），但作者照片这里其实用不到，
     *  暂时简单复用 findRouteSpots，未来要做列表瘦身再拆。 */
    private RouteVO toListVO(Route route, Anime anime) {
        User author = route.getUserId() == null ? null : routeService.findAuthor(route.getUserId());
        List<Waypoint> waypoints = routeService.findWaypoints(route.getId());
        var spots = route.getUserId() == null ? Collections.<com.misaka.demo.service.RouteService.RouteSpotDetail>emptyList()
                : routeService.findRouteSpots(route.getId(), route.getUserId());
        return RouteVO.from(route, anime, author, Collections.emptyList(), waypoints, spots);
    }
}