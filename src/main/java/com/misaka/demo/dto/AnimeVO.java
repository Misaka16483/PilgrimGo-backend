package com.misaka.demo.dto;

import com.misaka.demo.entity.Anime;
import lombok.Data;

/** 暴露给前端的 Anime 视图，字段对齐 src/types/index.ts 的 Anime。 */
@Data
public class AnimeVO {
    private Integer id;          // bangumi_id
    private String title;        // title_cn 或 title_jp
    private String titleJp;
    private String coverUrl;
    private Integer spotCount;
    private String region;       // city

    public static AnimeVO from(Anime a) {
        AnimeVO v = new AnimeVO();
        v.setId(a.getBangumiId());
        v.setTitle(a.getTitleCn() != null && !a.getTitleCn().isBlank() ? a.getTitleCn() : a.getTitleJp());
        v.setTitleJp(a.getTitleJp());
        v.setCoverUrl(a.getCoverUrl());
        v.setSpotCount(a.getPointsCount() == null ? 0 : a.getPointsCount());
        v.setRegion(a.getCity());
        return v;
    }
}
