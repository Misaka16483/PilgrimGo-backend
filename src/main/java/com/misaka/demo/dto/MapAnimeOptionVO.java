package com.misaka.demo.dto;

import com.misaka.demo.entity.Anime;
import lombok.Data;

@Data
public class MapAnimeOptionVO {
    private Integer id;
    private String title;

    public static MapAnimeOptionVO from(Anime anime) {
        MapAnimeOptionVO vo = new MapAnimeOptionVO();
        vo.setId(anime.getBangumiId());
        vo.setTitle(anime.getTitleCn() != null && !anime.getTitleCn().isBlank()
                ? anime.getTitleCn()
                : anime.getTitleJp());
        return vo;
    }
}
