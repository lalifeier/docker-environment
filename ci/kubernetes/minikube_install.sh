#!/bin/sh


curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
# curl -Lo minikube https://kubernetes.oss-cn-hangzhou.aliyuncs.com/minikube/releases/v1.13.0/minikube-linux-amd64
# sudo install minikube-linux-amd64 /usr/local/bin/minikube
chmod +x minikube
sudo mv minikube /usr/local/bin/

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
# curl -LO http://kubernetes.oss-cn-hangzhou.aliyuncs.com/kubernetes-release/release/`curl -s http://kubernetes.oss-cn-hangzhou.aliyuncs.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/kubectl

# Exiting due to GUEST_MISSING_CONNTRACK: Sorry, Kubernetes 1.20.2 requires conntrack to be installed in root's path
# sudo apt-get install -y conntrack

#  minikube start --force --driver=docker
minikube start --image-repository registry.cn-hangzhou.aliyuncs.com/google_containers --force --driver=docker --delete-on-failure

# minikube config set vm-driver none

# minikube dashboard &


# Exiting due to HOST_HOME_PERMISSION: Failed to save config: open /home/dennislwm/.minikube/profiles/minikube/config.json: permission denied
# sudo chown -R $USER $HOME/.minikube; chmod -R u+wrx $HOME/.minikube

# Exiting due to GUEST_DRIVER_MISMATCH: The existing "minikube" cluster was created using the "none" driver, which is incompatible with requested "docker" driver.
# sudo minikube delete --purge=true --all=true


minikube addons list
minikube addons enable ingress
