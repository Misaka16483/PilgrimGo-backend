#!/usr/bin/env bash
#
# build.sh — 编译 Xunli 后端，将产物收集到 output/ 目录
#
# 用法:
#   ./build.sh             # 跳过测试打包(默认，避免连接共享远程库)
#   ./build.sh --with-tests # 连带运行 ./mvnw test
#
set -euo pipefail

# 切到脚本所在目录，保证相对路径稳定
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

OUTPUT_DIR="$SCRIPT_DIR/output"
RUN_TESTS=false
for arg in "$@"; do
  case "$arg" in
    --with-tests) RUN_TESTS=true ;;
    *) echo "未知参数: $arg" >&2; exit 2 ;;
  esac
done

echo "==> 清理 output/ (保留已有 python venv，避免重复下载依赖)"
KEEP_VENV=""
if [ -d "$OUTPUT_DIR/pythonService/.venv" ]; then
  KEEP_VENV="$(mktemp -d)"
  mv "$OUTPUT_DIR/pythonService/.venv" "$KEEP_VENV/.venv"
fi
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

echo "==> Maven 打包"
if [ "$RUN_TESTS" = true ]; then
  ./mvnw clean package
else
  ./mvnw clean package -DskipTests
fi

# 收集可执行 jar（排除 *.original / *-sources 等）
echo "==> 收集 jar 产物"
JAR_PATH="$(find target -maxdepth 1 -name '*.jar' ! -name '*.original' ! -name '*-sources.jar' | head -n 1)"
if [ -z "$JAR_PATH" ]; then
  echo "未找到可执行 jar，构建失败" >&2
  exit 1
fi
cp "$JAR_PATH" "$OUTPUT_DIR/app.jar"

# 一并打包 Python 抠图/融合服务（后端运行期依赖的旁路服务）
if [ -d pythonService ]; then
  echo "==> 收集 pythonService/"
  cp -R pythonService "$OUTPUT_DIR/pythonService"
  # 恢复上次构建保留下来的 venv
  if [ -n "$KEEP_VENV" ] && [ -d "$KEEP_VENV/.venv" ]; then
    rm -rf "$OUTPUT_DIR/pythonService/.venv"
    mv "$KEEP_VENV/.venv" "$OUTPUT_DIR/pythonService/.venv"
    rmdir "$KEEP_VENV" 2>/dev/null || true
    echo "    已沿用既有虚拟环境 pythonService/.venv"
  fi
  # 依赖清单：供 start.sh 缺 .venv 时自动安装（源里已有则不覆盖）
  if [ ! -f "$OUTPUT_DIR/pythonService/requirements.txt" ]; then
    cat > "$OUTPUT_DIR/pythonService/requirements.txt" <<'REQ_EOF'
flask
pillow
rembg[cpu]
REQ_EOF
  fi
fi

# 附带最新数据库 SQL，便于部署初始化。
# 优先使用仓库根目录的最新完整 dump；输出中同时保留固定文件名，兼容旧部署脚本。
echo "==> 收集数据库 SQL"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SQL_FILE=""
for group in latest dump root_schema local_schema; do
  case "$group" in
    latest) patterns=("$ROOT_DIR"/BJTU2026_latest_*.sql) ;;
    dump) patterns=("$ROOT_DIR"/BJTU2026_dump_*.sql) ;;
    root_schema) patterns=("$ROOT_DIR"/BJTU2026_schema.sql) ;;
    local_schema) patterns=("$SCRIPT_DIR"/BJTU2026_schema.sql) ;;
  esac
  for pattern in "${patterns[@]}"; do
    [ -e "$pattern" ] || continue
    if [ -z "$SQL_FILE" ] || [ "$pattern" -nt "$SQL_FILE" ]; then
      SQL_FILE="$pattern"
    fi
  done
  [ -n "$SQL_FILE" ] && break
done
if [ -n "$SQL_FILE" ]; then
  cp "$SQL_FILE" "$OUTPUT_DIR/BJTU2026_schema.sql"
  cp "$SQL_FILE" "$OUTPUT_DIR/$(basename "$SQL_FILE")"
  echo "    使用 $(basename "$SQL_FILE")"
else
  echo "    未找到 BJTU2026*.sql，跳过"
fi

# 生成一键启动脚本：同时拉起 Java 后端与 Python 融合服务
echo "==> 生成 output/start.sh 启动脚本"
cat > "$OUTPUT_DIR/start.sh" <<'START_EOF'
#!/usr/bin/env bash
#
# start.sh — 由 build.sh 自动生成
# 同时启动 Java 后端(:8080) 与 Python 融合服务(:5001)，Ctrl-C 一并停止。
#
# 可用环境变量:
#   PY_PORT    Python 服务端口 (默认 5001)
#   JAVA_OPTS  追加给 java 的参数 (如 -Dserver.port=9090)
#
set -uo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"
mkdir -p logs

PY_PORT="${PY_PORT:-5001}"
JAVA_OPTS="${JAVA_OPTS:-}"
PY_PID=""
JAVA_PID=""
CLEANED=0

# 向进程及其子进程发信号（python 可能因 onnx 加载阻塞而无子进程，仍兜底）
kill_tree() {
  pid="$1"; sig="$2"
  [ -n "$pid" ] || return 0
  pkill "-$sig" -P "$pid" 2>/dev/null || true
  kill "-$sig" "$pid" 2>/dev/null || true
}

alive() { [ -n "$1" ] && kill -0 "$1" 2>/dev/null; }

cleanup() {
  [ "$CLEANED" = 1 ] && return
  CLEANED=1
  trap '' INT TERM            # 清理期间忽略再次 Ctrl-C
  echo ""
  echo "==> 正在停止服务..."
  kill_tree "$JAVA_PID" TERM
  kill_tree "$PY_PID" TERM
  # 最多等 5s 优雅退出
  for _ in 1 2 3 4 5; do
    alive "$JAVA_PID" || alive "$PY_PID" || break
    sleep 1
  done
  # 仍存活则强杀（SIGKILL 不可被忽略，确保 python 一定退出）
  alive "$JAVA_PID" && { echo "    Java 未响应，强制结束"; kill_tree "$JAVA_PID" KILL; }
  alive "$PY_PID"   && { echo "    Python 未响应，强制结束"; kill_tree "$PY_PID" KILL; }
  wait 2>/dev/null || true
  echo "已停止。"
}
trap cleanup INT TERM EXIT

# 启动 Python 融合服务（存在才启动）
PYDIR="$DIR/pythonService"
VENV="$PYDIR/.venv"
if [ -f "$PYDIR/fusion_service.py" ]; then
  # 缺虚拟环境则自动创建并安装依赖（首次较慢）
  if [ ! -x "$VENV/bin/python" ]; then
    BOOT_PY="$(command -v python3 || command -v python || true)"
    if [ -z "$BOOT_PY" ]; then
      echo "==> 未找到 python3，无法创建虚拟环境，跳过融合服务" >&2
    else
      echo "==> 首次运行：创建虚拟环境并安装依赖（较慢，日志 logs/python-setup.log）"
      "$BOOT_PY" -m venv "$VENV"
      if [ -x "$VENV/bin/python" ]; then
        "$VENV/bin/python" -m pip install --upgrade pip >>"$DIR/logs/python-setup.log" 2>&1
        if [ -f "$PYDIR/requirements.txt" ]; then
          "$VENV/bin/python" -m pip install -r "$PYDIR/requirements.txt" >>"$DIR/logs/python-setup.log" 2>&1 \
            || echo "    依赖安装出错，详见 logs/python-setup.log" >&2
        else
          "$VENV/bin/python" -m pip install flask pillow "rembg[cpu]" >>"$DIR/logs/python-setup.log" 2>&1 \
            || echo "    依赖安装出错，详见 logs/python-setup.log" >&2
        fi
      else
        echo "    创建虚拟环境失败，跳过融合服务" >&2
        rm -rf "$VENV"
      fi
    fi
  fi

  # 选解释器：优先 venv，其次系统 python
  if [ -x "$VENV/bin/python" ]; then
    PY="$VENV/bin/python"
  elif command -v python3 >/dev/null 2>&1; then
    PY="python3"
  else
    PY="python"
  fi
  echo "==> 启动 Python 融合服务 (port $PY_PORT) — 日志 logs/python.log"
  ( cd "$PYDIR" && PORT="$PY_PORT" exec "$PY" fusion_service.py ) >"$DIR/logs/python.log" 2>&1 &
  PY_PID=$!
  echo "    python PID=$PY_PID  ($PY)"
else
  echo "==> 未找到 pythonService，跳过融合服务"
fi

# 启动 Java 后端
echo "==> 启动 Java 后端 (port 8080) — 日志 logs/backend.log"
# shellcheck disable=SC2086
java $JAVA_OPTS -jar "$DIR/app.jar" >"$DIR/logs/backend.log" 2>&1 &
JAVA_PID=$!
echo "    java PID=$JAVA_PID"

echo ""
echo "服务已启动。实时日志: tail -f logs/*.log   停止: Ctrl-C"

# 监控：任一进程退出即触发整体清理 (兼容 bash 3.2，不用 wait -n)
while :; do
  if [ -n "$JAVA_PID" ] && ! kill -0 "$JAVA_PID" 2>/dev/null; then
    echo "==> Java 后端已退出"; break
  fi
  if [ -n "$PY_PID" ] && ! kill -0 "$PY_PID" 2>/dev/null; then
    echo "==> Python 服务已退出"; break
  fi
  sleep 2
done
START_EOF
chmod +x "$OUTPUT_DIR/start.sh"

echo ""
echo "==> 构建完成，产物位于 $OUTPUT_DIR :"
ls -lh "$OUTPUT_DIR"
echo ""
echo "一键启动: ./output/start.sh   (仅 Java: java -jar output/app.jar)"
