# OpenClaw 技术记忆

## 关于 Alex

- **姓名**: Alex
- **时区**: Asia/Shanghai (中国北京)
- **项目**: 构建 multi-agent AI workflow，用于护士就业服务和内容创作

## 当前系统架构

### Agent 矩阵
| Agent | 专长 | 状态 |
|-------|------|------|
| 助手圆 | 通用助手 / Orchestrator | ✅ 运行中 |
| 内容官 | 短视频/小红书内容创作 | ✅ 可用 |
| 聪明圆 (我) | OpenClaw 技术专家 | ✅ 运行中 |

### 配置概览
- **主配置**: `~/.openclaw/openclaw.json`
- **工作目录**: `~/.openclaw/workspace`
- **日志位置**: `/tmp/openclaw/openclaw-*.log`
- **Gateway**: http://127.0.0.1:18789/

### Provider 状态
| Provider | 状态 | 问题 |
|----------|------|------|
| kimi-coding/k2p5 | ✅ 正常 | 当前主 provider |
| openrouter | ❌ 不可用 | 缺少 apiKey |
| minimax-portal | ❌ 不可用 | OAuth 可能过期 |

---

## 技术决策记录

### 2026-02-11
- **决策**: Agent 监控改为按需检查
- **原因**: 每次对话前检查占用太多 context window
- **新规则**: 用户提醒时检查，或每天 heartbeat 检查一次

### 2026-02-11
- **发现**: OpenRouter billing error 实际是因为 auth profile 缺少 apiKey 字段
- **状态**: 待修复

---

## 常用命令备忘

```bash
# 查看日志
tail -100 /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log

# Gateway 管理
cd ~/.nvm/versions/node/v24.13.0/lib/node_modules/openclaw
node openclaw.mjs gateway status/start/stop

# 配置检查
cat ~/.openclaw/openclaw.json | jq '.agents'

# 备份检查
cd ~/.openclaw-backup && git status
```

---

## 重要发现

### 2026-02-13: Gateway 双进程冲突
- macOS launchd 服务 (`ai.openclaw.gateway`) 用 homebrew node v25.6.0 持续尝试启动 Gateway
- 手动启动的 Gateway 用 nvm node v24.13.0 已占用端口 18789
- `KeepAlive: true` 导致 launchd 每 ~10 秒重试，今天产生 725 次失败日志
- **影响**: 增加 I/O 负载，可能加剧消息延迟
- **待修复**: Alex 已知情，等确认后统一启动方式

### 2026-02-13: 飞书机器人全部就绪
- 4 个 agent 均已配置独立飞书机器人，收发正常
- 调查圆初始路由问题已修复（缺 binding 导致 fallback 到 main）

### 2026-02-13: 出差前系统优化
- Alex 即将出差，需要系统无人值守稳定运行
- 已安装向日葵远程控制；Tailscale 待 Alex 手动安装（需 sudo）
- 助手圆已配置 heartbeat
- OpenRouter API Key ✅ 已确认可用
- 网络：Clash Verge TUN 模式运行，稳定但无守护进程
- Gateway 双进程问题已解决：launchd 统一用 nvm v24.13.0

### 2026-02-13: 网络环境
- Mac mini 通过 Ethernet (en1) 连接
- Clash Verge TUN 模式 (utun1024) 做透明代理
- API 延迟偏高 (~3s)，但能正常通信
- DNS 用运营商 IPv6 DNS，可能不够稳定

## 待办

1. [x] ~~修复 Gateway 双进程冲突~~ → launchd 已统一 nvm node
2. [x] ~~修复 OpenRouter apiKey 配置~~ → 已确认可用
3. [ ] Alex 手动安装 Tailscale 并登录
4. [ ] 配置 Gateway tailscale.mode: "serve"（Tailscale 安装后）
5. [ ] 确认 Clash Verge 开机自启 + 订阅到期时间
6. [ ] 检查 minimax-portal OAuth 状态
7. [ ] 完善各 agent 的专属 skills
8. [ ] 可选：建立 cron 定时健康检查
