package com.misaka.demo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("anime")
public class Anime {
    @TableId(value = "bangumi_id", type = IdType.INPUT)
    private Integer bangumiId;
    private String titleCn;
    private String titleJp;
    private String titleEn;
    private String cat;
    private String coverUrl;
    private String iconUrl;
    private String description;
    private String city;
    private String color;
    private String abbr;
    private String site;
    private String releaseDate;
    private BigDecimal defaultLat;
    private BigDecimal defaultLng;
    private BigDecimal defaultZoom;
    private Integer pointsCount;
    private Long anitabiModified;
    private LocalDateTime syncedAt;
    private LocalDateTime createdAt;
}
