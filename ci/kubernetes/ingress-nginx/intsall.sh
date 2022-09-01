#!/bin/sh

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm search repo ingress-nginx

helm show values ingress-nginx/ingress-nginx > ingress-nginx.yaml-default

kubectl label no k-kube-lab-11 edge=external
# kubectl cordon k-kube-lab-11
helm install ingress-nginx-external-controller ingress-nginx/ingress-nginx \
    -f ingress-nginx-external.yaml \
    -n kube-server \
    --create-namespace \
    --version 4.0.13 --debug

kubectl label no k-kube-lab-12 edge=internal
# kubectl cordon k-kube-lab-12
helm install ingress-nginx-internal-controller ingress-nginx/ingress-nginx \
    -f ingress-nginx-internal.yaml \
    -n kube-server \
    --version 4.0.13 --debug

helm list -A

# upgrade
helm upgrade ingress-nginx-external-controller ingress-nginx/ingress-nginx \
    -f ingress-nginx-external.yaml \
    -n kube-server \
    --version 4.0.13 --debug

helm upgrade ingress-nginx-internal-controller ingress-nginx/ingress-nginx \
    -f ingress-nginx-internal.yaml \
    -n kube-server \
    --version 4.0.13 --debug

# uninstall
helm -n kube-server uninstall ingress-nginx-external-controller

# helm install ingress-nginx ingress-nginx/ingress-nginx \
#     -n kube-server \
#     --create-namespace
