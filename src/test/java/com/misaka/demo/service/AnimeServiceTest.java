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
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

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
        sample.setTitleCn("Title CN");
        sample.setTitleJp("Title JP");
        sample.setPointsCount(5);
    }

    private static Page<Anime> emptyPage() {
        Page<Anime> page = new Page<>(1, 20);
        page.setRecords(new ArrayList<>());
        return page;
    }

    private static Page<Anime> pageWith(List<Anime> records) {
        Page<Anime> page = new Page<>(1, 20);
        page.setRecords(records);
        page.setTotal(records.size());
        return page;
    }

    @SuppressWarnings("unchecked")
    @Test
    void search_blankKeywordReturnsOrderedPageWithoutFallback() {
        when(animeMapper.selectSearchAnimeWithSpots(any(Page.class), any()))
                .thenReturn(pageWith(List.of(sample)));

        Page<Anime> result = animeService.search("   ", 0, 20);

        assertEquals(1, result.getRecords().size());
        verify(externalClient, never()).searchBangumi(any(), anyInt());
    }

    @SuppressWarnings("unchecked")
    @Test
    void search_localHitsSkipExternalFallback() {
        when(animeMapper.selectSearchAnimeWithSpots(any(Page.class), any()))
                .thenReturn(pageWith(List.of(sample, sample, sample)));

        animeService.search("keyword", 0, 20);

        verify(externalClient, never()).searchBangumi(any(), anyInt());
    }

    @SuppressWarnings("unchecked")
    @Test
    void search_secondPageNeverTriggersFallback() {
        when(animeMapper.selectSearchAnimeWithSpots(any(Page.class), any()))
                .thenReturn(emptyPage());

        animeService.search("keyword", 1, 20);

        verify(externalClient, never()).searchBangumi(any(), anyInt());
    }

    @SuppressWarnings("unchecked")
    @Test
    void search_lowLocalHitsDoesNotTriggerExternalFallback() {
        when(animeMapper.selectSearchAnimeWithSpots(any(Page.class), any()))
                .thenReturn(emptyPage());

        Page<Anime> result = animeService.search("kw", 0, 20);

        assertTrue(result.getRecords().isEmpty());
        verify(externalClient, never()).searchBangumi(any(), anyInt());
        verify(externalClient, never()).fetchAnitabiLite(anyInt());
        verify(animeMapper, never()).insert(any(Anime.class));
    }

    @SuppressWarnings("unchecked")
    @Test
    void search_missingLocalDataReturnsEmptyPage() {
        when(animeMapper.selectSearchAnimeWithSpots(any(Page.class), any()))
                .thenReturn(emptyPage());

        Page<Anime> result = animeService.search("kw", 0, 20);

        assertNotNull(result);
        assertTrue(result.getRecords().isEmpty());
        verify(externalClient, never()).searchBangumi(any(), anyInt());
    }

    @Test
    void findById_returnsLocalRecordWhenPresent() {
        when(animeMapper.selectById(1)).thenReturn(sample);
        assertSame(sample, animeService.findById(1));
        verify(externalClient, never()).fetchAnitabiLite(anyInt());
    }

    @Test
    void findById_returnsNullWhenLocalMissing() {
        when(animeMapper.selectById(7)).thenReturn(null);

        assertNull(animeService.findById(7));
        verify(externalClient, never()).fetchAnitabiLite(anyInt());
        verify(animeMapper, never()).insert(any(Anime.class));
    }

    @Test
    void findById_prefersImagesLengthForDisplaySpotCount() {
        when(animeMapper.selectById(7)).thenReturn(null);

        AnitabiLite lite = new AnitabiLite();
        lite.setId(7);
        lite.setTitle("Original");
        lite.setPointsLength(300);
        lite.setImagesLength(12);
        when(externalClient.fetchAnitabiLite(7)).thenReturn(lite);

        animeService.syncByBangumiId(7, true);

        ArgumentCaptor<Anime> captor = ArgumentCaptor.forClass(Anime.class);
        verify(animeMapper).insert(captor.capture());
        assertEquals(12, captor.getValue().getPointsCount());
    }

    @Test
    void findById_returnsNullWhenAnitabiAlsoMissing() {
        when(animeMapper.selectById(99)).thenReturn(null);

        assertNull(animeService.findById(99));
        verify(externalClient, never()).fetchAnitabiLite(anyInt());
        verify(animeMapper, never()).insert(any(Anime.class));
    }

    @Test
    void findById_upsertUpdatesWhenAlreadyExists() {
        Anime existing = new Anime();
        existing.setBangumiId(50);
        existing.setTitleJp("old");

        when(animeMapper.selectById(50)).thenReturn(null);

        AnitabiLite lite = new AnitabiLite();
        lite.setId(50);
        lite.setTitle("new");
        lite.setPointsLength(1);
        when(externalClient.fetchAnitabiLite(50)).thenReturn(lite);

        when(animeMapper.selectById(50)).thenReturn(null);

        animeService.syncByBangumiId(50, true);

        verify(animeMapper).insert(any(Anime.class));
    }

    @SuppressWarnings("unchecked")
    @Test
    void searchAndSyncOfficial_upsertFallsBackToChineseTitleWhenJpMissing() {
        when(animeMapper.selectPage(any(Page.class), any(QueryWrapper.class)))
                .thenReturn(emptyPage());

        BangumiSearchItem bangumi = new BangumiSearchItem();
        bangumi.setId(8);
        when(externalClient.searchBangumi(any(), anyInt())).thenReturn(List.of(bangumi));

        AnitabiLite lite = new AnitabiLite();
        lite.setId(8);
        lite.setCn("CN only");
        when(externalClient.fetchAnitabiLite(8)).thenReturn(lite);
        when(animeMapper.selectById(8)).thenReturn(null);

        animeService.searchAndSyncOfficial("kw", 0, 20);

        ArgumentCaptor<Anime> captor = ArgumentCaptor.forClass(Anime.class);
        verify(animeMapper).insert(captor.capture());
        assertEquals("CN only", captor.getValue().getTitleJp());
    }

    @SuppressWarnings("unchecked")
    @Test
    void searchAndSyncOfficial_skipsBangumiItemsWithoutId() {
        when(animeMapper.selectPage(any(Page.class), any(QueryWrapper.class)))
                .thenReturn(emptyPage());

        BangumiSearchItem noId = new BangumiSearchItem();
        when(externalClient.searchBangumi(any(), anyInt())).thenReturn(List.of(noId));

        animeService.searchAndSyncOfficial("kw", 0, 20);

        verify(externalClient, never()).fetchAnitabiLite(anyInt());
        verify(animeMapper, never()).insert(any(Anime.class));
    }

    @SuppressWarnings("unchecked")
    @Test
    void searchAndSyncOfficial_fetchesOfficialResultsBeforeReturningLocalPage() {
        BangumiSearchItem bangumi = new BangumiSearchItem();
        bangumi.setId(88);
        bangumi.setName("Original 88");
        when(externalClient.searchBangumi("official", 5)).thenReturn(List.of(bangumi));

        AnitabiLite lite = new AnitabiLite();
        lite.setId(88);
        lite.setTitle("Original 88");
        lite.setCn("Title CN 88");
        lite.setModified(12345L);
        when(externalClient.fetchAnitabiLite(88)).thenReturn(lite);
        when(animeMapper.selectById(88)).thenReturn(null);
        when(animeMapper.selectPage(any(Page.class), any(QueryWrapper.class)))
                .thenReturn(pageWith(List.of(sample)));

        Page<Anime> result = animeService.searchAndSyncOfficial("official", 0, 20);

        assertEquals(1, result.getRecords().size());
        verify(externalClient).searchBangumi("official", 5);
        verify(animeMapper).insert(any(Anime.class));
    }

    @SuppressWarnings("unchecked")
    @Test
    void searchAndSyncOfficial_skipsUpdateWhenModifiedTimestampUnchanged() {
        Anime existing = new Anime();
        existing.setBangumiId(88);
        existing.setTitleJp("old");
        existing.setAnitabiModified(12345L);

        BangumiSearchItem bangumi = new BangumiSearchItem();
        bangumi.setId(88);
        bangumi.setName("Original 88");
        when(externalClient.searchBangumi("official", 5)).thenReturn(List.of(bangumi));

        AnitabiLite lite = new AnitabiLite();
        lite.setId(88);
        lite.setTitle("Original 88");
        lite.setModified(12345L);
        when(externalClient.fetchAnitabiLite(88)).thenReturn(lite);
        when(animeMapper.selectById(88)).thenReturn(existing);
        when(animeMapper.selectPage(any(Page.class), any(QueryWrapper.class)))
                .thenReturn(pageWith(List.of(existing)));

        animeService.searchAndSyncOfficial("official", 0, 20);

        verify(animeMapper, never()).updateById(any(Anime.class));
        verify(animeMapper, never()).insert(any(Anime.class));
    }
}
