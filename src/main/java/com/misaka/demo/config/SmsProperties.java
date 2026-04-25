package com.misaka.demo.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Data
@Component
@ConfigurationProperties(prefix = "aliyun.sms")
public class SmsProperties {
    private String accessKeyId;
    private String accessKeySecret;
    private String endpoint = "cloudauth.aliyuncs.com";
    private String regionId = "cn-hangzhou";
    private String signName = "速通互联验证码";
    private String templateCode = "100001";
}