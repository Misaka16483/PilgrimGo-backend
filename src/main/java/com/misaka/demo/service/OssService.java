package com.misaka.demo.service;

import com.aliyun.oss.HttpMethod;
import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.model.GeneratePresignedUrlRequest;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;
import com.aliyuncs.sts.model.v20150401.AssumeRoleRequest;
import com.aliyuncs.sts.model.v20150401.AssumeRoleResponse;
import com.misaka.demo.config.OssProperties;
import com.misaka.demo.dto.PresignVO;
import com.misaka.demo.dto.StsCredentialsVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.net.URL;
import java.util.Date;
import java.util.UUID;

@Service
public class OssService {

    @Autowired
    private OssProperties props;

    /**
     * 为指定用户签发只能写入自己专属前缀的 STS 临时凭证。
     * Policy 限定到 {bucket}/{pathPrefix}/{userId}/* 的 PutObject 权限，
     * 防止越权覆盖他人图片。
     */
    public StsCredentialsVO issueWaypointUploadCredentials(Long userId) {
        String userPrefix = props.getPathPrefix() + "/" + userId + "/";
        String resource = "acs:oss:*:*:" + props.getBucket() + "/" + userPrefix + "*";
        String policy = "{\n" +
                "  \"Version\": \"1\",\n" +
                "  \"Statement\": [{\n" +
                "    \"Effect\": \"Allow\",\n" +
                "    \"Action\": [\"oss:PutObject\"],\n" +
                "    \"Resource\": [\"" + resource + "\"]\n" +
                "  }]\n" +
                "}";

        try {
            IClientProfile profile = DefaultProfile.getProfile(
                    props.getRegion(), props.getAccessKeyId(), props.getAccessKeySecret());
            DefaultProfile.addEndpoint("", props.getRegion(), "Sts", props.getStsEndpoint());
            IAcsClient client = new DefaultAcsClient(profile);

            AssumeRoleRequest req = new AssumeRoleRequest();
            req.setSysMethod(MethodType.POST);
            req.setRoleArn(props.getRoleArn());
            req.setRoleSessionName(props.getRoleSessionName() + "-" + userId);
            req.setPolicy(policy);
            req.setDurationSeconds(props.getDurationSeconds());

            AssumeRoleResponse resp = client.getAcsResponse(req);
            AssumeRoleResponse.Credentials c = resp.getCredentials();
            return new StsCredentialsVO(
                    c.getAccessKeyId(),
                    c.getAccessKeySecret(),
                    c.getSecurityToken(),
                    c.getExpiration(),
                    props.getBucket(),
                    props.getRegion(),
                    props.getEndpoint(),
                    userPrefix
            );
        } catch (ClientException e) {
            throw new RuntimeException("签发 OSS 临时凭证失败: " + e.getErrCode() + " " + e.getErrMsg(), e);
        }
    }

    /**
     * 为指定用户生成上传转折点图片用的预签名 PUT URL。
     * object key 由服务端决定，强制带 userId 前缀，避免越权覆盖；
     * 客户端必须用同样的 Content-Type 上传，否则 OSS 校验失败。
     */
    public PresignVO presignWaypointUpload(Long userId, String ext, String contentType) {
        String safeExt = sanitizeExt(ext);
        String safeContentType = (contentType == null || contentType.isBlank()) ? "image/jpeg" : contentType;
        String objectKey = props.getPathPrefix() + "/" + userId + "/" + UUID.randomUUID() + "." + safeExt;

        long expiresAt = System.currentTimeMillis() + props.getDurationSeconds() * 1000L;
        OSS client = new OSSClientBuilder().build(
                props.getEndpoint(), props.getAccessKeyId(), props.getAccessKeySecret());
        try {
            GeneratePresignedUrlRequest req = new GeneratePresignedUrlRequest(
                    props.getBucket(), objectKey, HttpMethod.PUT);
            req.setExpiration(new Date(expiresAt));
            req.setContentType(safeContentType);
            URL url = client.generatePresignedUrl(req);

            String publicUrl = props.getEndpoint().replaceFirst("^https?://",
                    "https://" + props.getBucket() + ".") + "/" + objectKey;

            return new PresignVO(url.toString(), publicUrl, safeContentType, objectKey, expiresAt);
        } finally {
            client.shutdown();
        }
    }

    private String sanitizeExt(String ext) {
        if (ext == null) return "jpg";
        String trimmed = ext.trim().toLowerCase().replaceFirst("^\\.", "");
        return switch (trimmed) {
            case "jpg", "jpeg", "png", "webp", "heic", "heif" -> trimmed;
            default -> "jpg";
        };
    }
}
