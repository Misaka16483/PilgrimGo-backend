package com.misaka.demo.client;

import com.fasterxml.jackson.annotation.JsonAlias;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Data;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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

    @Autowired
    private ObjectMapper objectMapper;

    /**
     * 走 Bangumi v0 搜索：POST + JSON body，关键字放 body 里，CJK 无需任何 URL 编码处理。
     * 旧接口 /search/subject/{keyword} 在 URL 里塞中文容易踩 UriComponentsBuilder 的编码坑。
     */
    public List<BangumiSearchItem> searchBangumi(String keyword, int max) {
        if (keyword == null || keyword.isBlank()) return Collections.emptyList();
        String url = "https://api.bgm.tv/v0/search/subjects?limit=" + max + "&offset=0";
        HttpHeaders h = headers();
        h.setContentType(MediaType.APPLICATION_JSON);
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("keyword", keyword);
        body.put("filter", Map.of("type", List.of(2)));
        try {
            ResponseEntity<BangumiV0SearchResp> resp = restTemplate.exchange(
                    url, HttpMethod.POST, new HttpEntity<>(body, h), BangumiV0SearchResp.class);
            BangumiV0SearchResp data = resp.getBody();
            if (data == null || data.getData() == null) return Collections.emptyList();
            return data.getData().stream()
                    .map(BangumiV0Subject::toLegacyItem)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            log.warn("Bangumi v0 search failed for '{}': {}", keyword, e.getMessage());
            return Collections.emptyList();
        }
    }

    /**
     * 拉 Anitabi 的完整地标列表（含 origin/originURL）。无巡礼数据返回空列表。
     * 仅返回有图地标，避免拉来一堆纯坐标点污染地图。
     */
    public List<AnitabiPoint> fetchAnitabiPoints(int subjectId) {
        String url = "https://api.anitabi.cn/bangumi/" + subjectId + "/points/detail?haveImage=true";
        try {
            ResponseEntity<String> resp = restTemplate.exchange(
                    url, HttpMethod.GET, new HttpEntity<>(headers()), String.class);
            String body = resp.getBody();
            if (body == null || body.isBlank()) {
                return Collections.emptyList();
            }

            JsonNode root = objectMapper.readTree(body);
            if (!root.isArray()) {
                log.warn("Anitabi points payload for {} is not an array", subjectId);
                return Collections.emptyList();
            }

            List<AnitabiPoint> points = new ArrayList<>();
            int skipped = 0;
            for (JsonNode node : root) {
                try {
                    points.add(objectMapper.convertValue(node, new TypeReference<AnitabiPoint>() {}));
                } catch (IllegalArgumentException ex) {
                    skipped++;
                    log.warn("Skip malformed Anitabi point for {}: {}", subjectId, ex.getMessage());
                }
            }

            log.info("Anitabi points fetched for {}: {} entries, skipped {}", subjectId, points.size(), skipped);
            return points;
        } catch (Exception e) {
            log.warn("Anitabi points fetch failed for {}: {}", subjectId, e.toString(), e);
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
    public static class BangumiV0SearchResp {
        private Integer total;
        private List<BangumiV0Subject> data;
    }

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class BangumiV0Subject {
        private Integer id;
        private String name;
        @JsonProperty("name_cn") private String nameCn;
        private String date;
        private String image;
        private BangumiSearchItem.Images images;

        public BangumiSearchItem toLegacyItem() {
            BangumiSearchItem s = new BangumiSearchItem();
            s.setId(id);
            s.setName(name);
            s.setNameCn(nameCn);
            s.setAirDate(date);
            s.setImages(images);
            return s;
        }
    }

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class AnitabiPoint {
        private String id;
        private String cn;
        private String name;
        private String image;
        private Integer ep;
        private Integer s;          // 截图对应秒数
        private List<Double> geo;
        private String origin;
        @JsonAlias("originUrl")
        private String originURL;
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
