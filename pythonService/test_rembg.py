import sys
from pathlib import Path

from PIL import Image
from rembg import new_session, remove

MODELS = ["u2net", "birefnet-general"]


def remove_background(input_path: str, output_path: str | None = None, model: str = "birefnet-general") -> str:
    """使用指定模型去除图片背景，输出带透明通道的 PNG。"""
    input_file = Path(input_path)
    if not input_file.exists():
        print(f"错误：找不到输入文件 {input_path}")
        sys.exit(1)

    if model not in MODELS:
        print(f"错误：不支持的模型 {model}，可选：{', '.join(MODELS)}")
        sys.exit(1)

    if output_path is None:
        output_path = str(input_file.with_stem(input_file.stem + f"_nobg_{model}").with_suffix(".png"))

    print(f"输入图片：{input_path}")
    print(f"输出图片：{output_path}")
    print(f"使用模型：{model}")
    print("正在去除背景...")

    session = new_session(model)
    input_image = Image.open(input_path)
    output_image = remove(input_image, session=session)
    output_image.save(output_path)

    print("完成！")
    return output_path


def composite(foreground_path: str, background_path: str, output_path: str | None = None) -> str:
    """将去背景后的前景图（RGBA）叠加到同尺寸背景图上，利用前景的 alpha 通道做混合。"""
    fg = Image.open(foreground_path)
    bg = Image.open(background_path)

    if fg.size != bg.size:
        print(f"错误：两张图片尺寸不一致（前景 {fg.size}，背景 {bg.size}）")
        sys.exit(1)

    if fg.mode != "RGBA":
        print(f"错误：前景图片没有透明通道，请先用去背景功能处理")
        sys.exit(1)

    result = bg.convert("RGBA")
    result.paste(fg, mask=fg.split()[3])

    if output_path is None:
        fg_file = Path(foreground_path)
        output_path = str(fg_file.with_stem(fg_file.stem + "_composited").with_suffix(".png"))

    result.save(output_path)
    print(f"合成完成：{output_path}")
    return output_path


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("用法：")
        print("  去除背景：python test_rembg.py remove <输入图片> [输出图片] [模型名]")
        print("  贴图合成：python test_rembg.py composite <前景图片> <背景图片> [输出图片]")
        print(f"可用模型：{', '.join(MODELS)}（默认：birefnet-general）")
        print("示例：")
        print("  python test_rembg.py remove photo.jpg")
        print("  python test_rembg.py composite photo_nobg.png background.jpg result.png")
        sys.exit(1)

    command = sys.argv[1]

    if command == "remove":
        if len(sys.argv) < 3:
            print("错误：请提供输入图片路径")
            sys.exit(1)
        input_path = sys.argv[2]
        output_path = sys.argv[3] if len(sys.argv) > 3 else None
        model = sys.argv[4] if len(sys.argv) > 4 else "birefnet-general"
        remove_background(input_path, output_path, model)

    elif command == "composite":
        if len(sys.argv) < 4:
            print("错误：请提供前景图片和背景图片路径")
            sys.exit(1)
        foreground_path = sys.argv[2]
        background_path = sys.argv[3]
        output_path = sys.argv[4] if len(sys.argv) > 4 else None
        composite(foreground_path, background_path, output_path)

    else:
        print(f"错误：未知命令 '{command}'，可用命令：remove、composite")
        sys.exit(1)
