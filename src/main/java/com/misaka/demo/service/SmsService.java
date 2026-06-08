package com.misaka.demo.service;

import com.aliyun.auth.credentials.Credential;
import com.aliyun.auth.credentials.provider.StaticCredentialProvider;
import com.aliyun.sdk.service.dypnsapi20170525.AsyncClient;
import com.aliyun.sdk.service.dypnsapi20170525.models.*;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializer;
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
    private final Gson gson = new GsonBuilder()
            .registerTypeAdapter(java.time.Duration.class,
                    (JsonSerializer<java.time.Duration>) (src, typeOfSrc, context) ->
                            new JsonPrimitive(src.toString()))
            .create();

    @PostConstruct
    public void init() {
        try {
            Credential credential = Credential.builder()
                    .accessKeyId(smsProperties.getAccessKeyId())
                    .accessKeySecret(smsProperties.getAccessKeySecret())
                    .build();

            StaticCredentialProvider provider = StaticCredentialProvider.create(credential);

            client = AsyncClient.builder()
                    .region(smsProperties.getRegionId())
                    .credentialsProvider(provider)
                    .build();

            log.info("SMS Service initialized (Dypnsapi SDK), region: {}", smsProperties.getRegionId());
        } catch (Exception e) {
            log.error("Failed to initialize SMS Service", e);
            throw new RuntimeException("SMS Service initialization failed", e);
        }
    }

    public SmsSendResult sendVerificationCode(String phone) {
        return sendVerificationCode(phone, "REGISTER");
    }

    public SmsSendResult sendVerificationCode(String phone, String type) {
        try {
            SendSmsVerifyCodeRequest.Builder builder = SendSmsVerifyCodeRequest.builder()
                    .phoneNumber(phone)
                    .codeLength(4L)
                    .validTime(300L)
                    .codeType(1L)
                    .duplicatePolicy(1L)
                    .interval(60L)
                    .returnVerifyCode(true)
                    .signName(smsProperties.getSignName())
                    .templateCode(smsProperties.getTemplateCode())
                    .templateParam("{\"code\":\"##code##\",\"min\":\"5\"}");

            SendSmsVerifyCodeRequest request = builder.build();
            // 打印 SDK 实际发出的请求参数
            log.info("SMS request params: signName={}, templateCode={}, templateParam={}",
                    request.getSignName(), request.getTemplateCode(), request.getTemplateParam());
            log.info("SMS request raw: {}", gson.toJson(request));
            CompletableFuture<SendSmsVerifyCodeResponse> response = client.sendSmsVerifyCode(request);
            SendSmsVerifyCodeResponse resp = response.get();

            String jsonResponse = gson.toJson(resp);
            log.info("SMS send response: {}", jsonResponse);

            JsonObject jsonObject = JsonParser.parseString(jsonResponse).getAsJsonObject();
            JsonObject body = jsonObject.has("body") ? jsonObject.getAsJsonObject("body") : jsonObject;

            String code = body.has("code") ? body.get("code").getAsString()
                    : body.has("Code") ? body.get("Code").getAsString() : null;

            boolean success = body.has("success") ? body.get("success").getAsBoolean()
                    : "OK".equals(code);

            SmsSendResult result = new SmsSendResult();
            result.setSuccess(success);
            result.setErrorCode(code);
            result.setErrorMessage(body.has("message") ? body.get("message").getAsString()
                    : body.has("Message") ? body.get("Message").getAsString() : null);

            if (body.has("Model") && !body.get("Model").isJsonNull()) {
                JsonObject model = body.getAsJsonObject("Model");
                if (model.has("VerifyCode")) result.setVerifyCode(model.get("VerifyCode").getAsString());
                if (model.has("BizId")) result.setBizId(model.get("BizId").getAsString());
            }

            return result;
        } catch (Exception e) {
            log.error("Failed to send SMS to {}", phone, e);
            throw new RuntimeException("发送短信失败: " + e.getMessage(), e);
        }
    }

    public boolean verifyCode(String phone, String code, String type) {
        try {
            CheckSmsVerifyCodeRequest request = CheckSmsVerifyCodeRequest.builder()
                    .phoneNumber(phone)
                    .verifyCode(code)
                    .caseAuthPolicy(1L)
                    .build();

            CompletableFuture<CheckSmsVerifyCodeResponse> response = client.checkSmsVerifyCode(request);
            CheckSmsVerifyCodeResponse resp = response.get();

            var body = resp.getBody();
            log.info("SMS verify response: code={}, message={}, success={}",
                    body.getCode(), body.getMessage(), body.getSuccess());

            // 优先判断 success 字段
            if (body.getSuccess() != null && body.getSuccess()) {
                return true;
            }

            // 阿里云返回 OK 也表示成功
            if ("OK".equals(body.getCode())) {
                return true;
            }

            return false;
        } catch (Exception e) {
            log.error("Failed to verify SMS code for {}", phone, e);
            return false;
        }
    }

    public boolean verifyCode(String phone, String code) {
        return verifyCode(phone, code, "REGISTER");
    }

    // --- inner class ---

    public static class SmsSendResult {
        private boolean success;
        private String requestId;
        private String verifyCode;
        private String bizId;
        private String errorCode;
        private String errorMessage;

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
