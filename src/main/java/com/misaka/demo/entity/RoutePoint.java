package com.misaka.demo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("route_point")
public class RoutePoint {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;
    private Long routeId;
    private Integer sequence;
    private BigDecimal latitude;
    private BigDecimal longitude;
    private BigDecimal altitude;
    private LocalDateTime recordedAt;
}