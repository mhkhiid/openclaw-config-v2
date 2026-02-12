#!/bin/bash
# GitHub 推送脚本 - 在登录完成后运行

cd "$HOME/.openclaw-backup"

# 获取 GitHub 用户名
GH_USER=$(gh api user -q '.login' 2>/dev/null)

if [ -z "$GH_USER" ]; then
    echo "❌ GitHub 未登录，请先运行: gh auth login"
    exit 1
fi

echo "🐙 GitHub 用户: $GH_USER"

# 检查仓库是否存在
if gh repo view "$GH_USER/openclaw-config" >/dev/null 2>&1; then
    echo "📦 仓库已存在，添加远程地址..."
    git remote add origin "https://github.com/$GH_USER/openclaw-config.git" 2>/dev/null || git remote set-url origin "https://github.com/$GH_USER/openclaw-config.git"
else
    echo "📦 创建仓库..."
    gh repo create openclaw-config --private --source=. --push
    exit 0
fi

# 推送
echo "🚀 推送到 GitHub..."
git branch -M main
git push -u origin main

echo ""
echo "✅ 推送完成！"
echo "🌐 仓库地址: https://github.com/$GH_USER/openclaw-config"
