# Python 融合图微服务

AR 对比界面"融合图"功能的依赖服务。使用 BiRefNet 模型将动漫截图中的角色抠出，叠加到用户拍摄的实景照片上。

## 依赖安装

需要 Python 3.9+，建议在虚拟环境中安装：

```bash
pip install flask pillow
pip install "rembg[cpu]"   # CPU 环境（普通电脑）
# pip install "rembg[gpu]" # NVIDIA GPU 环境（可选，速度更快）
```

> 首次运行时 rembg 会自动下载 BiRefNet 模型权重，约 200MB，需等待。

## 启动服务

```bash
cd Xunli-backend/pythonService
python fusion_service.py
```

启动成功后监听 `http://localhost:5001`，可用以下命令验证：

```bash
curl http://localhost:5001/health
```

## 接口说明

### POST /fusion

接收两张图片的公开 URL，返回融合图 base64。

**请求体：**
```json
{
  "animeUrl": "https://...动漫截图URL...",
  "realUrl":  "https://...实景照片URL..."
}
```

**响应：**
```json
{
  "fusionImage": "data:image/jpeg;base64,..."
}
```

## 注意事项

- Spring Boot 后端需配置 `fusion.python-service-url=http://localhost:5001`（已在 `application.properties` 中配置）
- 图片处理耗时约 15-30 秒，Spring Boot 和前端的请求超时均已设置为 120 秒
- 生产环境建议将此服务部署到独立服务器并修改 `fusion.python-service-url` 指向对应地址
