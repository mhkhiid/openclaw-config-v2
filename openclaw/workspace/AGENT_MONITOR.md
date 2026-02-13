# Agent 监控清单 - 助手圆 (Orchestrator)

**监控模式**: 主动模式 ✅  
**最后更新**: 2026-02-11

---

## Agent 总览

| Agent | ID | Workspace | 主要职责 | 配置状态 | 备注 |
|-------|-----|-----------|----------|----------|------|
| 助手圆 | main | `workspace` | 通用助手 / Orchestrator | ✅ 完整 | 当前运行中 |
| 内容官 | neirongguan | `workspace-neirongguan` | 短视频/小红书内容创作 | ⚠️ 待完善 | IDENTITY 基础完成，待补充创作风格 |
| 聪明圆 | the_clever_one | `workspace-the_clever_one` | OpenClaw 技术专家 | ⚠️ 待完善 | IDENTITY 基础完成，待补充技能细节 |

---

## 各 Agent 详细配置检查清单

### 1️⃣ 内容官 (neirongguan)
**飞书机器人**: cli_a906a3e9ca211bca

**已配置**:
- [x] `IDENTITY.md` - 基础身份
- [x] `SOUL.md` - 通用模板
- [x] `AGENTS.md` - 存在
- [x] `USER.md` - 存在

**待完善**:
- [ ] 创作风格详细定义（Alex 提到有待导入的 md 文件）
- [ ] 专属 Skills（如果有）
- [ ] 飞书多维表格集成配置
- [ ] Avatar/头像

**调用时机**:
- 短视频脚本创作
- 小红书内容策划
- 热点话题分析
- 对标作品拆解

---

### 2️⃣ 聪明圆 (the_clever_one)

**已配置**:
- [x] `IDENTITY.md` - 基础身份
- [x] `SOUL.md` - 通用模板
- [x] `AGENTS.md` - 存在
- [x] `USER.md` - 存在

**待完善**:
- [ ] OpenClaw 技术专长详细定义
- [ ] 专属 Skills
- [ ] Avatar/头像

**调用时机**:
- OpenClaw 配置/调试问题
- 技术架构设计
- Multi-agent workflow 设计

---

## 监控规则

### 按需检查（推荐）
当 Alex 说以下关键词时，我去检查其他 agent 状态：
- "检查一下其他 agent"
- "看看内容官/聪明圆"
- "agent 状态"
- "更新监控"

### 每日检查（Heartbeat）
- 频率：每天一次（通过 Heartbeat 机制）
- 内容：快速扫描各 agent 配置文件变化
- 如发现重要更新，主动汇报

### 每周深度检查
1. 完整配置审查
2. 缺失项汇总报告
3. 调用能力评估

### 触发调用的条件
- 任务明确匹配某 agent 专长
- 当前任务可并行分解给多个 agent
- 需要专项技能（如内容创作、技术调试）

### Context Window 优化
- ❌ 不再每次对话前自动检查（节省 tokens）
- ✅ 被动响应 + 定时检查结合

---

## 历史记录

### 2026-02-11
- 初始化监控清单
- 内容官和聪明圆基础配置已存在，待完善细节
