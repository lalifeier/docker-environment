#!/bin/sh

export IP=127.0.0.1 # 主机 IP，用于访问 Zadig 系统
export PORT=30001 # 随机填写 30000 - 32767 区间的任一端口，如果安装过程中，发现端口占用，换一个端口再尝试
curl -SsL https://github.com/koderover/zadig/releases/latest/download/all_in_one_install_quickstart.sh | bash
# curl -SsL https://download.koderover.com/install?type=all-in-one | bash
