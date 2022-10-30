#!/bin/sh

# curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# wget https://get.helm.sh/helm-v3.9.3-linux-amd64.tar.gz
wget https://repo.huaweicloud.com/helm/v3.9.3/helm-v3.9.3-linux-amd64.tar.gz
tar -zxvf helm-v3.9.3-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm

# helm repo remove stable

helm repo add elastic https://helm.elastic.co
helm repo add gitlab https://charts.gitlab.io
helm repo add harbor https://helm.goharbor.io
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add traefik https://helm.traefik.io/traefik
helm repo add incubator https://charts.helm.sh/incubator
# helm repo add incubator http://mirror.azure.cn/kubernetes/charts-incubator
helm repo add stable https://charts.helm.sh/stable
# helm repo add stable http://mirror.azure.cn/kubernetes/charts
# stop update
# helm repo add aliyun https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts
helm repo update

# helm repo list
# helm search repo stable
# helm repo remove aliyun
