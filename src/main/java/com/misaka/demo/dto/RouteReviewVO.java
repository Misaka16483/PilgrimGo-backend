package com.misaka.demo.dto;

import lombok.Data;

import java.time.LocalDateTime;

/** 路径评价列表项：一条评分 + 评论，附评价人信息。对应前端 RouteReview。 */
@Data
public class RouteReviewVO {
    private Long id;
    private Long routeId;
    private Long userId;
    private String authorName;
    private String authorAvatar;
    private Integer score;
    private String comment;
    private LocalDateTime createdAt;
}
