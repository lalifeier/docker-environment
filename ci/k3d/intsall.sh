#!/bin/sh

# https://k3d.io

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/kubectl

curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
# brew install k3d

# k3d cluster create mycluster
wget https://github.com/k3s-io/k3s/releases/download/v1.24.4-k3s1/k3s-airgap-images-amd64.tar.gz
tar -zxvf k3s-airgap-images-amd64.tar.gz -C ~/airgap
k3d create -n k3s-local -i rancher/k3s:v1.24.4-k3s1  -v $(pwd)/airgap/v1.24.4/:/var/lib/rancher/k3s/agent/images/

kubectl get nodes


# k3d cluster delete mycluster
