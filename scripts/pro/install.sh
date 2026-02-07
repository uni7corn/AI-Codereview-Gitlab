#!/usr/bin/env bash
set -e

# 1. 检查 docker
if ! command -v docker >/dev/null 2>&1; then
  echo "❌ Docker 未安装，请先安装 Docker"
  exit 1
fi

# 2. 检查 docker compose
if ! docker compose version >/dev/null 2>&1; then
  echo "❌ Docker Compose v2 未安装"
  exit 1
fi

# 3. 创建目录
BASE_DIR=/opt/codereview
mkdir -p $BASE_DIR
cd $BASE_DIR

# 4. 启动
docker compose -f https://raw.githubusercontent.com/sunmh207/AI-Codereview-Gitlab/refs/heads/main/scripts/pro/docker-compose.yml up -d

echo "✅ 启动成功"
echo "👉 访问地址: http://localhost:81"
echo "👉 默认账号: admin / admin"