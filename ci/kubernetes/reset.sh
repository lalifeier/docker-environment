#!/bin/sh

sudo kubeadm reset -f

# sudo rm -rf /etc/cni /etc/kubernetes /var/lib/dockershim /var/lib/etcd /var/lib/kubelet /var/run/kubernetes ~/.kube/*

rm -rf ~/.kube
rm -rf /etc/cni/net.d

ipvsadm -C
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X

# sudo systemctl restart docker
