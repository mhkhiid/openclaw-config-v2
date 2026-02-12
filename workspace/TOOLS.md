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

### Browser (OpenClaw)

**⚠️ 重要：优先使用 Managed Browser，禁止修改 openclaw.json！**

#### 推荐方式：Managed Browser (Playwright)
```bash
# 启动
openclaw browser start --browser-profile openclaw

# 打开网页
openclaw browser open --browser-profile openclaw https://example.com

# 截图
openclaw browser screenshot --browser-profile openclaw

# 查看状态
openclaw browser status --browser-profile openclaw
```

#### 备选方式：Chrome 扩展（不稳定）
- 需要手动点击扩展图标连接
- 容易断开，不推荐
- 仅当 Managed Browser 不可用时使用

#### 禁止操作
❌ 修改 `~/.openclaw/openclaw.json` 的 browser 配置  
❌ 尝试设置默认 browser profile  
❌ 使用 `openclaw browser use` 命令

**后果**：系统崩溃，需运行 `openclaw doctor` 修复

---

Add whatever helps you do your job. This is your cheat sheet.
