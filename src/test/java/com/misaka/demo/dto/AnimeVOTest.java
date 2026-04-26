package com.misaka.demo.dto;

import com.misaka.demo.entity.Anime;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class AnimeVOTest {

    @Test
    void from_prefersChineseTitleWhenPresent() {
        Anime a = new Anime();
        a.setBangumiId(1001);
        a.setTitleCn("中文名");
        a.setTitleJp("日本語タイトル");
        a.setCoverUrl("cover.png");
        a.setPointsCount(12);
        a.setCity("Tokyo");

        AnimeVO vo = AnimeVO.from(a);

        assertEquals(1001, vo.getId());
        assertEquals("中文名", vo.getTitle());
        assertEquals("日本語タイトル", vo.getTitleJp());
        assertEquals("cover.png", vo.getCoverUrl());
        assertEquals(12, vo.getSpotCount());
        assertEquals("Tokyo", vo.getRegion());
    }

    @Test
    void from_fallsBackToJapaneseTitleWhenChineseBlank() {
        Anime a = new Anime();
        a.setBangumiId(2);
        a.setTitleCn("   ");
        a.setTitleJp("Original");

        AnimeVO vo = AnimeVO.from(a);

        assertEquals("Original", vo.getTitle());
    }

    @Test
    void from_defaultsSpotCountToZeroWhenNull() {
        Anime a = new Anime();
        a.setBangumiId(3);
        a.setTitleJp("X");
        a.setPointsCount(null);

        AnimeVO vo = AnimeVO.from(a);

        assertEquals(0, vo.getSpotCount());
    }
}
