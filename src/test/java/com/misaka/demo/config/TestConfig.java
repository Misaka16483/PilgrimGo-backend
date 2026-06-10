package com.misaka.demo.config;

import com.misaka.demo.service.SmsService;
import org.mockito.ArgumentMatchers;
import org.mockito.Mockito;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;
import org.springframework.context.annotation.Profile;

/**
 * 测试配置类
 * 用于替换生产环境的Bean为Mock/测试版本
 */
@TestConfiguration
@Profile("test")
public class TestConfig {

    /**
     * Mock短信服务，避免真实发送短信
     */
    @Bean
    @Primary
    public SmsService smsService() {
        SmsService mockSmsService = Mockito.mock(SmsService.class);
        
        // 默认行为：发送验证码成功
        Mockito.when(mockSmsService.sendVerificationCode(Mockito.anyString(), Mockito.anyString()))
               .thenReturn(new SmsService.SmsSendResult());

        // 默认行为：验证验证码成功
        Mockito.when(mockSmsService.verifyCode(Mockito.anyString(), Mockito.anyString(), Mockito.anyString()))
               .thenReturn(true);

        // 特定验证码验证失败（覆盖上面的默认行为）
        Mockito.when(mockSmsService.verifyCode(Mockito.anyString(), Mockito.eq("0000"), Mockito.anyString()))
               .thenReturn(false);
        
        return mockSmsService;
    }
}
