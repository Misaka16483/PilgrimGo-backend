package com.misaka.demo.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

@Service
public class FusionService {

    @Value("${fusion.python-service-url:http://localhost:5001}")
    private String pythonServiceUrl;

    // 单独的 RestTemplate，超时 120s，避免影响其他接口的 20s 配置
    private final RestTemplate restTemplate;

    public FusionService() {
        SimpleClientHttpRequestFactory factory = new SimpleClientHttpRequestFactory();
        factory.setConnectTimeout(5000);
        factory.setReadTimeout(120000);
        this.restTemplate = new RestTemplate(factory);
    }

    public String generateFusion(String animeUrl, String realUrl) {
        String url = pythonServiceUrl + "/fusion";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        Map<String, String> body = Map.of(
                "animeUrl", animeUrl,
                "realUrl", realUrl
        );

        HttpEntity<Map<String, String>> entity = new HttpEntity<>(body, headers);

        ResponseEntity<Map> response = restTemplate.postForEntity(url, entity, Map.class);

        if (response.getStatusCode() != HttpStatus.OK || response.getBody() == null) {
            throw new RuntimeException("Python 服务返回异常: " + response.getStatusCode());
        }

        Object result = response.getBody().get("fusionImage");
        if (result == null) {
            Object err = response.getBody().get("error");
            throw new RuntimeException("融合图生成失败: " + err);
        }
        return result.toString();
    }
}
