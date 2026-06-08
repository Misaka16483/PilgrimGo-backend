package com.misaka.demo.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Data
@Configuration
@ConfigurationProperties(prefix = "oss")
public class OssProperties {
    private String accessKeyId;
    private String accessKeySecret;
    private String roleArn;
    private String roleSessionName;
    private String bucket;
    private String region;
    private String endpoint;
    private String stsEndpoint;
    private String pathPrefix;
    private long durationSeconds = 3600;
}
