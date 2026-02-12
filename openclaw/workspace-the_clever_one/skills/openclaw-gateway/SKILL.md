# openclaw-gateway

管理 OpenClaw Gateway 服务，控制守护进程和 Web UI。

## Usage

```
检查 Gateway 状态
启动 Gateway
停止 Gateway
重启 Gateway
打开 Web UI
```

## Gateway 信息

- **Web UI**: http://127.0.0.1:18789/
- **Token**: (从配置中获取)
- **模式**: local
- **绑定**: loopback (仅本地访问)

## 管理命令

### 查看状态
```bash
cd ~/.nvm/versions/node/v24.13.0/lib/node_modules/openclaw
node openclaw.mjs gateway status
```

### 启动 Gateway
```bash
cd ~/.nvm/versions/node/v24.13.0/lib/node_modules/openclaw
node openclaw.mjs gateway start
```

### 停止 Gateway
```bash
cd ~/.nvm/versions/node/v24.13.0/lib/node_modules/openclaw
node openclaw.mjs gateway stop
```

### 重启 Gateway
```bash
cd ~/.nvm/versions/node/v24.13.0/lib/node_modules/openclaw
node openclaw.mjs gateway restart
```

## 配置位置

```json
{
  "gateway": {
    "port": 18789,
    "mode": "local",
    "bind": "loopback",
    "auth": {
      "mode": "token",
      "token": "your-token-here"
    }
  }
}
```

## Web UI 功能

- 查看所有 sessions
- 检查 agent 状态
- 查看消息日志
- 管理 cron jobs
- 重启 gateway

## 故障排查

### Gateway 无法启动
1. 检查端口 18789 是否被占用
2. 检查配置文件语法
3. 查看日志: `/tmp/openclaw/openclaw-*.log`

### Web UI 无法访问
1. 确认 Gateway 已启动
2. 检查 token 是否正确
3. 确认访问的是 http://127.0.0.1:18789/

### 需要开放外部访问
修改配置:
```json
{
  "gateway": {
    "bind": "all"
  }
}
```
⚠️ 注意安全风险，建议配合防火墙使用

## 快捷方式

```bash
# 添加到 .zshrc
alias ocg='cd ~/.nvm/versions/node/v24.13.0/lib/node_modules/openclaw && node openclaw.mjs gateway'

# 使用
ocg status
ocg restart
```
