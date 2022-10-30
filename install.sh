#!/bin/sh

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh --mirror Aliyun

# Docker mirror
cat <<EOF | sudo tee /etc/docker/daemon.json
{
    "registry-mirrors": [
        "https://1nj0zren.mirror.aliyuncs.com",
        "https://dockerhub.azk8s.cn",
        "https://docker.mirrors.ustc.edu.cn",
        "http://f1361db2.m.daocloud.io",
        "https://hub-mirror.c.163.com",
        "https://mirror.baidubce.com",
        "https://registry.docker-cn.com"
    ],
    "host": ["tcp://0.0.0.0:2375"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker

# Install Docker Compose
sudo curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# sudo groupadd docker

# Allow current user to run Docker commands
sudo usermod -aG docker $USER


# export COMPOSE_PROJECT_NAME=docker-environment
# export COMPOSE_FILE=~/opt/docker-environment/docker-compose.yml


# docker network create app_net

# docker开通2375端口
# sudo vim /usr/lib/systemd/system/docker.service
# 增加 -H tcp://0.0.0.0:2375
# ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H fd:// --containerd=/run/containerd/containerd.sock
# sudo systemctl daemon-reload
# sudo systemctl restart docker
