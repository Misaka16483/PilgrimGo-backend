package com.misaka.demo.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.misaka.demo.client.ExternalAnimeClient;
import com.misaka.demo.client.ExternalAnimeClient.AnitabiLite;
import com.misaka.demo.client.ExternalAnimeClient.BangumiSearchItem;
import com.misaka.demo.entity.Anime;
import com.misaka.demo.mapper.AnimeMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AnimeServiceTest {

    @Mock private AnimeMapper animeMapper;
    @Mock private ExternalAnimeClient externalClient;

    @InjectMocks private AnimeService animeService;

    private Anime sample;

    @BeforeEach
    void setUp() {
        sample = new Anime();
        sample.setBangumiId(123);
        sample.setTitleCn("中文");
        sample.setTitleJp("ja");
        sample.setPointsCount(5);
    }

    private static Page<Anime> emptyPage() {
        Page<Anime> p = new Page<>(1, 20);
        p.setRecords(new ArrayList<>());
        return p;
    }

    private static Page<Anime> pageWith(List<Anime> records) {
        Page<Anime> p = new Page<>(1, 20);
        p.setRecords(records);
        p.setTotal(records.size());
        return p;
    }

    @SuppressWarnings("unchecked")
    @Test
    void search_blankKeywordReturnsOrderedPageWithoutFallback() {
        when(animeMapper.selectPage(any(Page.class), any(QueryWrapper.class)))
                .thenReturn(pageWith(List.of(sample)));

        Page<Anime> result = animeService.search("   ", 0, 20);

        assertEquals(1, result.getRecords().size());
        verify(externalClient, never()).searchBangumi(any(), anyInt());
    }

    @SuppressWarnings("unchecked")
    @Test
    void search_localHitsAboveThresholdSkipsExternalFallback() {
        when(animeMapper.selectPage(any(Page.class), any(QueryWrapper.class)))
                .thenReturn(pageWith(List.of(sample, sample, sample)));

        animeService.search("keyword", 0, 20);

        verify(externalClient, never()).searchBangumi(any(), anyInt());
    }

    @SuppressWarnings("unchecked")
    @Test
    void search_secondPageNeverTriggersFallback() {
        when(animeMapper.selectPage(any(Page.class), any(QueryWrapper.class)))
                .thenReturn(emptyPage());

        animeService.search("keyword", 1, 20);

        verify(externalClient, never()).searchBangumi(any(), anyInt());
    }

    @SuppressWarnings("unchecked")
    @Test
    void search_lowLocalHitsTriggersExternalFallbackAndReruns() {
        // first call returns empty, second call (after fallback) returns sample
        when(animeMapper.selectPage(any(Page.class), any(QueryWrapper.class)))
                .thenReturn(emptyPage())
                .thenReturn(pageWith(List.of(sample)));

        BangumiSearchItem bgm = new BangumiSearchItem();
        bgm.setId(123);
        bgm.setName("ja");
        when(externalClient.searchBangumi("kw", 10)).thenReturn(List.of(bgm));

        AnitabiLite lite = new AnitabiLite();
        lite.setId(123);
        lite.setTitle("ja");
        lite.setCn("中文");
        lite.setGeo(Arrays.asList(35.0, 139.0));
        lite.setPointsLength(5);
        when(externalClient.fetchAnitabiLite(123)).thenReturn(lite);
        when(animeMapper.selectById(123)).thenReturn(null); // upsert insert path

        Page<Anime> result = animeService.search("kw", 0, 20);

        assertEquals(1, result.getRecords().size());
        verify(externalClient).searchBangumi("kw", 10);
        verify(externalClient).fetchAnitabiLite(123);
        verify(animeMapper).insert(any(Anime.class));
        verify(animeMapper, times(2)).selectPage(any(Page.class), any(QueryWrapper.class));
    }

    @SuppressWarnings("unchecked")
    @Test
    void search_externalFallbackErrorIsSwallowed() {
        when(animeMapper.selectPage(any(Page.class), any(QueryWrapper.class)))
                .thenReturn(emptyPage());
        when(externalClient.searchBangumi(any(), anyInt()))
                .thenThrow(new RuntimeException("network down"));

        Page<Anime> result = animeService.search("kw", 0, 20);

        assertNotNull(result);
        assertTrue(result.getRecords().isEmpty());
    }

    @Test
    void findById_returnsLocalRecordWhenPresent() {
        when(animeMapper.selectById(1)).thenReturn(sample);
        assertSame(sample, animeService.findById(1));
        verify(externalClient, never()).fetchAnitabiLite(anyInt());
    }

    @Test
    void findById_fetchesAndPersistsWhenLocalMissing() {
        when(animeMapper.selectById(7))
                .thenReturn(null)   // initial findById
                .thenReturn(null);  // upsert existence check

        AnitabiLite lite = new AnitabiLite();
        lite.setId(7);
        lite.setTitle("Original");
        lite.setCn("中文7");
        lite.setCity("Tokyo");
        lite.setCover("c.png");
        lite.setColor("#fff");
        lite.setGeo(List.of(35.0, 139.0));
        lite.setZoom(8.5);
        lite.setPointsLength(3);
        when(externalClient.fetchAnitabiLite(7)).thenReturn(lite);

        Anime result = animeService.findById(7);

        ArgumentCaptor<Anime> cap = ArgumentCaptor.forClass(Anime.class);
        verify(animeMapper).insert(cap.capture());
        Anime saved = cap.getValue();
        assertEquals(7, saved.getBangumiId());
        assertEquals("Original", saved.getTitleJp());
        assertEquals("中文7", saved.getTitleCn());
        assertEquals("Tokyo", saved.getCity());
        assertEquals("c.png", saved.getCoverUrl());
        assertEquals(0, saved.getDefaultLat().compareTo(java.math.BigDecimal.valueOf(35.0)));
        assertEquals(0, saved.getDefaultLng().compareTo(java.math.BigDecimal.valueOf(139.0)));
        assertEquals(3, saved.getPointsCount());
        assertNotNull(saved.getSyncedAt());
        assertSame(saved, result);
    }

    @Test
    void findById_returnsNullWhenAnitabiAlsoMissing() {
        when(animeMapper.selectById(99)).thenReturn(null);
        when(externalClient.fetchAnitabiLite(99)).thenReturn(null);

        assertNull(animeService.findById(99));
        verify(animeMapper, never()).insert(any(Anime.class));
    }

    @Test
    void findById_upsertUpdatesWhenAlreadyExists() {
        // initial selectById returns null so we walk the upsert branch,
        // but the upsert's selectById finds the existing row → update path
        Anime existing = new Anime();
        existing.setBangumiId(50);
        existing.setTitleJp("old");

        when(animeMapper.selectById(50))
                .thenReturn(null)        // first lookup: trigger external fetch
                .thenReturn(existing);   // upsert sees existing row

        AnitabiLite lite = new AnitabiLite();
        lite.setId(50);
        lite.setTitle("new");
        lite.setPointsLength(1);
        when(externalClient.fetchAnitabiLite(50)).thenReturn(lite);

        animeService.findById(50);

        verify(animeMapper, never()).insert(any(Anime.class));
        verify(animeMapper).updateById(existing);
        assertEquals("new", existing.getTitleJp());
        assertEquals(1, existing.getPointsCount());
    }

    @SuppressWarnings("unchecked")
    @Test
    void search_upsertFallsBackToChineseTitleWhenJpMissing() {
        when(animeMapper.selectPage(any(Page.class), any(QueryWrapper.class)))
                .thenReturn(emptyPage())
                .thenReturn(emptyPage());

        BangumiSearchItem bgm = new BangumiSearchItem();
        bgm.setId(8);
        when(externalClient.searchBangumi(any(), anyInt())).thenReturn(List.of(bgm));

        AnitabiLite lite = new AnitabiLite();
        lite.setId(8);
        lite.setCn("中文only");
        // no title, no bgm.name
        when(externalClient.fetchAnitabiLite(8)).thenReturn(lite);
        when(animeMapper.selectById(8)).thenReturn(null);

        animeService.search("kw", 0, 20);

        ArgumentCaptor<Anime> cap = ArgumentCaptor.forClass(Anime.class);
        verify(animeMapper).insert(cap.capture());
        // titleJp is NOT NULL — when JP missing it must fall back to CN
        assertEquals("中文only", cap.getValue().getTitleJp());
    }

    @SuppressWarnings("unchecked")
    @Test
    void search_skipsBangumiItemsWithoutId() {
        when(animeMapper.selectPage(any(Page.class), any(QueryWrapper.class)))
                .thenReturn(emptyPage())
                .thenReturn(emptyPage());

        BangumiSearchItem noId = new BangumiSearchItem(); // id is null
        when(externalClient.searchBangumi(any(), anyInt())).thenReturn(List.of(noId));

        animeService.search("kw", 0, 20);

        verify(externalClient, never()).fetchAnitabiLite(anyInt());
        verify(animeMapper, never()).insert(any(Anime.class));
    }
}
