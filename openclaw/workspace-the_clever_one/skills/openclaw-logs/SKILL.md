# openclaw-logs

快速查询和分析 OpenClaw 日志，诊断问题。

## Usage

```
查看今日日志最后100行
查看昨天日志中的错误
搜索特定 runId 的日志
查看最近的 provider 错误
查看 session 状态变化
```

## 快捷命令

| 需求 | 命令 |
|------|------|
| 查看最新日志 | `tail -100 /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log` |
| 搜索错误 | `grep -i error /tmp/openclaw/openclaw-YYYY-MM-DD.log` |
| 查看特定 run | `grep "runId=XXX" /tmp/openclaw/openclaw-YYYY-MM-DD.log` |
| 查看 provider 错误 | `grep "billing\\|timeout\\|failover" /tmp/openclaw/openclaw-*.log` |

## Log 字段说明

- `runId` - 每次请求的唯一 ID
- `sessionId` - 会话 ID
- `provider` - 使用的 AI provider
- `lane task error` - 任务执行错误
- `embedded run prompt end` - 请求完成
- `durationMs` - 执行耗时

## 常见错误模式

### billing error
```
error="FailoverError: ⚠️ API provider returned a billing error"
```
→ API Key 余额不足或配置错误

### timeout
```
error="FailoverError: Request timed out."
```
→ 请求超时，检查网络或模型负载

### no available auth profile
```
error="FailoverError: No available auth profile for X"
```
→ auth profile 配置缺失或过期

## 示例

```bash
# 查看今日所有错误
grep -i "error" /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log | tail -20

# 查看特定消息的处理流程
grep "message_id: XXX" /tmp/openclaw/openclaw-*.log

# 统计今日请求数
grep "embedded run start" /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log | wc -l
```
