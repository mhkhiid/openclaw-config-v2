# OpenClaw 配置备份方案

## 🎯 目标
防止 OpenClaw 配置崩溃后无法恢复，建立可版本控制的备份系统。

## 📁 备份内容

| 文件/目录 | 说明 | 重要性 |
|-----------|------|--------|
| `openclaw.json` | 主配置文件 | ⭐⭐⭐ |
| `SOUL.md` | AI 人格定义 | ⭐⭐⭐ |
| `AGENTS.md` | Agent 行为规范 | ⭐⭐⭐ |
| `MEMORY.md` | 长期记忆 | ⭐⭐⭐ |
| `TOOLS.md` | 工具配置 | ⭐⭐ |
| `USER.md` | 用户信息 | ⭐⭐ |
| `IDENTITY.md` | 身份定义 | ⭐⭐ |
| `memory/` | 每日记忆文件 | ⭐⭐ |

## 🚀 快速设置

### 1. 登录 GitHub CLI
```bash
gh auth login
# 选择 HTTPS 或 SSH，按提示完成认证
```

### 2. 创建私有仓库
```bash
gh repo create openclaw-config --private --description "OpenClaw configuration backup"
```

### 3. 运行首次备份
```bash
~/.openclaw/workspace/backup-openclaw.sh "Initial backup"
```

## 📋 日常使用

### 手动备份
```bash
# 使用默认提交信息（时间戳）
~/.openclaw/workspace/backup-openclaw.sh

# 使用自定义提交信息
~/.openclaw/workspace/backup-openclaw.sh "Added Feishu integration"
```

### 查看备份历史
```bash
cd ~/.openclaw-backup
git log --oneline
```

### 恢复到之前版本
```bash
cd ~/.openclaw-backup
# 查看历史
git log

# 恢复到某个提交
git checkout <commit-hash>
./restore.sh

# 或者恢复特定文件
git checkout <commit-hash> -- openclaw.json
cp openclaw.json ~/.openclaw/
```

## 🆘 紧急恢复

如果 OpenClaw 完全崩溃：

```bash
# 1. 克隆备份仓库
cd ~
git clone https://github.com/YOUR_USERNAME/openclaw-config.git

# 2. 运行恢复脚本
cd openclaw-config
./restore.sh

# 3. 重启 Gateway
openclaw gateway restart
```

## 🔄 自动备份（可选）

添加 cron 任务，每天自动备份：

```bash
# 编辑 crontab
crontab -e

# 添加以下行（每天凌晨 3 点备份）
0 3 * * * ~/.openclaw/workspace/backup-openclaw.sh "Auto backup $(date +\%Y-\%m-\%d)" >> ~/.openclaw-backup/backup.log 2>>1
```

## ⚠️ 安全提醒

1. **仓库设为私有** - 包含敏感信息（API keys、tokens）
2. **不要备份 credentials 目录** - 已排除在备份外
3. **定期更换 token** - 如果怀疑泄露

## 📝 备份脚本位置

- 脚本：`~/.openclaw/workspace/backup-openclaw.sh`
- 备份目录：`~/.openclaw-backup/`
- GitHub 仓库：`https://github.com/YOUR_USERNAME/openclaw-config`

---

*最后更新：2026-02-10*
