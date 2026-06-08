package com.misaka.demo.dto;

import lombok.Data;

import java.util.List;

/** 前端 src/api/route.ts 的 uploadRoute 请求体。 */
@Data
public class RouteUploadRequest {

    private Integer animeId;
    private String title;
    private String description;
    private List<TrackPointDTO> trackPoints;
    private List<WaypointDTO> waypoints;
    /** 录制开始时用户选定的目标取景地，按到访顺序。无论是否实际拍照都会写入 route_spot。 */
    private List<Long> spotIds;
    /** 录制期间用户在 /ar/compare 完成的打卡 id；上传时反向把这些 check_in.route_id 补成当前路径。 */
    private List<Long> checkInIds;

    @Data
    public static class TrackPointDTO {
        private Double latitude;
        private Double longitude;
        private Double altitude;
        /** 客户端记录的毫秒时间戳 */
        private Long timestamp;
    }

    @Data
    public static class WaypointDTO {
        private GeoPointDTO location;
        private String imageUrl;
        private String description;
        private Integer orderIndex;
    }

    @Data
    public static class GeoPointDTO {
        private Double latitude;
        private Double longitude;
        private Double altitude;
        private Long timestamp;
    }
}