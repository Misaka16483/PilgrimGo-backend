package com.misaka.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * 转折点图片直传所用的阿里云 STS 临时凭证。
 * 前端拿这套字段给 ali-oss 客户端直传到 bucket 下的 {pathPrefix}/{userId}/ 目录。
 */
@Data
@AllArgsConstructor
public class StsCredentialsVO {
    private String accessKeyId;
    private String accessKeySecret;
    private String securityToken;
    /** ISO8601 格式过期时间，例如 2026-05-10T12:34:56Z */
    private String expiration;
    private String bucket;
    private String region;
    private String endpoint;
    /** 当前用户被允许写入的 key 前缀，例如 waypoints/42/ */
    private String pathPrefix;
}
