#!/bin/bash
# OpenClaw 每日完整备份脚本
# 备份整个 ~/.openclaw 文件夹到 GitHub

set -e

OPENCLAW_DIR="$HOME/.openclaw"
BACKUP_DIR="$HOME/.openclaw-backup"
REPO_NAME="openclaw-config"
LOG_FILE="$BACKUP_DIR/backup.log"

echo "========================================" | tee -a "$LOG_FILE"
echo "🦞 OpenClaw 每日备份 - $(date '+%Y-%m-%d %H:%M:%S')" | tee -a "$LOG_FILE"
echo "========================================" | tee -a "$LOG_FILE"

# 确保备份目录存在
mkdir -p "$BACKUP_DIR"

# 使用 rsync 备份整个 .openclaw（排除敏感和临时文件）
echo "📁 备份 ~/.openclaw 所有文件..." | tee -a "$LOG_FILE"
rsync -av --delete \
    --exclude='.DS_Store' \
    --exclude='*.log' \
    --exclude='node_modules' \
    --exclude='.npm' \
    --exclude='.cache' \
    --exclude='tmp' \
    --exclude='temp' \
    --exclude='**/.git' \
    --exclude='devices' \
    --exclude='browser' \
    "$OPENCLAW_DIR/" "$BACKUP_DIR/openclaw/"

# 记录备份文件数量
FILE_COUNT=$(find "$BACKUP_DIR/openclaw" -type f | wc -l)
echo "✅ 已备份 $FILE_COUNT 个文件" | tee -a "$LOG_FILE"

# Git 操作
cd "$BACKUP_DIR"

# 初始化 git（如果是第一次）
if [ ! -d ".git" ]; then
    echo "📦 初始化 Git 仓库..." | tee -a "$LOG_FILE"
    git init
    git config user.email "openclaw-backup@local"
    git config user.name "OpenClaw Backup"
fi

# 检查远程仓库
if ! git remote get-url origin 2>/dev/null | grep -q "github.com"; then
    echo "🔗 添加远程仓库..." | tee -a "$LOG_FILE"
    git remote add origin "https://github.com/mhkhiid/openclaw-config.git" 2>/dev/null || true
fi

# 添加所有文件
git add -A

# 提交（如果有变化）
COMMIT_MSG="Daily backup - $(date '+%Y-%m-%d %H:%M:%S') - $FILE_COUNT files"
if git diff --cached --quiet; then
    echo "ℹ️  没有变化，跳过提交" | tee -a "$LOG_FILE"
else
    echo "💾 提交更改: $COMMIT_MSG" | tee -a "$LOG_FILE"
    git commit -m "$COMMIT_MSG"
fi

# 推送到 GitHub
echo "🚀 推送到 GitHub..." | tee -a "$LOG_FILE"
# 使用 gh auth setup-git 确保凭证助手配置正确
gh auth setup-git 2>/dev/null || true

if git push origin main 2>&1 | tee -a "$LOG_FILE"; then
    echo "✅ 备份完成！$(date '+%H:%M:%S')" | tee -a "$LOG_FILE"
    echo "🌐 https://github.com/mhkhiid/openclaw-config" | tee -a "$LOG_FILE"
else
    echo "❌ 推送失败，请检查网络或认证" | tee -a "$LOG_FILE"
    exit 1
fi

echo "" | tee -a "$LOG_FILE"
