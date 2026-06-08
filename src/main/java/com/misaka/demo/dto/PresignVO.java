package com.misaka.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * 预签名 PUT URL 响应。
 * 前端用 PUT uploadUrl 上传二进制（必须带上 contentType 头），
 * 上传成功后图片实际可访问地址就是 publicUrl，写入 waypoint.photoUrl。
 */
@Data
@AllArgsConstructor
public class PresignVO {
    private String uploadUrl;
    private String publicUrl;
    /** 上传时必须使用的 Content-Type 头（与签名时使用的一致，否则 OSS 拒绝）。 */
    private String contentType;
    /** 服务端生成的 OSS object key，便于前端记录/调试 */
    private String objectKey;
    /** uploadUrl 过期时间戳（毫秒） */
    private long expiresAt;
}
