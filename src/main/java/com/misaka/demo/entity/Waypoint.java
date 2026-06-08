package com.misaka.demo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;

@Data
@TableName("waypoint")
public class Waypoint {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;
    private Long routeId;
    private Long spotId;
    private Integer sequence;
    private BigDecimal latitude;
    private BigDecimal longitude;
    private String photoUrl;
    private String instruction;
    private String waypointType;
}