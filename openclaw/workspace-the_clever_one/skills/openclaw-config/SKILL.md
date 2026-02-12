# openclaw-config

管理和检查 OpenClaw 配置，诊断配置问题。

## Usage

```
查看当前 agent 配置
检查 provider 配置
查看 auth profiles
检查 channel 配置
查看模型 fallback 链
```

## 配置文件位置

- **主配置**: `~/.openclaw/openclaw.json`
- **环境变量**: `~/.openclaw/.env`
- **Agent 配置**: `~/.openclaw/workspace/IDENTITY.md`, `SOUL.md`, `USER.md`

## 常用检查命令

### 查看 agents 配置
```bash
cat ~/.openclaw/openclaw.json | jq '.agents'
```

### 查看 auth profiles
```bash
cat ~/.openclaw/openclaw.json | jq '.auth.profiles'
```

### 查看 providers
```bash
cat ~/.openclaw/openclaw.json | jq '.models.providers'
```

### 查看 channels
```bash
cat ~/.openclaw/openclaw.json | jq '.channels'
```

## 配置检查清单

### Agent 配置完整性
- [ ] `IDENTITY.md` - 身份定义
- [ ] `SOUL.md` - 性格/行为准则
- [ ] `USER.md` - 用户信息
- [ ] `AGENTS.md` - 工作区规则
- [ ] `MEMORY.md` - 长期记忆
- [ ] `TOOLS.md` - 工具配置

### Provider 配置
- [ ] API Key 正确设置
- [ ] Base URL 正确
- [ ] 模型列表已定义
- [ ] Fallback 链已配置

### Auth Profile
- [ ] 有默认 profile
- [ ] mode 正确 (api_key/oauth)
- [ ] apiKey 不为空 (api_key mode)

### Channel 配置
- [ ] App ID / Secret 正确
- [ ] WebSocket 连接正常
- [ ] 消息策略已设置

## 常见问题修复

### 添加/更新 API Key
```bash
# 编辑配置文件
nano ~/.openclaw/openclaw.json

# 在 auth.profiles 中添加:
"provider:default": {
  "provider": "provider-name",
  "mode": "api_key",
  "apiKey": "sk-xxx"
}
```

### 修复 Git 推送问题
```bash
cd ~/.openclaw-backup
gh auth setup-git
git push origin main
```

## 配置验证

```bash
# 检查 JSON 语法
cat ~/.openclaw/openclaw.json | jq '.'

# 检查关键字段是否存在
cat ~/.openclaw/openclaw.json | jq '.agents.defaults.model.primary'
cat ~/.openclaw/openclaw.json | jq '.auth.profiles | keys'
```
