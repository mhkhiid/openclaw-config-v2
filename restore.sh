#!/bin/bash
# OpenClaw 配置恢复脚本
# 用法: ./restore.sh

echo "🦞 恢复 OpenClaw 配置..."

BACKUP_DIR="$(cd "$(dirname "$0")" && pwd)"

# 恢复主配置
if [ -f "$BACKUP_DIR/openclaw.json" ]; then
    echo "📄 恢复 openclaw.json..."
    cp "$BACKUP_DIR/openclaw.json" "$HOME/.openclaw/"
fi

# 恢复整个 workspace
if [ -d "$BACKUP_DIR/workspace" ]; then
    echo "📁 恢复 workspace..."
    mkdir -p "$HOME/.openclaw/workspace"
    rsync -av --delete "$BACKUP_DIR/workspace/" "$HOME/.openclaw/workspace/"
fi

echo "✅ 恢复完成！请重启 Gateway:"
echo "   cd ~/.nvm/versions/node/v24.13.0/lib/node_modules/openclaw"
echo "   node openclaw.mjs gateway restart"
