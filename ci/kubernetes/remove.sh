#!/bin/sh

sudo kubeadm reset -f

# rm -rf ~/.kube
# rm -rf /etc/cni/net.d

ipvsadm -C
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X

sudo apt-get purge -y kubeadm kubectl kubelet kubernetes-cni kube*
sudo apt-get autoremove

sudo rm -rf ~/.kube
# sudo rm -rf /etc/kubernetes/
# sudo rm -rf /var/lib/kube*
