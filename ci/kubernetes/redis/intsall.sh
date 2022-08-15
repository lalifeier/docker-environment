#!/bin/sh

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm search repo redis

helm show values bitnami/redis > redis-sentinel.yaml-default

# redis-sentinel
helm install redis-sentinel bitnami/redis \
    -f redis-sentinel.yaml \
    -n kube-server \
    --create-namespace \
    --version 16.8.7 --debug

helm upgrade --install redis-sentinel bitnami/redis \
    -f redis-sentinel.yaml \
    -n kube-server \
    --create-namespace \
    --version 16.8.7 --debug

helm -n kube-server uninstall redis-sentinel

# redis-cluster
helm show values bitnami/redis-cluster > redis-cluster.yaml-default

helm install redis-cluster bitnami/redis-cluster \
    -f redis-cluster.yaml \
    -n kube-server \
    --create-namespace \
    --version 7.5.0 --debug

helm upgrade --install redis-cluster bitnami/redis-cluster \
    -f redis-cluster.yaml \
    -n kube-server \
    --create-namespace \
    --version 7.5.0 --debug

helm -n kube-server uninstall redis-cluster
