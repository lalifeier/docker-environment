#!/bin/sh

# 关闭swap
# 临时修改
sudo swapoff  -a
# 永久修改
sudo sed -ri 's/.*swap.*/#&/' /etc/fstab

# 设置主机名
hostnamectl set-hostname master

# 同步时间
# sudo apt install ntpdate
# sudo ntpdate cn.pool.ntp.org
# sudo hwclock --systohc

# 将桥接的IPV4流量传递到iptables
# sudo modprobe br_netfilter
# echo '1' | sudo tee -a /proc/sys/net/ipv4/ip_forward
# echo '1' | sudo tee -a /proc/sys/net/bridge/bridge-nf-call-iptables
# echo '1' | sudo tee -a /proc/sys/net/bridge/bridge-nf-call-ip6tables
# sudo sysctl -p
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

# [ERROR CRI]: container runtime is not running
# rpc error: code = Unimplemented desc = unknown service runtime.v1alpha2.RuntimeService
# sudo rm /etc/containerd/config.toml
# systemctl restart containerd

# error execution phase wait-control-plane: couldn't initialize a Kubernetes cluste
# cat <<EOF | sudo tee /etc/docker/daemon.json
# {
#   "exec-opts": ["native.cgroupdriver=systemd"],
#   "log-driver": "json-file",
#   "log-opts": {
#     "max-size": "100m"
#   },
#   "storage-driver": "overlay2",
#   "storage-opts": [
#     "overlay2.override_kernel_check=true"
#   ],
#   "data-root": "/data/docker",
#   "registry-mirrors": ["http://f1361db2.m.daocloud.io"]
# }
# EOF
# sudo systemctl daemon-reload
# sudo systemctl restart docker

# kubeadm
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

# Update the apt package index and install packages needed to use the Kubernetes apt repository
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl

# Download the Google Cloud public signing key
# sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
curl -s https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add -

# Add the Kubernetes apt repository:
# echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
cat << EOF | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt kubernetes-xenial main
EOF

# Update apt package index, install kubelet, kubeadm and kubectl, and pin their version
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# systemctl enable kubelet

sudo kubeadm init \
    --image-repository registry.aliyuncs.com/google_containers \
    --pod-network-cidr 192.168.0.0/16 \
    --token-ttl 0

# sudo kubeadm init \
#     --image-repository registry.aliyuncs.com/google_containers \
#     # --apiserver-advertise-address 0.0.0.0 \
#     # --apiserver-bind-port 6443 \
#     # --service-cidr 10.96.0.0/12 \
#     --pod-network-cidr 192.168.0.0/16 \
#     --token-ttl 0

# kubeadm config print init-defaults > kubeadm-init.yaml

# advertiseAddress:
# imageRepository: registry.aliyuncs.com/google_containers

# kubeadm config images pull --config kubeadm-init.yaml
# kubeadm init --config kubeadm-config.yaml

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# kubectl completion zsh
# echo 'source <(kubectl completion bash)' >> ~/.bashrc
# source ~/.bashrc

# Calico
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

# Flannel
# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# kubectl taint nodes --all node-role.kubernetes.io/control-plane- node-role.kubernetes.io/master-

# Dashboard
# https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/#deploying-the-dashboard-ui
# https
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/recommended.yaml
# http
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/alternative.yaml

# kubectl apply -f dashboard-admin.yaml
# kubectl -n kubernetes-dashboard create token admin-user

# kubectl delete -f dashboard-admin.yaml
# kubectl delete -f dashboard-read-only.yaml

# kubectl proxy --address='0.0.0.0' --accept-hosts='^*$'



# kubectl -n kubernetes-dashboard edit service kubernetes-dashboard
# sed -i '/targetPort: 8443/a\ \ \ \ \ \ nodePort: 31707\n\ \ type: NodePort' recommended.yaml
