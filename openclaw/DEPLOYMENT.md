# OpenClaw 部署指南

> **持续更新文档** - 记录从初始部署开始的所有配置、调试和优化动作，便于未来在新终端快速复现。
> 
> **更新约定**：当执行新的部署/调试动作时，助手圆会同步更新此文档。

---

## 📋 快速部署 Checklist

### 1. 基础环境准备

- [ ] 安装 Node.js (v24.13.0+)
- [ ] 安装 OpenClaw CLI：`npm install -g openclaw`
- [ ] 初始化配置：`openclaw init`
- [ ] 验证安装：`openclaw status`

### 2. 核心服务配置

#### 2.1 Gateway 配置
```bash
# 启动 Gateway（首次）
openclaw gateway start

# 查看状态
openclaw gateway status

# Web UI 地址：http://127.0.0.1:18789/
```

#### 2.2 Agent 配置
- [ ] 创建 workspace 目录结构
- [ ] 配置 AGENTS.md、SOUL.md、USER.md、TOOLS.md
- [ ] 创建 memory 目录用于日志记录

### 3. 通讯渠道配置

#### 3.1 WhatsApp 配置
- [ ] 执行 `openclaw channels link whatsapp`
- [ ] 扫码配对（注意：容易 428 断连，断开后需重新扫码）
- [ ] 验证消息收发正常

#### 3.2 飞书配置（重点）

**单账户基础配置：**
- [ ] 在飞书开发者后台创建应用
- [ ] 获取 AppID 和 AppSecret
- [ ] 在 `openclaw.json` 中添加 feishu 配置：
```json
{
  "channels": {
    "feishu": {
      "accounts": {
        "accountName": {
          "appId": "cli_xxx",
          "appSecret": "xxx",
          "enabled": true
        }
      }
    }
  }
}
```
- [ ] 配置事件订阅/ WebSocket 连接模式
- [ ] 获取用户 open_id（给机器人发消息后查看日志）
- [ ] 在 bindings 中配置路由规则

**多账户/多 Agent 配置（进阶）：**
- [ ] 为每个 Agent 创建独立的飞书应用
- [ ] 在 `accounts` 中添加多个账户配置
- [ ] 在 `bindings` 中配置 `match.accountId` 路由
- [ ] **关键**：每个飞书应用的 open_id 体系独立，需分别获取

**坑点记录：**
- 错误 `open_id cross app`：说明使用了错误应用的 open_id
- 依赖需手动安装在 `~/.openclaw/extensions/feishu/`
- 全局 npm 中的重复插件需移除

### 4. Multi-Agent 配置

#### 4.1 主 Agent（助手圆）
- [ ] Workspace: `~/.openclaw/workspace`
- [ ] Agent ID: `main`
- [ ] 配置身份文件：SOUL.md、IDENTITY.md

#### 4.2 内容创作 Agent（内容官）
- [ ] 创建 workspace-neirongguan: `~/.openclaw/workspace-neirongguan`
- [ ] Agent ID: `neirongguan`
- [ ] 配置独立身份文件
- [ ] 绑定独立飞书应用

### 5. 容灾机制配置（pm2）

#### 5.1 安装 pm2
```bash
npm install -g pm2
```

#### 5.2 创建配置文件
路径：`~/.openclaw/workspace/ecosystem.config.js`

```javascript
module.exports = {
  apps: [{
    name: 'openclaw-gateway',
    script: 'openclaw.mjs',
    args: 'gateway run',  // ⚠️ 必须是 run，不能是 start
    cwd: '/Users/hengdeding/.nvm/versions/node/v24.13.0/lib/node_modules/openclaw',
    
    // 自动重启配置
    autorestart: true,
    max_restarts: 10,
    min_uptime: '10s',
    
    // 关键：启动前先修复
    pre_exec: 'openclaw doctor --fix',
    
    // 日志配置
    log_file: '/Users/hengdeding/.openclaw/logs/pm2-openclaw.log',
    log_date_format: 'YYYY-MM-DD HH:mm:ss Z',
    
    // 环境变量
    env: {
      NODE_ENV: 'production'
    },
    
    // 错误时等待 5 秒再重启
    exp_backoff_restart_delay: 5000
  }]
};
```

**关键坑点：**
- 必须使用 `gateway run`（前台运行），不能用 `gateway start`（后台 fork）
- pm2 需要持续运行的前台进程才能监控

#### 5.3 启动和保存
```bash
# 停止手动运行的 gateway
openclaw gateway stop

# 用 pm2 启动
cd ~/.openclaw/workspace
pm2 start ecosystem.config.js

# 保存配置
pm2 save

# 设置开机自启（可选）
pm2 startup
```

#### 5.4 常用命令
```bash
pm2 status                    # 查看状态
pm2 logs openclaw-gateway     # 查看日志
pm2 restart openclaw-gateway  # 手动重启
pm2 stop openclaw-gateway     # 停止
```

### 6. 备份配置

#### 6.1 自动备份脚本
路径：`~/.openclaw/workspace/backup-daily.sh`

```bash
#!/bin/zsh
BACKUP_DIR="$HOME/.openclaw-backup"
REPO_URL="https://github.com/mhkhiid/openclaw-config"

# 确保备份目录存在
mkdir -p "$BACKUP_DIR"
cd "$BACKUP_DIR"

# 如果目录为空，先克隆仓库
if [ ! -d ".git" ]; then
    git clone "$REPO_URL" .
fi

# 复制文件
rsync -av --delete "$HOME/.openclaw/" "$BACKUP_DIR/openclaw/"

# 提交并推送
DATE=$(date '+%Y-%m-%d %H:%M:%S')
git add .
git commit -m "Daily backup - $DATE - $(find openclaw -type f | wc -l) files"
git push origin main
```

#### 6.2 配置定时任务（cron）
```bash
# 编辑 crontab
crontab -e

# 添加行（每天凌晨 3 点执行）
0 3 * * * /Users/hengdeding/.openclaw/workspace/backup-daily.sh >> /Users/hengdeding/.openclaw-backup/backup.log 2>&1
```

### 7. 浏览器配置（可选）

**推荐方式：Managed Browser (Playwright)**
```bash
# 启动
openclaw browser start --browser-profile openclaw

# 打开网页
openclaw browser open --browser-profile openclaw https://example.com

# 截图
openclaw browser screenshot --browser-profile openclaw
```

**禁止操作：**
- ❌ 修改 `~/.openclaw/openclaw.json` 的 browser 配置
- ❌ 尝试设置默认 browser profile
- 后果：系统崩溃，需 `openclaw doctor` 修复

---

## 🐛 常见问题及解决方案

### 问题 1：Gateway 端口被占用
**现象：** `Port 18789 is already in use`
**解决：**
```bash
# 查找占用进程
lsof -i :18789

# 或停止现有 gateway
openclaw gateway stop

# 或用 launchctl
launchctl bootout gui/$UID/ai.openclaw.gateway
```

### 问题 2：飞书 open_id cross app 错误
**现象：** 发送消息失败，日志显示 `open_id cross app (code: 99992361)`
**原因：** 使用了错误飞书应用中的 open_id
**解决：** 给对应机器人发消息，从日志中获取正确的 open_id

### 问题 3：WhatsApp 428 断连
**现象：** WhatsApp 无法收发消息
**解决：** 重新执行 `openclaw channels link whatsapp` 并扫码

### 问题 4：pm2 无限重启
**现象：** pm2 status 显示 restart 次数不断增加
**原因：** 使用了 `gateway start` 而非 `gateway run`
**解决：** 修改 ecosystem.config.js 中的 args 为 `gateway run`

---

## 🔧 调试技巧

### 查看日志
```bash
# OpenClaw 主日志
tail -f /tmp/openclaw/openclaw-*.log

# pm2 日志
pm2 logs openclaw-gateway

# 备份日志
tail ~/.openclaw-backup/backup.log
```

### 诊断工具
```bash
openclaw doctor           # 诊断问题
openclaw doctor --fix     # 自动修复
```

---

## 📝 更新记录

| 日期 | 更新内容 | 备注 |
|------|---------|------|
| 2026-02-11 | 创建部署文档 | 初始版本，包含所有已完成的配置 |
| 2026-02-13 | 添加调查圆飞书机器人 | 新增 diaochayuan 账户绑定 researcher agent |

---

## ⚠️ 重要提醒

1. **敏感信息**：此文档不包含 AppSecret、Tokens 等敏感信息，需另行安全保管
2. **路径适配**：在新终端部署时，注意替换路径中的用户名（`hengdeding`）
3. **版本兼容**：部分配置可能随 OpenClaw 版本更新而失效，需定期验证
4. **持续更新**：未来所有部署/调试动作都会同步更新到此文档
