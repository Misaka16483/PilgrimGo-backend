package com.misaka.demo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("route_spot")
public class RouteSpot {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;
    private Long routeId;
    private Long spotId;
    private Integer visitOrder;
}
