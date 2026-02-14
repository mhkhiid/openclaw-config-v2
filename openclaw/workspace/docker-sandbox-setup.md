# Docker沙箱配置指南

> 准备时间：2026-02-14
> 状态：待Alex回电脑后执行

## 第1步：安装Docker Desktop

```bash
# 方法1：Homebrew（推荐）
brew install --cask docker

# 方法2：手动下载
# 访问 https://www.docker.com/products/docker-desktop/
# 下载 Mac (Apple Silicon) 版本
# 拖到 Applications
```

安装后首次启动Docker Desktop，需要授权。

## 第2步：构建沙箱镜像

```bash
cd ~/.nvm/versions/node/v24.13.0/lib/node_modules/openclaw
bash scripts/sandbox-setup.sh
```

## 第3步：配置openclaw.json

由助手圆通过config.patch添加（不手动编辑）：

```json5
{
  "agents": {
    "list": [
      {
        "id": "researcher",
        "sandbox": {
          "mode": "all",
          "scope": "agent",
          "workspaceAccess": "rw",
          "docker": {
            "network": "bridge"  // 需要网络才能搜索
          }
        },
        "tools": {
          "alsoAllow": ["web_search", "web_fetch", "browser", "memory_search", "memory_get"]
        }
      }
    ]
  }
}
```

## 第4步：验证

```bash
openclaw sandbox explain researcher
```

## 注意事项
- Docker Desktop占用约2GB磁盘
- 沙箱容器默认无网络，搜索需要设置 network: "bridge"
- 调查圆在沙箱内可以有更高权限（browser等），因为已被隔离
