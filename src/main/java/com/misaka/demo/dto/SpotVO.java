package com.misaka.demo.dto;

import com.misaka.demo.entity.Anime;
import com.misaka.demo.entity.Spot;
import lombok.Data;

/** 暴露给前端的取景地视图，字段对齐 src/types/index.ts 的 Spot。 */
@Data
public class SpotVO {
    private Long id;
    private Integer animeId;
    private String animeTitle;
    private String name;
    private String description;     // 暂无来源，预留
    private Double latitude;
    private Double longitude;
    private String animeImageUrl;
    private String realImageUrl;    // 用户实景图，暂无来源，预留
    private String episode;
    private Integer episodeNumber;
    private Integer sceneSeconds;
    private String sceneTime;
    private String origin;
    private String originUrl;

    public static SpotVO from(Spot s, Anime a) {
        SpotVO v = new SpotVO();
        v.setId(s.getId());
        v.setAnimeId(s.getAnimeId());
        v.setAnimeTitle(a == null ? null
                : (a.getTitleCn() != null && !a.getTitleCn().isBlank() ? a.getTitleCn() : a.getTitleJp()));
        // 优先中文名，没有则用原名
        v.setName(s.getNameCn() != null && !s.getNameCn().isBlank() ? s.getNameCn() : s.getName());
        if (s.getLatitude() != null) v.setLatitude(s.getLatitude().doubleValue());
        if (s.getLongitude() != null) v.setLongitude(s.getLongitude().doubleValue());
        v.setAnimeImageUrl(s.getImageUrl());
        v.setEpisode(formatEpisode(s.getEpisode(), s.getSceneSeconds()));
        v.setEpisodeNumber(s.getEpisode());
        v.setSceneSeconds(s.getSceneSeconds());
        v.setSceneTime(formatSceneTime(s.getSceneSeconds()));
        v.setOrigin(s.getOrigin());
        v.setOriginUrl(s.getOriginUrl());
        return v;
    }

    private static String formatEpisode(Integer ep, Integer seconds) {
        if (ep == null) return null;
        if (seconds == null) return "EP" + ep;
        return String.format("EP%d @ %s", ep, formatSceneTime(seconds));
    }

    private static String formatSceneTime(Integer seconds) {
        if (seconds == null) return null;
        int m = seconds / 60;
        int s = seconds % 60;
        return String.format("%d:%02d", m, s);
    }
}
