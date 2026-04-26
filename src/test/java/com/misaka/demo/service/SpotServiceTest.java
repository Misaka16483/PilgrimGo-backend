package com.misaka.demo.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
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

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class SpotServiceTest {

    @Mock private SpotMapper spotMapper;
    @Mock private AnimeMapper animeMapper;
    @Mock private AnimeService animeService;
    @Mock private ExternalAnimeClient externalClient;

    @InjectMocks private SpotService spotService;

    private static AnitabiPoint point(String id, String name, double lat, double lng) {
        AnitabiPoint p = new AnitabiPoint();
        p.setId(id);
        p.setName(name);
        p.setGeo(List.of(lat, lng));
        return p;
    }

    private static Spot spot(long id, int animeId) {
        Spot s = new Spot();
        s.setId(id);
        s.setAnimeId(animeId);
        return s;
    }

    @Test
    void findNearby_buildsBoundingBoxAndDelegatesToMapper() {
        spotService.findNearby(35.0, 139.0, 1000, 50);

        ArgumentCaptor<BigDecimal> latMin = ArgumentCaptor.forClass(BigDecimal.class);
        ArgumentCaptor<BigDecimal> latMax = ArgumentCaptor.forClass(BigDecimal.class);
        ArgumentCaptor<BigDecimal> lngMin = ArgumentCaptor.forClass(BigDecimal.class);
        ArgumentCaptor<BigDecimal> lngMax = ArgumentCaptor.forClass(BigDecimal.class);

        verify(spotMapper).selectNearby(
                any(BigDecimal.class), any(BigDecimal.class),
                latMin.capture(), latMax.capture(),
                lngMin.capture(), lngMax.capture(),
                eq(50));

        // sanity: bounding box brackets the centre
        assertTrue(latMin.getValue().compareTo(latMax.getValue()) < 0);
        assertTrue(lngMin.getValue().compareTo(lngMax.getValue()) < 0);
        assertTrue(latMin.getValue().doubleValue() < 35.0);
        assertTrue(latMax.getValue().doubleValue() > 35.0);
    }

    @Test
    void findNearby_handlesPolarLatitudeWithoutBlowingUp() {
        // near pole, cos(lat) ≈ 0 — service guards with MIN_COS_LAT
        spotService.findNearby(89.999, 0.0, 5000, 10);

        verify(spotMapper).selectNearby(
                any(), any(), any(), any(), any(), any(), eq(10));
    }

    @Test
    void findById_delegatesToMapper() {
        Spot s = spot(7L, 1);
        when(spotMapper.selectById(7L)).thenReturn(s);
        assertSame(s, spotService.findById(7L));
    }

    @Test
    void findAnime_delegatesToMapper() {
        Anime a = new Anime();
        when(animeMapper.selectById(99)).thenReturn(a);
        assertSame(a, spotService.findAnime(99));
    }

    @Test
    void findByAnimeId_returnsLocalWhenCountSatisfiesExpected() {
        List<Spot> local = List.of(spot(1, 10), spot(2, 10), spot(3, 10));
        when(spotMapper.selectList(any(QueryWrapper.class))).thenReturn(local);

        Anime a = new Anime();
        a.setBangumiId(10);
        a.setPointsCount(3);
        when(animeService.findById(10)).thenReturn(a);

        List<Spot> result = spotService.findByAnimeId(10, false);

        assertSame(local, result);
        verify(externalClient, never()).fetchAnitabiPoints(anyInt());
    }

    @Test
    void findByAnimeId_returnsLocalWhenAnimeMetadataAbsent() {
        // anime not in our DB and Anitabi also missed → cannot sync, return local as-is
        when(spotMapper.selectList(any(QueryWrapper.class))).thenReturn(List.of());
        when(animeService.findById(404)).thenReturn(null);

        List<Spot> result = spotService.findByAnimeId(404, false);

        assertTrue(result.isEmpty());
        verify(externalClient, never()).fetchAnitabiPoints(anyInt());
    }

    @Test
    void findByAnimeId_syncsWhenLocalEmpty() {
        // first selectList: local empty; second: after upsert
        Spot synced = spot(11L, 10);
        when(spotMapper.selectList(any(QueryWrapper.class)))
                .thenReturn(new ArrayList<>())
                .thenReturn(List.of(synced));

        Anime a = new Anime();
        a.setBangumiId(10);
        a.setPointsCount(1);
        when(animeService.findById(10)).thenReturn(a);

        AnitabiPoint p = point("p1", "聖地", 35.5, 139.5);
        when(externalClient.fetchAnitabiPoints(10)).thenReturn(List.of(p));
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

        Anime a = new Anime();
        a.setBangumiId(10);
        a.setPointsCount(3);
        when(animeService.findById(10)).thenReturn(a);
        when(externalClient.fetchAnitabiPoints(10)).thenReturn(List.of());

        spotService.findByAnimeId(10, true);

        verify(externalClient).fetchAnitabiPoints(10);
    }

    @Test
    void findByAnimeId_returnsLocalWhenExternalFetchEmpty() {
        List<Spot> local = List.of(spot(1, 10));
        when(spotMapper.selectList(any(QueryWrapper.class))).thenReturn(local);

        Anime a = new Anime();
        a.setPointsCount(5); // expecting more than local
        when(animeService.findById(10)).thenReturn(a);
        when(externalClient.fetchAnitabiPoints(10)).thenReturn(List.of());

        List<Spot> result = spotService.findByAnimeId(10, false);

        assertSame(local, result);
        verify(spotMapper, never()).insert(any(Spot.class));
    }

    @Test
    void findByAnimeId_externalErrorFallsBackToLocal() {
        List<Spot> local = List.of(spot(1, 10));
        when(spotMapper.selectList(any(QueryWrapper.class))).thenReturn(local);

        Anime a = new Anime();
        a.setPointsCount(5);
        when(animeService.findById(10)).thenReturn(a);
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

        Anime a = new Anime();
        a.setPointsCount(0);
        when(animeService.findById(10)).thenReturn(a);

        AnitabiPoint noId = new AnitabiPoint();
        noId.setGeo(List.of(35.0, 139.0));
        AnitabiPoint badGeo = point("p1", "n", 0, 0);
        badGeo.setGeo(List.of(35.0)); // only one element
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

        Anime a = new Anime();
        a.setPointsCount(0);
        when(animeService.findById(10)).thenReturn(a);

        AnitabiPoint p = new AnitabiPoint();
        p.setId("p1");
        p.setCn("中文名");
        p.setGeo(List.of(35.0, 139.0));
        when(externalClient.fetchAnitabiPoints(10)).thenReturn(List.of(p));
        when(spotMapper.selectByAnitabiPointId("p1")).thenReturn(null);

        spotService.findByAnimeId(10, true);

        ArgumentCaptor<Spot> cap = ArgumentCaptor.forClass(Spot.class);
        verify(spotMapper).insert(cap.capture());
        assertEquals("中文名", cap.getValue().getName()); // CN fallback for NOT NULL name
        assertEquals("中文名", cap.getValue().getNameCn());
    }

    @Test
    void findByAnimeId_upsertSkipsWhenBothNamesMissing() {
        when(spotMapper.selectList(any(QueryWrapper.class)))
                .thenReturn(new ArrayList<>())
                .thenReturn(new ArrayList<>());
        when(animeService.findById(10)).thenReturn(new Anime());

        AnitabiPoint p = new AnitabiPoint();
        p.setId("p1");
        p.setGeo(List.of(35.0, 139.0));
        when(externalClient.fetchAnitabiPoints(10)).thenReturn(List.of(p));
        when(spotMapper.selectByAnitabiPointId("p1")).thenReturn(null);

        spotService.findByAnimeId(10, true);

        verify(spotMapper, never()).insert(any(Spot.class));
    }

    @Test
    void findByAnimeId_upsertUpdatesExistingRow() {
        when(spotMapper.selectList(any(QueryWrapper.class)))
                .thenReturn(new ArrayList<>())
                .thenReturn(new ArrayList<>());
        when(animeService.findById(10)).thenReturn(new Anime());

        AnitabiPoint p = point("p1", "name", 35.0, 139.0);
        Spot existing = spot(1L, 10);
        when(externalClient.fetchAnitabiPoints(10)).thenReturn(List.of(p));
        when(spotMapper.selectByAnitabiPointId("p1")).thenReturn(existing);

        spotService.findByAnimeId(10, true);

        verify(spotMapper).updateById(existing);
        verify(spotMapper, never()).insert(any(Spot.class));
    }

    @Test
    void findByAnimeId_singleArgOverloadDelegatesNonForce() {
        when(spotMapper.selectList(any(QueryWrapper.class))).thenReturn(List.of(spot(1, 10)));

        Anime a = new Anime();
        a.setPointsCount(1);
        when(animeService.findById(10)).thenReturn(a);

        spotService.findByAnimeId(10);

        verify(externalClient, never()).fetchAnitabiPoints(anyInt());
    }
}
