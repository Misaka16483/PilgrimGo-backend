package com.misaka.demo.dto;

import lombok.Data;

@Data
public class PresignRequest {
    /** 文件后缀名，例如 jpg / png / webp。不带点。 */
    private String ext;
    /** 文件 MIME 类型，例如 image/jpeg；用于签到 Content-Type 头。 */
    private String contentType;
}
