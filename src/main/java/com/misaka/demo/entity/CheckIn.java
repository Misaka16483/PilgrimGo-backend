package com.misaka.demo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("check_in")
public class CheckIn {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long userId;
    private Long spotId;
    private Long routeId;
    private String photoUrl;
    private String comparisonUrl;
    private String content;
    private BigDecimal latitude;
    private BigDecimal longitude;
    private Integer likeCount;
    private LocalDateTime createdAt;
}