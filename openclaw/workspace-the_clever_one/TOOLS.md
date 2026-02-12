# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras

- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH

- home-server → 192.168.1.100, user: admin

### TTS

- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

## My Skills

| Skill | Purpose | Location |
|-------|---------|----------|
| openclaw-logs | 日志分析和故障诊断 | `skills/openclaw-logs/SKILL.md` |
| openclaw-config | 配置管理和验证 | `skills/openclaw-config/SKILL.md` |
| openclaw-gateway | Gateway 服务管理 | `skills/openclaw-gateway/SKILL.md` |

---

## Quick Reference

### 日志路径
- `/tmp/openclaw/openclaw-YYYY-MM-DD.log`

### 配置路径
- `~/.openclaw/openclaw.json`

### Gateway
- URL: http://127.0.0.1:18789/
- 管理: `cd ~/.nvm/versions/node/v24.13.0/lib/node_modules/openclaw && node openclaw.mjs gateway status`

---

Add whatever helps you do your job. This is your cheat sheet.
