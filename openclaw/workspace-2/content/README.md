# 内容创作知识库

> 内容官的核心知识体系。接到创作任务时，先读这个文件定位需要调取的资料。

---

## 体系总览

### shared/ — 跨账号通用知识
| 文件 | 内容 | 何时读取 |
|------|------|----------|
| `global_rules.md` | 铁律 + 质量审核清单 | 写脚本前检查规则，写完后自审 |
| `data_pillars.md` | 28个核心数据支柱 | 写脚本时，确保引用3-5个 |
| `hook_formulas.md` | 6种钩子公式 + 历史案例 + 选题适配 | 生成钩子时 |
| `narrative_templates.md` | 4种叙事结构 + 适配矩阵 | 选择脚本框架时 |
| `formats/oral.md` | 口播格式指南 | 写口播脚本时 |
| `formats/vlog.md` | Vlog格式指南 | 写Vlog脚本时 |
| `formats/micro_drama.md` | 微演绎格式指南 | 写微演绎脚本时 |
| `cross_learnings.md` | 跨账号经验迁移 | 新账号启动 / 策略复用时 |
| `trending_topics.md` | 热点与节日选题日历 | 每日检查有无时效性窗口 |
| `experiment_log.md` | 创新实验记录 | 尝试新方法时 |
| `data_ingestion.md` | 数据录入与标准化规范 | 用户给原始数据要求录入时 |

### account_a/ — 米娅·抖音号
| 文件 | 内容 | 何时读取 |
|------|------|----------|
| `persona.md` | 人设档案（语言风格、定位、红线） | 确保语气和风格一致 |
| `account_rules.md` | 运营规则（配比、时长、发布时间） | 检查发布频率/时长/配比 |
| `learnings.md` | 经验沉淀 | 避免踩已知的坑 |
| `calendar.md` | 发布日历 | 查排期和空位 |
| `topic_log.md` | 选题发布记录 + 复用追踪 | 检查冷却期、复用历史 |
| `insights/topic_performance.md` | 各选题类型表现汇总 | 推荐选题时 |
| `insights/hook_performance.md` | 各钩子模型表现 | 选择钩子模型时 |
| `insights/format_performance.md` | 各格式表现 | 选择内容格式时 |
| `insights/duration_analysis.md` | 时长分析 | 确定目标时长时 |
| `insights/timing_analysis.md` | 发布时间分析 | 建议发布时间时 |
| `insights/recent_trends.md` | 近30天趋势 | 判断当前什么有效什么失效 |

---

## 工作流程

### 场景1：用户说"今天出什么"
1. 读 `account_a/insights/topic_performance.md` → 哪些选题类型表现好
2. 读 `account_a/insights/recent_trends.md` → 当前趋势
3. 读 `account_a/topic_log.md` → 冷却期状态
4. 读 `account_a/account_rules.md` → 本周配比余量
5. 综合推荐3个方案（含数据支撑 + 风险提示）

### 场景2：确定选题，需要钩子
1. 读 `shared/hook_formulas.md` 中对应选题的公式和案例
2. 读 `account_a/insights/hook_performance.md` 了解模型效果
3. 生成5个钩子选项（标注模型、冲击要素、预估留存、历史案例）

### 场景3：确认钩子，需要完整脚本
1. 从 `shared/narrative_templates.md` 选叙事结构
2. 读对应格式指南（`shared/formats/`）
3. 从 `shared/data_pillars.md` 选3-5个数据支柱
4. 读 `account_a/persona.md` 确保语气一致
5. 撰写脚本 + 附时间标记、字数、数据支柱、发布建议

### 场景4：自动质量审核
对照 `shared/global_rules.md` 中的10项检查清单打分（≥80分通过）

### 场景5：数据复盘
对比历史数据 → 归因分析 → 更新 learnings / topic_log / recent_trends

### 场景6：原始数据录入
按 `shared/data_ingestion.md` 规则处理，输出标准格式

### 场景7：尝试新方法
评估可行性 → 设计方案 → 记录到 `shared/experiment_log.md`

---

## 核心原则
- **数据说话**：推荐任何方案时引用历史数据
- **不编造数据**：缺失就标缺失
- **主动但不越界**：可以提建议，最终决策在用户
- **像搭档不像工具**：好想法增强执行，有风险指出问题，有更好方案主动提出
