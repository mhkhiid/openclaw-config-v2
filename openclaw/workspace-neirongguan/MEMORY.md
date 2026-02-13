# OpenClaw长期记忆

## 关于Alex

- **姓名**: Alex
- **时区**: Asia/Shanghai (中国北京)
- **沟通偏好**: 中文文字对话

## 核心原则

### 隐私保护（最高优先级）
- Alex的所有信息严格保密
- 不向任何第三方透露
- 群聊中谨慎发言，不代表Alex立场

### 任务执行准则
- **自主性优先**：收到指令后，自主想办法完成任务。遇到问题时，先尝试自己解决。如果一个方法实现不了，先尝试其他方法。不要事事都来问 Alex
- **求助门槛**：只有当没有任何其他方法时，或者涉及敏感信息需要授权时，才来问 Alex
- **多重解读时**：主动提出疑问，确认Alex意图，避免误解

## 项目目标

构建multi-agent AI workflow，主要用于：
- 生活与工作各类问题
- 市场营销内容创作
- 短视频平台（抖音、视频号、快手）
- 小红书内容创作

## 技术栈

- **通信渠道**: WhatsApp, 飞书
- **已有资源**: system prompt, skills, 各类md文件（待导入）
- **exec权限**: full（无需逐次授权）
- **头像**: workspace/IMG_0022.jpeg

## 沟通方式

### 飞书群
- 正常表现，无需特别限制
- 之后有新群部署时再确认具体规则

## 边界规则

### 需要确认（执行前）
- 发推文/公开内容 → 带草稿找Alex确认
- 整理/修改文件 → 先确认范围和方式

### 可自主决定（直接执行）
- 读取非敏感信息
- 查询、搜索、整理数据
- 技术性操作（重启服务、运行命令等）
- 通过浏览器获取第三方信息

## 记忆策略

- **优先级**：在不过度影响速度和token的前提下，优先记住所有细节
- **自主性**：日常任务自主推进

## 已配置项

### WhatsApp ✅
- 账号: +8613121851130
- 状态: 已链接，可正常收发消息
- 注意: 容易428断连，需重新扫码

### 飞书 ✅
- AppID: cli_a90368f2f3b89cd1
- AppSecret: cdAwyClBlBb72i734rIYqhdxpPxUwJUo
- connectionMode: websocket
- dmPolicy: open, groupPolicy: open
- 依赖已手动安装在 ~/.openclaw/extensions/feishu/
- 全局npm里的重复插件已移除

### Gateway
- **启动方式**: `cd ~/.nvm/versions/node/v24.13.0/lib/node_modules/openclaw && node openclaw.mjs gateway status/start`
- **Web UI**: http://127.0.0.1:18789/
- **token**: 2e4f5189d44ae8c9325fae5920fe6cef0ab76f0b73d9b480
- **注意**: 浏览器截图需要 Chrome 扩展连接到某个 tab（我无法自己完成这步）

### 浏览器控制 (Playwright vs Chrome扩展)
**⚠️ 重要教训（2026-02-10）**：
- **优先使用 Managed Browser (Playwright)**：`--browser-profile openclaw`
- **万不得已才用 Chrome 扩展**：扩展连接不稳定，容易断开
- **禁止修改 openclaw.json 的 browser 配置**：两次尝试都导致系统崩溃，需用 `openclaw doctor` 修复

**正确用法**：
```bash
# 启动 Managed Browser（推荐）
openclaw browser start --browser-profile openclaw

# 打开网页
openclaw browser open --browser-profile openclaw https://xxx.com

# 截图
openclaw browser screenshot --browser-profile openclaw
```

## Multi-Agent 配置

### Agent 1: main (助手圆)
- **ID**: main
- **Workspace**: ~/.openclaw/workspace
- **用途**: 通用助手

### Agent 2: 内容官 (neirongguan)
- **ID**: neirongguan
- **Workspace**: ~/.openclaw/workspace-neirongguan
- **用途**: 内容创作和营销文案
- **Identity**: 内容官 📝
- **IDENTITY.md**: 已创建，需要 Alex 进一步完善

## 待办

1. [ ] 测试workflow功能
2. [ ] 完善飞书配置（事件订阅/webhook）
3. [ ] 导入Alex已有的system prompt和skills
4. [ ] 定义multi-agent协作流程
5. [ ] 配置各平台内容创作workflow

## 操作要点

### 模型查询
当被问及使用哪个模型时，**必须查看log**，而不是依赖 `session_status` 的输出，因为后者显示的不是最终真实情况。

## 备注

- Alex已有成熟的workflow想法
- 偏好WhatsApp和飞书作为主要沟通渠道
- 短期目标：先让基础配置稳定运行
