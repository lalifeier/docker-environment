#!/bin/sh

# kubeadm
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

# Update the apt package index and install packages needed to use the Kubernetes apt repository
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl

# Download the Google Cloud public signing key
# sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
curl -s https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -

# Add the Kubernetes apt repository:
# echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
cat > /etc/apt/sources.list.d/kubernetes.list <<EOF
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

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# kubectl completion zsh
# echo 'source <(kubectl completion bash)' >> ~/.bashrc
# source ~/.bashrc

# Calico
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

# kubectl taint nodes --all node-role.kubernetes.io/control-plane- node-role.kubernetes.io/master-

# Dashboard
# https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/#deploying-the-dashboard-ui
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/recommended.yaml

# kubectl apply -f dashboard-admin.yaml
# kubectl -n kubernetes-dashboard create token admin-user

# kubectl delete -f dashboard-admin.yaml
# kubectl delete -f dashboard-read-only.yaml

# kubectl proxy --address='0.0.0.0' --accept-hosts='^*$'



# kubectl -n kubernetes-dashboard edit service kubernetes-dashboard
# sed -i '/targetPort: 8443/a\ \ \ \ \ \ nodePort: 31707\n\ \ type: NodePort' recommended.yaml
