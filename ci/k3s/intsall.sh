#!/bin/sh

# https://k3s.io

curl -sfL https://get.k3s.io | sh -
# Check for Ready node, takes ~30 seconds
k3s kubectl get node

# echo "alias kubectl='k3s kubectl'" >> ~/.zshrc
# source ~/.zshrc

# cluster
# join a worker node
# K3S_TOKEN
# cat /var/lib/rancher/k3s/server/node-token

curl -sfL https://get.k3s.io | K3S_URL=https://myserver:6443 K3S_TOKEN=mynodetoken sh -


# uninstall
# server node
# /usr/local/bin/k3s-uninstall.sh
# agent node
# /usr/local/bin/k3s-agent-uninstall.sh
