"""
融合图 Python 微服务
提供 HTTP 接口，供 Spring Boot 调用，完成：
1. /health - 健康检查
2. /fusion  - 接收两张图片 URL，抠图后合成融合图，返回 base64 结果
"""
import io
import base64
import tempfile
import os
import sys
import urllib.request
from pathlib import Path

from flask import Flask, request, jsonify
from PIL import Image
from rembg import new_session, remove

app = Flask(__name__)

# 默认使用 birefnet-general 模型（效果最好）
MODEL_NAME = os.environ.get("REMBG_MODEL", "birefnet-general")
_session = None


def get_session():
    global _session
    if _session is None:
        print(f"加载模型 {MODEL_NAME}...", flush=True)
        _session = new_session(MODEL_NAME)
        print("模型加载完成", flush=True)
    return _session


def download_image(url: str) -> Image.Image:
    """从 URL 下载图片，返回 PIL Image。"""
    req = urllib.request.Request(url, headers={"User-Agent": "PilgrimGo/1.0"})
    with urllib.request.urlopen(req, timeout=30) as resp:
        data = resp.read()
    return Image.open(io.BytesIO(data))


def image_to_base64(img: Image.Image, fmt: str = "PNG") -> str:
    buf = io.BytesIO()
    img.save(buf, format=fmt)
    return base64.b64encode(buf.getvalue()).decode("utf-8")


@app.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "ok", "model": MODEL_NAME})


@app.route("/fusion", methods=["POST"])
def fusion():
    """
    请求体 JSON：
    {
        "animeUrl": "https://...动漫截图...",
        "realUrl":  "https://...实景照片..."
    }
    返回：
    {
        "fusionImage": "data:image/png;base64,..."
    }
    """
    body = request.get_json(force=True)
    anime_url = body.get("animeUrl")
    real_url = body.get("realUrl")

    if not anime_url or not real_url:
        return jsonify({"error": "animeUrl 和 realUrl 均为必填"}), 400

    try:
        # 1. 下载动漫图（要抠图的那张）
        anime_img = download_image(anime_url)

        # 2. 抠图：去除动漫背景，保留角色
        session = get_session()
        fg_img = remove(anime_img, session=session)  # RGBA

        # 3. 下载实景图（背景）
        real_img = download_image(real_url)

        # 4. 将实景图调整为与动漫图相同尺寸（保持比例裁剪）
        target_w, target_h = fg_img.size
        real_img = real_img.convert("RGBA")

        real_w, real_h = real_img.size
        scale = max(target_w / real_w, target_h / real_h)
        new_w = int(real_w * scale)
        new_h = int(real_h * scale)
        real_resized = real_img.resize((new_w, new_h), Image.LANCZOS)

        # 居中裁剪到目标尺寸
        left = (new_w - target_w) // 2
        top = (new_h - target_h) // 2
        bg_img = real_resized.crop((left, top, left + target_w, top + target_h))

        # 5. 合成：角色叠加到实景上
        result = bg_img.copy()
        result.paste(fg_img, mask=fg_img.split()[3])

        # 6. 转 base64 返回
        result_rgb = result.convert("RGB")  # 去掉 alpha，前端显示更方便
        b64 = image_to_base64(result_rgb, "JPEG")

        return jsonify({"fusionImage": f"data:image/jpeg;base64,{b64}"})

    except Exception as e:
        print(f"fusion error: {e}", file=sys.stderr, flush=True)
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5001))
    print(f"启动融合图服务，端口 {port}", flush=True)
    # 预加载模型
    get_session()
    app.run(host="0.0.0.0", port=port, debug=False)
