#!/bin/bash
# OpenClaw 配置备份脚本
# 用法: ./backup-openclaw.sh [commit-message]

set -e

BACKUP_DIR="$HOME/.openclaw-backup"
CONFIG_FILE="$HOME/.openclaw/openclaw.json"
WORKSPACE_DIR="$HOME/.openclaw/workspace"
REPO_NAME="openclaw-config"

echo "🦞 OpenClaw 配置备份工具"
echo "=========================="

# 1. 确保备份目录存在
mkdir -p "$BACKUP_DIR"

# 2. 创建结构化备份
echo "📁 备份所有配置文件..."

# 备份主配置
cp "$CONFIG_FILE" "$BACKUP_DIR/openclaw.json"

# 备份整个 workspace（排除 .git 和敏感信息）
echo "📁 备份 workspace 所有文件..."
rsync -av --delete \
    --exclude='.git' \
    --exclude='.DS_Store' \
    --exclude='*.log' \
    --exclude='node_modules' \
    "$WORKSPACE_DIR/" "$BACKUP_DIR/workspace/"

# 3. 生成恢复脚本
cat > "$BACKUP_DIR/restore.sh" << 'EOF'
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
EOF

chmod +x "$BACKUP_DIR/restore.sh"

# 4. Git 操作
cd "$BACKUP_DIR"

if [ ! -d ".git" ]; then
    echo "📦 初始化 Git 仓库..."
    git init
fi

# 检查是否已有远程仓库
if ! git remote get-url origin 2>/dev/null | grep -q "github.com"; then
    echo "🔗 请运行以下命令创建 GitHub 仓库并关联:"
    echo "   gh repo create $REPO_NAME --private --source=. --push"
    echo ""
    echo "💡 或者手动创建仓库后运行:"
    echo "   git remote add origin https://github.com/YOUR_USERNAME/$REPO_NAME.git"
fi

# 添加所有文件
git add -A

# 提交
COMMIT_MSG="${1:-Backup $(date '+%Y-%m-%d %H:%M:%S')}"
if git diff --cached --quiet; then
    echo "ℹ️  没有变化，跳过提交"
else
    echo "💾 提交更改: $COMMIT_MSG"
    git commit -m "$COMMIT_MSG"
fi

# 5. 推送到 GitHub（如果配置了远程）
if git remote get-url origin 2>/dev/null | grep -q "github.com"; then
    echo "🚀 推送到 GitHub..."
    git push origin $(git branch --show-current) 2>/dev/null || echo "⚠️  推送失败，请检查 GitHub 配置"
fi

echo ""
echo "✅ 备份完成！"
echo "📂 备份位置: $BACKUP_DIR"
echo "🔄 恢复命令: $BACKUP_DIR/restore.sh"
echo ""
echo "📋 备份的文件列表:"
find "$BACKUP_DIR" -type f ! -path '*/.git/*' | head -20
