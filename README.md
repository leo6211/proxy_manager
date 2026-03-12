# proxy_manager

一个轻量级的 Shell 代理管理脚本，提供一组便捷命令，用于快速开启、关闭和查看系统代理设置。

## 功能

| 命令 | 说明 |
|------|------|
| `proxy_on [host:port]` | 开启 HTTP/HTTPS 代理（默认：`127.0.0.1:6152`） |
| `proxy_socks [host:port]` | 开启 SOCKS5 代理（默认：`127.0.0.1:1080`） |
| `proxy_off` | 关闭所有代理 |
| `proxy_status` | 查看当前代理环境变量 |
| `proxy_test` | 测试代理是否可用（访问 google.com） |
| `proxy_git_on [host:port]` | 为 Git 全局设置代理 |
| `proxy_git_off` | 关闭 Git 全局代理 |
| `proxy_help` | 显示帮助信息 |

## 安装

> **注意**：脚本中的命令是 Shell 函数，必须通过 `source` 载入当前 Shell，直接执行脚本不会生效。

### 1. 克隆仓库（或下载脚本）

```bash
git clone https://github.com/<your-username>/proxy_manager.git ~/tool
```

或者直接下载脚本文件：

```bash
curl -o ~/tool/proxy_manager.sh https://raw.githubusercontent.com/<your-username>/proxy_manager/main/proxy_manager.sh
```

### 2. 集成到 Zsh（`.zshrc`）

编辑 `~/.zshrc`，在末尾添加：

```zsh
# 加载代理管理函数
source ~/tool/proxy_manager.sh
```

然后重新加载配置：

```bash
source ~/.zshrc
```

### 3. 集成到 Bash（`.bashrc`）

编辑 `~/.bashrc`，在末尾添加：

```bash
# 加载代理管理函数
source ~/tool/proxy_manager.sh
```

然后重新加载配置：

```bash
source ~/.bashrc
```

## 使用示例

```bash
# 使用默认代理（127.0.0.1:6152）
proxy_on

# 使用自定义代理地址
proxy_on 192.168.1.100:8080

# 使用 SOCKS5 代理
proxy_socks 127.0.0.1:1080

# 查看当前代理状态
proxy_status

# 测试代理连通性
proxy_test

# 为 Git 设置代理
proxy_git_on

# 关闭所有代理
proxy_off
```

## 默认不走代理的地址

脚本自动将以下地址加入 `NO_PROXY`，不经过代理：

```
localhost, 127.0.0.1, ::1, *.local, 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12
```

## 注意事项

- 代理设置仅在**当前终端会话**中有效，关闭终端后自动失效（因为是环境变量）。
- 若需要持久生效，使用 `proxy_git_on` 将代理写入 Git 全局配置。
- `proxy_test` 通过访问 `google.com` 来验证代理是否可用，请确保网络允许该请求。

## License

MIT
