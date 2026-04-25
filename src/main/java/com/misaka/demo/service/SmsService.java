package com.misaka.demo.service;

import com.aliyun.auth.credentials.Credential;
import com.aliyun.auth.credentials.provider.StaticCredentialProvider;
import com.aliyun.sdk.service.dypnsapi20170525.AsyncClient;
import com.aliyun.sdk.service.dypnsapi20170525.models.*;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.misaka.demo.config.SmsProperties;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct;
import java.util.concurrent.CompletableFuture;

@Slf4j
@Service
public class SmsService {

    @Autowired
    private SmsProperties smsProperties;

    private AsyncClient client;
    private final Gson gson = new Gson();

    @PostConstruct
    public void init() {
        try {
            // 从配置文件读取凭证
            Credential credential = Credential.builder()
                    .accessKeyId(smsProperties.getAccessKeyId())
                    .accessKeySecret(smsProperties.getAccessKeySecret())
                    .build();

            // Configure Credentials authentication information
            StaticCredentialProvider provider = StaticCredentialProvider.create(credential);

            // Configure the Client
            client = AsyncClient.builder()
                    .region(smsProperties.getRegionId()) // Region ID from config
                    .credentialsProvider(provider)
                    .build();

            log.info("SMS Service initialized successfully with region: {}", smsProperties.getRegionId());
        } catch (Exception e) {
            log.error("Failed to initialize SMS Service", e);
            throw new RuntimeException("SMS Service initialization failed", e);
        }
    }

    /**
     * 发送短信验证码（默认 REGISTER 类型）
     *
     * @param phone 手机号
     * @return 发送结果
     */
    public SmsSendResult sendVerificationCode(String phone) {
        return sendVerificationCode(phone, "REGISTER");
    }

    /**
     * 发送短信验证码
     *
     * @param phone 手机号
     * @param type  验证码类型（REGISTER, LOGIN, RESET_PASSWORD）
     * @return 发送结果
     */
    public SmsSendResult sendVerificationCode(String phone, String type) {
        try {
            // Parameter settings for API request
            // 号码认证服务不需要签名和模板，使用系统默认的
            SendSmsVerifyCodeRequest.Builder requestBuilder = SendSmsVerifyCodeRequest.builder()
                    .phoneNumber(phone)
                    .codeLength(4L)
                    .validTime(300L)
                    .codeType(1L)
                    .duplicatePolicy(1L)
                    .interval(60L)
                    .returnVerifyCode(true);
            
            // 如果配置了签名和模板，则使用；否则使用系统默认
            if (smsProperties.getSignName() != null && !smsProperties.getSignName().isEmpty()) {
                requestBuilder.signName(smsProperties.getSignName());
            }
            if (smsProperties.getTemplateCode() != null && !smsProperties.getTemplateCode().isEmpty()) {
                requestBuilder.templateCode(smsProperties.getTemplateCode());
                requestBuilder.templateParam("{\"code\":\"##code##\",\"min\":\"5\"}");
            }
            
            SendSmsVerifyCodeRequest request = requestBuilder.build();

            // Asynchronously get the return value of the API request
            CompletableFuture<SendSmsVerifyCodeResponse> response = client.sendSmsVerifyCode(request);
            // Synchronously get the return value of the API request
            SendSmsVerifyCodeResponse resp = response.get();

            // 使用 Gson 转换为 JSON 查看结构
            String jsonResponse = gson.toJson(resp);
            log.info("SMS send response: {}", jsonResponse);

            SmsSendResult result = new SmsSendResult();
            
            // 解析 JSON 响应
            JsonObject jsonObject = JsonParser.parseString(jsonResponse).getAsJsonObject();
            
            // 响应结构是 {"body": {...}, "headers": {...}, "statusCode": 200}
            // 实际的响应内容在 body 中
            JsonObject body = jsonObject.has("body") ? jsonObject.getAsJsonObject("body") : jsonObject;
            
            // 获取 code 字段（可能是 Code 或 code）
            String code = null;
            if (body.has("code")) {
                code = body.get("code").getAsString();
            } else if (body.has("Code")) {
                code = body.get("Code").getAsString();
            }
            
            // 获取 success 字段或判断 code 是否为 OK
            boolean success = false;
            if (body.has("success")) {
                success = body.get("success").getAsBoolean();
            } else if ("OK".equals(code)) {
                success = true;
            }
            result.setSuccess(success);
            
            // 获取 requestId（从 headers 或 body）
            if (jsonObject.has("headers")) {
                JsonObject headers = jsonObject.getAsJsonObject("headers");
                if (headers.has("x-acs-request-id")) {
                    result.setRequestId(headers.get("x-acs-request-id").getAsString());
                }
            }
            
            // 获取 Model 中的字段
            if (body.has("Model") && !body.get("Model").isJsonNull()) {
                JsonObject model = body.getAsJsonObject("Model");
                if (model.has("VerifyCode")) {
                    result.setVerifyCode(model.get("VerifyCode").getAsString());
                }
                if (model.has("BizId")) {
                    result.setBizId(model.get("BizId").getAsString());
                }
            }
            
            // 如果失败，获取错误信息
            if (!result.isSuccess()) {
                result.setErrorCode(code);
                String errorMsg = null;
                if (body.has("message")) {
                    errorMsg = body.get("message").getAsString();
                } else if (body.has("Message")) {
                    errorMsg = body.get("Message").getAsString();
                }
                result.setErrorMessage(errorMsg);
                log.error("SMS send failed, code: {}, message: {}", code, errorMsg);
            }

            return result;
        } catch (Exception e) {
            log.error("Failed to send SMS to {}", phone, e);
            throw new RuntimeException("发送短信失败: " + e.getMessage(), e);
        }
    }

    /**
     * 验证短信验证码
     *
     * @param phone 手机号
     * @param code  验证码
     * @param type  类型
     * @return 验证结果
     */
    public boolean verifyCode(String phone, String code, String type) {
        try {
            // Parameter settings for API request
            CheckSmsVerifyCodeRequest request = CheckSmsVerifyCodeRequest.builder()
                    .phoneNumber(phone)
                    .verifyCode(code)
                    .caseAuthPolicy(1L)
                    .build();

            // Asynchronously get the return value of the API request
            CompletableFuture<CheckSmsVerifyCodeResponse> response = client.checkSmsVerifyCode(request);
            // Synchronously get the return value of the API request
            CheckSmsVerifyCodeResponse resp = response.get();

            // 使用 Gson 转换为 JSON 查看结构
            String jsonResponse = gson.toJson(resp);
            log.info("SMS verify response: {}", jsonResponse);

            // 解析 JSON 响应
            JsonObject jsonObject = JsonParser.parseString(jsonResponse).getAsJsonObject();
            
            // 核验结果以 Model.VerifyResult 为准
            if (jsonObject.has("Model") && !jsonObject.get("Model").isJsonNull()) {
                JsonObject model = jsonObject.getAsJsonObject("Model");
                if (model.has("VerifyResult")) {
                    return "PASS".equals(model.get("VerifyResult").getAsString());
                }
            }
            return false;
        } catch (Exception e) {
            log.error("Failed to verify SMS code for {}", phone, e);
            return false;
        }
    }

    /**
     * 验证短信验证码
     *
     * @param phone 手机号
     * @param code  验证码
     * @return 验证结果
     */
    public boolean verifyCode(String phone, String code) {
        return verifyCode(phone, code, "REGISTER");
    }

    /**
     * 短信发送结果
     */
    public static class SmsSendResult {
        private boolean success;
        private String requestId;
        private String verifyCode;
        private String bizId;
        private String errorCode;
        private String errorMessage;

        // Getters and Setters
        public boolean isSuccess() { return success; }
        public void setSuccess(boolean success) { this.success = success; }
        public String getRequestId() { return requestId; }
        public void setRequestId(String requestId) { this.requestId = requestId; }
        public String getVerifyCode() { return verifyCode; }
        public void setVerifyCode(String verifyCode) { this.verifyCode = verifyCode; }
        public String getBizId() { return bizId; }
        public void setBizId(String bizId) { this.bizId = bizId; }
        public String getErrorCode() { return errorCode; }
        public void setErrorCode(String errorCode) { this.errorCode = errorCode; }
        public String getErrorMessage() { return errorMessage; }
        public void setErrorMessage(String errorMessage) { this.errorMessage = errorMessage; }
    }
}