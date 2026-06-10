package com.misaka.demo.dto;

import com.misaka.demo.entity.Anime;
import com.misaka.demo.entity.Spot;
import lombok.Data;

@Data
public class SpotMapItemVO {
    private String type;
    private Long id;
    private Integer count;
    private Double latitude;
    private Double longitude;
    private Double minLat;
    private Double maxLat;
    private Double minLng;
    private Double maxLng;
    private String name;
    private String animeTitle;
    private String sceneTime;
    private String origin;

    public static SpotMapItemVO cluster(SpotMapCluster cluster) {
        SpotMapItemVO v = new SpotMapItemVO();
        v.setType("cluster");
        v.setCount(cluster.getCount());
        v.setLatitude(cluster.getLatitude());
        v.setLongitude(cluster.getLongitude());
        v.setMinLat(cluster.getMinLat());
        v.setMaxLat(cluster.getMaxLat());
        v.setMinLng(cluster.getMinLng());
        v.setMaxLng(cluster.getMaxLng());
        v.setName(cluster.getCount() + " spots");
        return v;
    }

    public static SpotMapItemVO spot(Spot s, Anime a) {
        SpotMapItemVO v = new SpotMapItemVO();
        v.setType("spot");
        v.setId(s.getId());
        v.setCount(1);
        if (s.getLatitude() != null) v.setLatitude(s.getLatitude().doubleValue());
        if (s.getLongitude() != null) v.setLongitude(s.getLongitude().doubleValue());
        v.setName(s.getNameCn() != null && !s.getNameCn().isBlank() ? s.getNameCn() : s.getName());
        v.setAnimeTitle(a == null ? null
                : (a.getTitleCn() != null && !a.getTitleCn().isBlank() ? a.getTitleCn() : a.getTitleJp()));
        v.setSceneTime(formatSceneTime(s.getSceneSeconds()));
        v.setOrigin(s.getOrigin());
        return v;
    }

    private static String formatSceneTime(Integer seconds) {
        if (seconds == null) return null;
        int m = seconds / 60;
        int s = seconds % 60;
        return String.format("%d:%02d", m, s);
    }
}
