package com.misaka.demo.dto;

import lombok.Data;

/** 评分 / 评价请求体。score 必填(1-5)，comment 可空——纯打星也允许。 */
@Data
public class RouteRatingRequest {
    private Integer score;
    private String comment;
}
