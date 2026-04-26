package com.misaka.demo.dto;

import com.misaka.demo.entity.Anime;
import com.misaka.demo.entity.Spot;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;

class SpotVOTest {

    private Spot baseSpot() {
        Spot s = new Spot();
        s.setId(1L);
        s.setAnimeId(100);
        s.setName("聖地");
        s.setNameCn("圣地");
        s.setLatitude(new BigDecimal("35.123456"));
        s.setLongitude(new BigDecimal("139.7654321"));
        s.setImageUrl("img.png");
        s.setEpisode(3);
        s.setSceneSeconds(125);
        return s;
    }

    @Test
    void from_prefersChineseNameAndChineseAnimeTitle() {
        Spot s = baseSpot();
        Anime a = new Anime();
        a.setTitleCn("中文标题");
        a.setTitleJp("ja");

        SpotVO vo = SpotVO.from(s, a);

        assertEquals(1L, vo.getId());
        assertEquals(100, vo.getAnimeId());
        assertEquals("中文标题", vo.getAnimeTitle());
        assertEquals("圣地", vo.getName());
        assertEquals(35.123456, vo.getLatitude(), 1e-7);
        assertEquals(139.7654321, vo.getLongitude(), 1e-7);
        assertEquals("img.png", vo.getAnimeImageUrl());
        assertEquals("EP3 @ 2:05", vo.getEpisode());
    }

    @Test
    void from_fallsBackToJapaneseAnimeTitleWhenChineseMissing() {
        Spot s = baseSpot();
        Anime a = new Anime();
        a.setTitleCn(" ");
        a.setTitleJp("ja-original");

        SpotVO vo = SpotVO.from(s, a);

        assertEquals("ja-original", vo.getAnimeTitle());
    }

    @Test
    void from_handlesNullAnime() {
        Spot s = baseSpot();
        SpotVO vo = SpotVO.from(s, null);
        assertNull(vo.getAnimeTitle());
    }

    @Test
    void from_fallsBackToOriginalNameWhenChineseBlank() {
        Spot s = baseSpot();
        s.setNameCn("");
        SpotVO vo = SpotVO.from(s, null);
        assertEquals("聖地", vo.getName());
    }

    @Test
    void from_episodeFormatWithoutSecondsOmitsTimestamp() {
        Spot s = baseSpot();
        s.setSceneSeconds(null);
        SpotVO vo = SpotVO.from(s, null);
        assertEquals("EP3", vo.getEpisode());
    }

    @Test
    void from_episodeIsNullWhenNoEpisode() {
        Spot s = baseSpot();
        s.setEpisode(null);
        SpotVO vo = SpotVO.from(s, null);
        assertNull(vo.getEpisode());
    }

    @Test
    void from_handlesNullCoordinates() {
        Spot s = baseSpot();
        s.setLatitude(null);
        s.setLongitude(null);
        SpotVO vo = SpotVO.from(s, null);
        assertNull(vo.getLatitude());
        assertNull(vo.getLongitude());
    }
}
