#!/bin/bash

# 代理管理脚本 - 快速设置和管理系统代理

# 设置代理
proxy_on() {
    local proxy_host="${1:-127.0.0.1:6152}"  # 默认代理地址，可通过参数修改

    export HTTP_PROXY="http://${proxy_host}"
    export HTTPS_PROXY="http://${proxy_host}"
    export http_proxy="http://${proxy_host}"
    export https_proxy="http://${proxy_host}"
    export ALL_PROXY="http://${proxy_host}"
    export all_proxy="http://${proxy_host}"

    # 设置不走代理的地址
    export NO_PROXY="localhost,127.0.0.1,::1,*.local,192.168.0.0/16,10.0.0.0/8,172.16.0.0/12"
    export no_proxy="localhost,127.0.0.1,::1,*.local,192.168.0.0/16,10.0.0.0/8,172.16.0.0/12"

    echo "✓ 代理已开启: ${proxy_host}"
    echo "  HTTP_PROXY=${HTTP_PROXY}"
    echo "  HTTPS_PROXY=${HTTPS_PROXY}"
}

# 设置 SOCKS5 代理
proxy_socks() {
    local proxy_host="${1:-127.0.0.1:1080}"

    export ALL_PROXY="socks5://${proxy_host}"
    export all_proxy="socks5://${proxy_host}"
    export NO_PROXY="localhost,127.0.0.1,::1,*.local"
    export no_proxy="localhost,127.0.0.1,::1,*.local"

    echo "✓ SOCKS5 代理已开启: ${proxy_host}"
    echo "  ALL_PROXY=${ALL_PROXY}"
}

# 关闭代理
proxy_off() {
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset FTP_PROXY
    unset ALL_PROXY
    unset http_proxy
    unset https_proxy
    unset ftp_proxy
    unset all_proxy
    unset NO_PROXY
    unset no_proxy

    echo "✓ 代理已关闭"
}

# 查看代理状态
proxy_status() {
    echo "当前代理状态:"
    echo "----------------------------------------"
    if [ -n "$HTTP_PROXY" ]; then
        echo "HTTP_PROXY    = $HTTP_PROXY"
    else
        echo "HTTP_PROXY    = (未设置)"
    fi

    if [ -n "$HTTPS_PROXY" ]; then
        echo "HTTPS_PROXY   = $HTTPS_PROXY"
    else
        echo "HTTPS_PROXY   = (未设置)"
    fi

    if [ -n "$ALL_PROXY" ]; then
        echo "ALL_PROXY     = $ALL_PROXY"
    else
        echo "ALL_PROXY     = (未设置)"
    fi

    if [ -n "$NO_PROXY" ]; then
        echo "NO_PROXY      = $NO_PROXY"
    else
        echo "NO_PROXY      = (未设置)"
    fi
    echo "----------------------------------------"
}

# 测试代理连接
proxy_test() {
    echo "测试代理连接..."
    if curl -s --max-time 5 --proxy "${HTTP_PROXY}" https://www.google.com > /dev/null 2>&1; then
        echo "✓ 代理连接正常"
        return 0
    else
        echo "✗ 代理连接失败"
        return 1
    fi
}

# Git 代理设置
proxy_git_on() {
    local proxy_host="${1:-${HTTP_PROXY#http://}}"
    proxy_host="${proxy_host:-127.0.0.1:6152}"

    git config --global http.proxy "http://${proxy_host}"
    git config --global https.proxy "http://${proxy_host}"
    echo "✓ Git 代理已设置: ${proxy_host}"
}

# Git 代理关闭
proxy_git_off() {
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    echo "✓ Git 代理已关闭"
}

# 帮助信息
proxy_help() {
    cat << 'EOF'
代理管理命令:
  proxy_on [host:port]     - 开启 HTTP/HTTPS 代理 (默认: 127.0.0.1:6152)
  proxy_socks [host:port]  - 开启 SOCKS5 代理 (默认: 127.0.0.1:1080)
  proxy_off                - 关闭所有代理
  proxy_status             - 查看当前代理状态
  proxy_test               - 测试代理连接
  proxy_git_on [host:port] - 为 Git 设置代理
  proxy_git_off            - 关闭 Git 代理
  proxy_help               - 显示此帮助信息

示例:
  proxy_on                      # 使用默认代理
  proxy_on 192.168.1.100:8080   # 使用自定义代理
  proxy_socks 127.0.0.1:1080    # 使用 SOCKS5 代理
  proxy_status                  # 查看状态
  proxy_off                     # 关闭代理
EOF
}

# 注意：运行 'proxy_help' 命令查看使用帮助
