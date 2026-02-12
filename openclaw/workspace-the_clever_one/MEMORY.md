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

## 待办

1. [ ] 修复 OpenRouter apiKey 配置
2. [ ] 检查 minimax-portal OAuth 状态
3. [ ] 完善各 agent 的专属 skills
