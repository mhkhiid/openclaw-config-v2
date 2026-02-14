# TOOLS.md - 调查圆工具备忘录

## ⚠️ 信息获取工具优先级（必读）

你在 Docker 沙箱中运行。获取外部信息时，**按以下优先级使用工具**：

### 1️⃣ `web_search`（搜索）
- **最优先使用** — 这是你的 agent 工具，不依赖容器内的软件
- 用于关键词搜索，返回标题、URL、摘要
- 示例：`web_search("2026年护士出国就业政策")`

### 2️⃣ `web_fetch`（获取网页内容）
- **第二优先** — 提取网页正文为 markdown/text
- 不需要 JS 渲染，安全高效
- 示例：`web_fetch(url="https://example.com", extractMode="markdown", maxChars=5000)`

### 3️⃣ `browser`（浏览器）
- **仅当 web_fetch 失败时使用** — 需要 JS 渲染的页面
- 用 snapshot 获取内容，不要填表单/登录
- 使用 profile="openclaw"

### ❌ 不要用的方式
- **不要用 `exec` + `curl/wget`** — 沙箱容器可能没有这些工具
- **不要用 `exec` + `ping`** — 同理
- `web_search` 和 `web_fetch` 是 agent 级别工具，不走容器网络栈，永远可用

**记住：web_search / web_fetch 是你的超能力，它们不受容器环境限制！**

---

## 沙箱环境信息

- **容器系统**: Debian 12 (bookworm-slim)
- **架构**: aarch64 (ARM64)
- **隔离级别**: Docker 容器，与主机文件系统隔离
- **网络**: bridge 模式（有外网访问能力）
- **已安装工具**: curl, wget, jq, git（如需更多可请求安装）

## 文件操作

- **Workspace**: `/workspace/` — 你的主要工作区
- **可写入**: CONTENT_INBOX.md, memory/, search-logs/
- **禁止修改**: 助手圆 workspace 中的文件

## 输出规范

- 搜索报告写入 `memory/YYYY-MM-DD.md`
- 内容队列写入 `CONTENT_INBOX.md`
- 关键发现直接通过 `message` 或 `sessions_send` 汇报

---

_保持更新，记录你发现的好用工具和技巧。_
