package com.misaka.demo.config;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Data
@Component
public class SmsProperties {

    @Value("${aliyun.sms.access-key-id:}")
    private String accessKeyId;

    @Value("${aliyun.sms.access-key-secret:}")
    private String accessKeySecret;

    @Value("${aliyun.sms.endpoint:dypnsapi.aliyuncs.com}")
    private String endpoint;

    @Value("${aliyun.sms.region-id:cn-hangzhou}")
    private String regionId;

    @Value("${aliyun.sms.sign-name:速通互联验证码}")
    private String signName;

    @Value("${aliyun.sms.template-code:100001}")
    private String templateCode;
}
