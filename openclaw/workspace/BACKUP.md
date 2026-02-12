# OpenClaw 配置备份方案

## 🎯 目标
防止 OpenClaw 配置崩溃后无法恢复，建立可版本控制的备份系统。

## ✅ 当前状态

**每日自动备份已启用！**
- ⏰ 时间：每天凌晨 3:00
- 📦 内容：整个 `~/.openclaw` 文件夹
- 🌐 仓库：https://github.com/mhkhiid/openclaw-config (Private)
- 📊 文件数：约 2800 个文件

## 📁 备份内容

| 文件/目录 | 说明 | 重要性 |
|-----------|------|--------|
| `openclaw.json` | 主配置文件 | ⭐⭐⭐ |
| `agents/` | Agent 配置 | ⭐⭐⭐ |
| `workspace/` | 工作区文件 | ⭐⭐⭐ |
| `extensions/` | 插件配置 | ⭐⭐ |
| `credentials/` | 认证信息（已加密） | ⭐⭐ |
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
# 完整备份（整个 .openclaw 文件夹）
~/.openclaw/workspace/backup-daily.sh

# 仅备份 workspace
~/.openclaw/workspace/backup-openclaw.sh "Custom backup"
```

### 查看备份历史
```bash
cd ~/.openclaw-backup
git log --oneline
```

### 查看备份日志
```bash
tail -f ~/.openclaw-backup/backup.log
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
git checkout <commit-hash> -- openclaw/openclaw.json
cp openclaw/openclaw.json ~/.openclaw/
```

## 🆘 紧急恢复

如果 OpenClaw 完全崩溃：

```bash
# 1. 克隆备份仓库
cd ~
git clone https://github.com/mhkhiid/openclaw-config.git

# 2. 运行恢复脚本
cd openclaw-config
./restore.sh

# 3. 重启 Gateway
cd ~/.nvm/versions/node/v24.13.0/lib/node_modules/openclaw
node openclaw.mjs gateway restart
```

## 🔄 自动备份详情

**已配置 Cron 任务：**
```bash
# 查看当前定时任务
crontab -l

# 编辑定时任务
crontab -e
```

**当前配置（每天凌晨 3:00）：**
```
0 3 * * * /Users/hengdeding/.openclaw/workspace/backup-daily.sh >> /Users/hengdeding/.openclaw-backup/cron.log 2>&1
```

**修改备份时间：**
```bash
# 改为每天中午 12 点
0 12 * * * /Users/hengdeding/.openclaw/workspace/backup-daily.sh >> /Users/hengdeding/.openclaw-backup/cron.log 2>&1

# 改为每小时备份一次
0 * * * * /Users/hengdeding/.openclaw/workspace/backup-daily.sh >> /Users/hengdeding/.openclaw-backup/cron.log 2>&1

# 改为每周日凌晨备份
0 3 * * 0 /Users/hengdeding/.openclaw/workspace/backup-daily.sh >> /Users/hengdeding/.openclaw-backup/cron.log 2>&1
```

## ⚠️ 安全提醒

1. **仓库设为私有** - 包含敏感信息（API keys、tokens）
2. **已排除的文件：**
   - `.DS_Store` - 系统文件
   - `*.log` - 日志文件
   - `node_modules/` - 依赖包
   - `**/.git` - Git 仓库
   - `tmp/` `temp/` - 临时文件
3. **定期更换 token** - 如果怀疑泄露

## 📝 文件位置

| 文件 | 位置 | 说明 |
|------|------|------|
| 每日备份脚本 | `~/.openclaw/workspace/backup-daily.sh` | 完整备份 |
| Workspace 备份 | `~/.openclaw/workspace/backup-openclaw.sh` | 仅工作区 |
| 推送脚本 | `~/.openclaw/workspace/push-to-github.sh` | GitHub 推送 |
| 本地备份 | `~/.openclaw-backup/` | 备份目录 |
| 备份日志 | `~/.openclaw-backup/backup.log` | 历史记录 |
| GitHub 仓库 | `https://github.com/mhkhiid/openclaw-config` | 云端备份 |

---

*最后更新：2026-02-10*
