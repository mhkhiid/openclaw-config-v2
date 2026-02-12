# 手机远程控制 macOS Terminal 方案

**需求**: 通过飞书在手机端控制 macOS Terminal，作为 OpenClaw 崩溃时的备用方案

**时间**: 2026-02-10

## 备选方案

### 方案1: 飞书 Webhook + 本地 HTTP 服务（推荐）
- 在 Mac 上运行独立 Python/Node 服务（端口如 8080）
- 飞书自定义机器人发送命令到这个服务
- 服务接收消息后执行本地 shell 命令
- **优点**: 简单、独立、可控
- **缺点**: 需要公网或内网穿透

### 方案2: Telegram Bot
- 使用 python-telegram-bot
- 通过 Telegram 发送命令
- **优点**: 无需内网穿透（Telegram 服务器主动推送）
- **缺点**: 需要科学上网

### 方案3: SSH + 任意 SSH 客户端
- Mac 开启 SSH 服务
- 手机用 Termius/ServerCat 等 SSH 客户端
- **优点**: 最稳定、原生支持
- **缺点**: 命令行体验，不如飞书方便

### 方案4: 自建 Web Terminal
- 部署 ttyd / wetty 等 Web Terminal
- 配合 ngrok/frp 内网穿透
- 浏览器访问即可

## 推荐组合

**短期**: 方案3（SSH）+ 方案1（飞书 Webhook）
- SSH 作为保底
- 飞书 Webhook 作为便利层

**实现步骤待补充**...
