#!/bin/sh

sudo kubeadm reset -f

sudo rm -rf $HOME/.kube
sudo rm -rf /etc/cni/net.d
sudo rm -rf /var/run/flannel

ifconfig cni0 down && ip link delete cni0
ifconfig flannel.1 down && ip link delete flannel.1
sudo rm -rf /var/lib/cni

ipvsadm -C
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X

# sudo systemctl restart docker
