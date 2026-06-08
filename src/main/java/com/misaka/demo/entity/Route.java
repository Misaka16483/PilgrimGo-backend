package com.misaka.demo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("route")
public class Route {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;
    private Long userId;
    private Integer animeId;
    private String title;
    private String description;
    private String difficulty;
    private Integer estimatedMinutes;
    private BigDecimal distanceKm;
    private String gpxFileUrl;
    private BigDecimal avgRating;
    private Integer ratingCount;
    private Integer followCount;
    private String status;
    private LocalDateTime recordedAt;
    private LocalDateTime createdAt;
}