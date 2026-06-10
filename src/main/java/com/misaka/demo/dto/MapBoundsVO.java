package com.misaka.demo.dto;

import lombok.Data;

@Data
public class MapBoundsVO {
    private Double minLat;
    private Double maxLat;
    private Double minLng;
    private Double maxLng;
    private Double latitude;
    private Double longitude;
    private Integer count;
}
