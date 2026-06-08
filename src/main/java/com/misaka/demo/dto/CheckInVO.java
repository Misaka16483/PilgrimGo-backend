package com.misaka.demo.dto;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class CheckInVO {
    private Long id;
    private Long userId;
    private String username;
    private String avatarUrl;
    private Long spotId;
    private String spotName;
    private String spotNameCn;
    private Long routeId;
    private String photoUrl;
    private String comparisonUrl;
    private String content;
    private BigDecimal latitude;
    private BigDecimal longitude;
    private Integer likeCount;
    private Boolean liked;
    private LocalDateTime createdAt;
}