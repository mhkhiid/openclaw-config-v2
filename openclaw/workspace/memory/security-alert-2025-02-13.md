# 安全警报 - 2025-02-13

## 问题描述
GitHub 备份检测到敏感文件泄漏风险，推送被拒绝。

## 发现的问题
1. GitHub secret scanning 检测到历史 commit 中的敏感信息
2. `.gitignore` 未完全覆盖所有敏感文件类型：
   - `*.jsonl.lock` 文件未被排除
   - `*.deleted.*` 文件未被排除
   - `sessions.json` 索引文件

## 已采取的措施
1. ✅ 更新 `.gitignore` 添加更全面的排除规则
2. ✅ 从 git staging 中移除敏感文件
3. ✅ 清理已删除的会话文件 (`.deleted.*`)
4. ✅ 成功推送修复后的提交

## 当前状态
- 备份状态：✅ 正常
- 最新提交：`d818864` - Update .gitignore
- 敏感文件：已从 Git 缓存中移除

## 建议
1. 考虑使用 `git-filter-repo` 彻底清理历史记录中的敏感信息
2. 定期检查 `.gitignore` 是否覆盖新增文件类型
3. 监控 GitHub secret scanning 告警

## 相关文件
- 备份脚本：`~/.openclaw/workspace/backup-daily.sh`
- 备份目录：`~/.openclaw-backup/`
- 仓库：https://github.com/mhkhiid/openclaw-config-v2
