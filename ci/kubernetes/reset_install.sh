#!/bin/sh
# set -ex

sudo kubeadm reset -f

sudo rm -rf $HOME/.kube
sudo rm -rf /etc/cni/net.d
sudo rm -rf /var/run/flannel

ifconfig cni0 down && ip link delete cni0
ifconfig flannel.1 down && ip link delete flannel.1
sudo rm -rf /var/lib/cni

# ipvsadm -C

sudo iptables -F && sudo iptables -t nat -F && sudo iptables -t mangle -F && sudo iptables -X

sudo systemctl restart containerd

# calico
# sudo kubeadm init \
#     --image-repository registry.aliyuncs.com/google_containers \
#     --pod-network-cidr 192.168.0.0/16 \
#     --token-ttl 0


# flannel
sudo kubeadm init \
    --image-repository registry.aliyuncs.com/google_containers \
    --pod-network-cidr 10.244.0.0/16 \
    --token-ttl 0


mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# kube-router
# kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter.yaml
# kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter-all-features.yaml

kubectl taint nodes --all node-role.kubernetes.io/control-plane- node-role.kubernetes.io/master-
# kubectl taint nodes --all node-role.kubernetes.io/control-plane-
