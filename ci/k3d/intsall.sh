#!/bin/sh

# https://k3d.io

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/kubectl

curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
# brew install k3d

# k3d cluster create devcluster

# k3d cluster create devcluster \
# --api-port 127.0.0.1:6443 \
# -p 80:80@loadbalancer \
# -p 443:443@loadbalancer \
# --k3s-server-arg "--no-deploy=traefik"

# k3d cluster create devcluster --servers 1 --agents 3 --api-port 127.0.0.1:6443 -p 80:80@loadbalancer -p 443:443@loadbalancer --k3s-arg "--disable=traefik@server:0"
k3d cluster create devcluster --servers 1 --agents 3 --k3s-arg "--disable=traefik@server:0"

# docker pull rancher/k3s:v1.24.4-k3s1
# wget https://github.com/k3s-io/k3s/releases/download/v1.24.4-k3s1/k3s-airgap-images-amd64.tar.gz
# tar -zxvf k3s-airgap-images-amd64.tar.gz -C ~/airgap
# k3d create -n k3s-local -i rancher/k3s:v1.24.4-k3s1  -v $(pwd)/airgap/v1.24.4/:/var/lib/rancher/k3s/agent/images/

kubectl get nodes

# 获取凭证
# mkdir -p $HOME/k3d
# k3d kubeconfig get devcluster > $HOME/k3d/kubeconfig
# export KUBECONFIG=$HOME/k3d/kubeconfig

# kubectl cluster-info

# helm repo add traefik https://helm.traefik.io/traefik
# helm repo add traefik https://containous.github.io/traefik-helm-chart
# helm install traefik traefik/traefik
# kubectl port-forward $(kubectl get pods --selector "app.kubernetes.io/name=traefik" --output=name) --address 0.0.0.0 9000:9000
# http://localhost:9000/dashboard/


# kubecm
# brew install kubecm

# curl -Lo kubecm.tar.gz https://github.com/sunny0826/kubecm/releases/download/v${VERSION}/kubecm_${VERSION}_Linux_x86_64.tar.gz
# tar -zxvf kubecm.tar.gz kubecm
# cd kubecm
# sudo mv kubecm /usr/local/bin/

# kubecm add -f $(k3d get-kubeconfig --name='k3s-local') -n k3s -c
# kubecm s


# k3d cluster delete devcluster
