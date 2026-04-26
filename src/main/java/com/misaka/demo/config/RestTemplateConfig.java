package com.misaka.demo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.web.client.RestTemplate;

@Configuration
public class RestTemplateConfig {

    @Bean
    public RestTemplate restTemplate() {
        SimpleClientHttpRequestFactory factory = new SimpleClientHttpRequestFactory();
        factory.setConnectTimeout(5000);
        // Anitabi 大作品 /points/detail 可能返回数百条，拉数据 + JSON 反序列化耗时偏高
        factory.setReadTimeout(20000);
        return new RestTemplate(factory);
    }
}
