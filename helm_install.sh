#!/bin/sh

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# helm repo remove stable
# helm repo add stable https://charts.helm.sh/stable
helm repo add stable http://mirror.azure.cn/kubernetes/charts
helm repo add aliyun https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts
helm repo update

# helm repo list
# helm search repo stable
# helm repo remove aliyun
