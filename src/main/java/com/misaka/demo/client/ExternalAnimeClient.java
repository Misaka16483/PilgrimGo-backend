package com.misaka.demo.client;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.List;

/**
 * 整合 Bangumi 搜索 + Anitabi 巡礼详情的外部数据客户端。
 * 流程：按作品名在 Bangumi 搜 subjectID，再用 subjectID 拉 Anitabi 的 lite 信息。
 */
@Component
public class ExternalAnimeClient {

    private static final Logger log = LoggerFactory.getLogger(ExternalAnimeClient.class);
    private static final String USER_AGENT = "PilgrimGo/1.0 (contact@pilgrimgo.com)";

    @Autowired
    private RestTemplate restTemplate;

    /** Bangumi 搜索返回 top N；仅保留常用字段。 */
    public List<BangumiSearchItem> searchBangumi(String keyword, int max) {
        if (keyword == null || keyword.isBlank()) return Collections.emptyList();
        String url = UriComponentsBuilder.fromHttpUrl("https://api.bgm.tv/search/subject/" + keyword)
                .queryParam("type", 2)
                .queryParam("responseGroup", "small")
                .queryParam("max_results", max)
                .encode(StandardCharsets.UTF_8)
                .toUriString();
        try {
            ResponseEntity<BangumiSearchResp> resp = restTemplate.exchange(
                    url, HttpMethod.GET, new HttpEntity<>(headers()), BangumiSearchResp.class);
            BangumiSearchResp body = resp.getBody();
            if (body == null || body.getList() == null) return Collections.emptyList();
            return body.getList();
        } catch (Exception e) {
            log.warn("Bangumi search failed for '{}': {}", keyword, e.getMessage());
            return Collections.emptyList();
        }
    }

    /** 拉 Anitabi 的轻量巡礼信息；无巡礼数据会 404，这里吞掉返回 null。 */
    public AnitabiLite fetchAnitabiLite(int subjectId) {
        String url = "https://api.anitabi.cn/bangumi/" + subjectId + "/lite";
        try {
            ResponseEntity<AnitabiLite> resp = restTemplate.exchange(
                    url, HttpMethod.GET, new HttpEntity<>(headers()), AnitabiLite.class);
            return resp.getBody();
        } catch (Exception e) {
            log.debug("Anitabi lite miss for {}: {}", subjectId, e.getMessage());
            return null;
        }
    }

    private HttpHeaders headers() {
        HttpHeaders h = new HttpHeaders();
        h.set(HttpHeaders.USER_AGENT, USER_AGENT);
        h.set(HttpHeaders.ACCEPT, "application/json");
        return h;
    }

    // ---------- DTO ----------

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class BangumiSearchResp {
        private Integer results;
        private List<BangumiSearchItem> list;
    }

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class BangumiSearchItem {
        private Integer id;
        private String name;
        @JsonProperty("name_cn") private String nameCn;
        @JsonProperty("air_date") private String airDate;
        private Images images;

        @Data
        @JsonIgnoreProperties(ignoreUnknown = true)
        public static class Images {
            private String large;
            private String common;
            private String medium;
            private String small;
        }
    }

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class AnitabiLite {
        private Integer id;
        private String cn;
        private String title;
        private String city;
        private String cover;
        private String color;
        private List<Double> geo;
        private Double zoom;
        private Long modified;
        private Integer pointsLength;
        private Integer imagesLength;
    }
}
