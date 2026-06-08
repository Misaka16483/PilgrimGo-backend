package com.misaka.demo.dto;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class CheckInRequest {
    private Long spotId;
    private Long routeId;
    private String photoUrl;
    private String comparisonUrl;
    private String content;
    private BigDecimal latitude;
    private BigDecimal longitude;
}