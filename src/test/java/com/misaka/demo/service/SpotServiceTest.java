package com.misaka.demo.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.misaka.demo.client.ExternalAnimeClient;
import com.misaka.demo.client.ExternalAnimeClient.AnitabiPoint;
import com.misaka.demo.entity.Anime;
import com.misaka.demo.entity.Spot;
import com.misaka.demo.mapper.AnimeMapper;
import com.misaka.demo.mapper.SpotMapper;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyBoolean;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
class SpotServiceTest {

    @Mock private SpotMapper spotMapper;
    @Mock private AnimeMapper animeMapper;
    @Mock private AnimeService animeService;
    @Mock private ExternalAnimeClient externalClient;

    @InjectMocks private SpotService spotService;

    private static AnitabiPoint point(String id, String name, double lat, double lng) {
        AnitabiPoint point = new AnitabiPoint();
        point.setId(id);
        point.setName(name);
        point.setGeo(List.of(lat, lng));
        return point;
    }

    private static Spot spot(long id, int animeId) {
        Spot spot = new Spot();
        spot.setId(id);
        spot.setAnimeId(animeId);
        return spot;
    }

    @Test
    void findById_delegatesToMapper() {
        Spot spot = spot(7L, 1);
        when(spotMapper.selectById(7L)).thenReturn(spot);
        assertSame(spot, spotService.findById(7L));
    }

    @Test
    void findAnime_delegatesToMapper() {
        Anime anime = new Anime();
        when(animeMapper.selectById(99)).thenReturn(anime);
        assertSame(anime, spotService.findAnime(99));
    }

    @Test
    void findByAnimeId_returnsLocalWhenCountSatisfiesExpected() {
        List<Spot> local = List.of(spot(1, 10), spot(2, 10), spot(3, 10));
        when(spotMapper.selectList(any(QueryWrapper.class))).thenReturn(local);

        Anime before = new Anime();
        before.setBangumiId(10);
        before.setPointsCount(3);
        before.setAnitabiModified(100L);

        Anime after = new Anime();
        after.setBangumiId(10);
        after.setPointsCount(3);
        after.setAnitabiModified(100L);

        when(animeMapper.selectById(10)).thenReturn(before);
        when(animeService.syncByBangumiId(10, false)).thenReturn(after);

        List<Spot> result = spotService.findByAnimeId(10, false);

        assertSame(local, result);
        verify(externalClient, never()).fetchAnitabiPoints(anyInt());
    }

    @Test
    void findByAnimeId_returnsLocalWhenAnimeMetadataAbsent() {
        when(spotMapper.selectList(any(QueryWrapper.class))).thenReturn(List.of());
        when(animeMapper.selectById(404)).thenReturn(null);
        when(animeService.syncByBangumiId(404, false)).thenReturn(null);

        List<Spot> result = spotService.findByAnimeId(404, false);

        assertTrue(result.isEmpty());
        verify(externalClient, never()).fetchAnitabiPoints(anyInt());
    }

    @Test
    void findByAnimeId_syncsWhenLocalEmpty() {
        Spot synced = spot(11L, 10);
        when(spotMapper.selectList(any(QueryWrapper.class)))
                .thenReturn(new ArrayList<>())
                .thenReturn(List.of(synced));

        Anime anime = new Anime();
        anime.setBangumiId(10);
        anime.setPointsCount(1);
        anime.setAnitabiModified(100L);

        when(animeMapper.selectById(10)).thenReturn(anime);

        AnitabiPoint point = point("p1", "取景地", 35.5, 139.5);
        when(externalClient.fetchAnitabiPoints(10)).thenReturn(List.of(point));
        when(spotMapper.selectByAnitabiPointId("p1")).thenReturn(null);

        List<Spot> result = spotService.findByAnimeId(10, false);

        assertEquals(List.of(synced), result);
        verify(spotMapper).insert(any(Spot.class));
    }

    @Test
    void findByAnimeId_forceTrueAlwaysSyncs() {
        when(spotMapper.selectList(any(QueryWrapper.class)))
                .thenReturn(List.of(spot(1, 10), spot(2, 10), spot(3, 10)))
                .thenReturn(List.of(spot(1, 10), spot(2, 10), spot(3, 10)));

        Anime before = new Anime();
        before.setBangumiId(10);
        before.setPointsCount(3);
        before.setAnitabiModified(100L);

        Anime after = new Anime();
        after.setBangumiId(10);
        after.setPointsCount(3);
        after.setAnitabiModified(100L);

        when(animeMapper.selectById(10)).thenReturn(before);
        when(animeService.syncByBangumiId(10, true)).thenReturn(after);
        when(externalClient.fetchAnitabiPoints(10)).thenReturn(List.of());

        spotService.findByAnimeId(10, true);

        verify(externalClient).fetchAnitabiPoints(10);
    }

    @Test
    void findByAnimeId_doesNotSyncWhenAnimeModifiedChangedButLocalSpotsExist() {
        when(spotMapper.selectList(any(QueryWrapper.class)))
                .thenReturn(List.of(spot(1, 10)))
                .thenReturn(List.of(spot(1, 10)));

        Anime before = new Anime();
        before.setBangumiId(10);
        before.setPointsCount(1);
        before.setAnitabiModified(100L);

        Anime after = new Anime();
        after.setBangumiId(10);
        after.setPointsCount(1);
        after.setAnitabiModified(101L);

        when(animeMapper.selectById(10)).thenReturn(before);
        when(animeService.syncByBangumiId(10, false)).thenReturn(after);
        when(externalClient.fetchAnitabiPoints(10)).thenReturn(List.of());

        spotService.findByAnimeId(10, false);

        verify(externalClient, never()).fetchAnitabiPoints(anyInt());
    }

    @Test
    void findByAnimeId_returnsLocalWhenExternalFetchEmpty() {
        List<Spot> local = List.of(spot(1, 10));
        when(spotMapper.selectList(any(QueryWrapper.class))).thenReturn(local);

        Anime before = new Anime();
        before.setPointsCount(5);
        before.setAnitabiModified(100L);

        Anime after = new Anime();
        after.setPointsCount(5);
        after.setAnitabiModified(100L);

        when(animeMapper.selectById(10)).thenReturn(before);
        when(animeService.syncByBangumiId(10, false)).thenReturn(after);
        when(externalClient.fetchAnitabiPoints(10)).thenReturn(List.of());

        List<Spot> result = spotService.findByAnimeId(10, false);

        assertSame(local, result);
        verify(spotMapper, never()).insert(any(Spot.class));
    }

    @Test
    void findByAnimeIdPage_skipsSyncWhenForceFalseAndLocalExists() {
        Page<Spot> page = new Page<>(2, 12);
        page.setRecords(List.of(spot(13, 10)));
        when(spotMapper.selectCount(any(QueryWrapper.class))).thenReturn(1L);
        when(spotMapper.selectPage(any(Page.class), any(QueryWrapper.class))).thenReturn(page);

        Page<Spot> result = spotService.findByAnimeIdPage(10, false, 0, 12);

        assertSame(page, result);
        verify(animeService, never()).syncByBangumiId(anyInt(), anyBoolean());
        verify(externalClient, never()).fetchAnitabiPoints(anyInt());
    }

    @Test
    void findByAnimeIdPage_defaultDoesNotSyncWhenLocalEmpty() {
        Page<Spot> page = new Page<>(1, 12);
        page.setRecords(List.of(spot(13, 10)));
        when(spotMapper.selectCount(any(QueryWrapper.class))).thenReturn(0L);
        when(spotMapper.selectPage(any(Page.class), any(QueryWrapper.class))).thenReturn(page);

        Page<Spot> result = spotService.findByAnimeIdPage(10, false, 0, 12);

        assertSame(page, result);
        verify(externalClient, never()).fetchAnitabiPoints(10);
        verify(spotMapper, never()).insert(any(Spot.class));
    }

    @Test
    void findByAnimeId_externalErrorFallsBackToLocal() {
        List<Spot> local = List.of(spot(1, 10));
        when(spotMapper.selectList(any(QueryWrapper.class))).thenReturn(local);

        Anime before = new Anime();
        before.setPointsCount(5);
        before.setAnitabiModified(100L);

        Anime after = new Anime();
        after.setPointsCount(5);
        after.setAnitabiModified(101L);

        when(animeMapper.selectById(10)).thenReturn(before);
        when(animeService.syncByBangumiId(10, false)).thenReturn(after);
        when(externalClient.fetchAnitabiPoints(10))
                .thenThrow(new RuntimeException("anitabi down"));

        List<Spot> result = spotService.findByAnimeId(10, false);

        assertSame(local, result);
    }

    @Test
    void findByAnimeId_skipsPointsWithoutGeoOrId() {
        when(spotMapper.selectList(any(QueryWrapper.class)))
                .thenReturn(new ArrayList<>())
                .thenReturn(new ArrayList<>());

        Anime anime = new Anime();
        anime.setPointsCount(0);
        anime.setAnitabiModified(100L);
        when(animeMapper.selectById(10)).thenReturn(null);
        when(animeService.syncByBangumiId(10, true)).thenReturn(anime);

        AnitabiPoint noId = new AnitabiPoint();
        noId.setGeo(List.of(35.0, 139.0));
        AnitabiPoint badGeo = point("p1", "n", 0, 0);
        badGeo.setGeo(List.of(35.0));
        AnitabiPoint nullGeo = new AnitabiPoint();
        nullGeo.setId("p2");

        when(externalClient.fetchAnitabiPoints(10))
                .thenReturn(List.of(noId, badGeo, nullGeo));

        spotService.findByAnimeId(10, true);

        verify(spotMapper, never()).insert(any(Spot.class));
    }

    @Test
    void findByAnimeId_upsertFallsBackToCnNameWhenNameMissing() {
        when(spotMapper.selectList(any(QueryWrapper.class)))
                .thenReturn(new ArrayList<>())
                .thenReturn(new ArrayList<>());

        Anime anime = new Anime();
        anime.setPointsCount(0);
        anime.setAnitabiModified(100L);
        when(animeMapper.selectById(10)).thenReturn(null);
        when(animeService.syncByBangumiId(10, true)).thenReturn(anime);

        AnitabiPoint point = new AnitabiPoint();
        point.setId("p1");
        point.setCn("中文名");
        point.setGeo(List.of(35.0, 139.0));
        when(externalClient.fetchAnitabiPoints(10)).thenReturn(List.of(point));
        when(spotMapper.selectByAnitabiPointId("p1")).thenReturn(null);

        spotService.findByAnimeId(10, true);

        ArgumentCaptor<Spot> captor = ArgumentCaptor.forClass(Spot.class);
        verify(spotMapper).insert(captor.capture());
        assertEquals("中文名", captor.getValue().getName());
        assertEquals("中文名", captor.getValue().getNameCn());
    }

    @Test
    void findByAnimeId_upsertSkipsWhenBothNamesMissing() {
        when(spotMapper.selectList(any(QueryWrapper.class)))
                .thenReturn(new ArrayList<>())
                .thenReturn(new ArrayList<>());

        Anime anime = new Anime();
        anime.setAnitabiModified(100L);
        when(animeMapper.selectById(10)).thenReturn(null);
        when(animeService.syncByBangumiId(10, true)).thenReturn(anime);

        AnitabiPoint point = new AnitabiPoint();
        point.setId("p1");
        point.setGeo(List.of(35.0, 139.0));
        when(externalClient.fetchAnitabiPoints(10)).thenReturn(List.of(point));
        when(spotMapper.selectByAnitabiPointId("p1")).thenReturn(null);

        spotService.findByAnimeId(10, true);

        verify(spotMapper, never()).insert(any(Spot.class));
    }

    @Test
    void findByAnimeId_upsertUpdatesExistingRow() {
        when(spotMapper.selectList(any(QueryWrapper.class)))
                .thenReturn(new ArrayList<>())
                .thenReturn(new ArrayList<>());

        Anime anime = new Anime();
        anime.setAnitabiModified(100L);
        when(animeMapper.selectById(10)).thenReturn(null);
        when(animeService.syncByBangumiId(10, true)).thenReturn(anime);

        AnitabiPoint point = point("p1", "name", 35.0, 139.0);
        Spot existing = spot(1L, 10);
        when(externalClient.fetchAnitabiPoints(10)).thenReturn(List.of(point));
        when(spotMapper.selectByAnitabiPointId("p1")).thenReturn(existing);

        spotService.findByAnimeId(10, true);

        verify(spotMapper).updateById(existing);
        verify(spotMapper, never()).insert(any(Spot.class));
    }

    @Test
    void findByAnimeId_singleArgOverloadDelegatesNonForce() {
        when(spotMapper.selectList(any(QueryWrapper.class))).thenReturn(List.of(spot(1, 10)));

        Anime before = new Anime();
        before.setPointsCount(1);
        before.setAnitabiModified(100L);

        Anime after = new Anime();
        after.setPointsCount(1);
        after.setAnitabiModified(100L);

        when(animeMapper.selectById(10)).thenReturn(before);
        when(animeService.syncByBangumiId(10, false)).thenReturn(after);

        spotService.findByAnimeId(10);

        verify(externalClient, never()).fetchAnitabiPoints(anyInt());
    }
}
