#!/bin/sh

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm search repo nginx

helm show values bitnami/nginx > nginx.yaml-default

helm install nginx  \
    -f nginx.yaml bitnami/nginx \
    -n kube-server \
    --create-namespace \
    --version 12.0.6 --debug

helm -n kube-server uninstall nginx
