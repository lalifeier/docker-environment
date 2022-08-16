#!/bin/sh

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/cloud/deploy.yaml

# helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
# helm repo update

# helm search repo ingress-nginx

# helm show values ingress-nginx/ingress-nginx > ingress-nginx.yaml

# helm install ingress-nginx ingress-nginx/ingress-nginx \
#     -f ingress-nginx.yaml \
#     -n kube-server \
#     --create-namespace
