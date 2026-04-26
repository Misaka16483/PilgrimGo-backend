package com.misaka.demo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("spot")
public class Spot {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;
    private Integer animeId;
    private String anitabiPointId;
    private String nameCn;
    private String name;
    private String imageUrl;
    private Integer episode;
    private Integer sceneSeconds;
    private BigDecimal latitude;
    private BigDecimal longitude;
    /** PostGIS geometry column — handled by custom SQL, not directly bound. */
    @TableField(exist = false)
    private String location;
    private String origin;
    private String originUrl;
    private LocalDateTime createdAt;
}
