#!/bin/sh

kubectl create ns kube-monitor

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus-stack prometheus-community/kube-prometheus-stack -n kube-monitor

kubectl get all -n kube-monitor

# http://127.0.0.1:9090
kubectl port-forward -n kube-monitor prometheus-prometheus-stack-kube-prom-prometheus-0 9090

# http://127.0.0.1:3000 admin prom-operator
kubectl port-forward -n kube-monitor prometheus-stack-grafana-5b6dd6b5fb-rtp6z 3000

# kubectl get secret prometheus-stack-grafana -n kube-monitor -o jsonpath='{.data}'

# admin-user
kubectl get secret prometheus-stack-grafana -n kube-monitor -o jsonpath='{.data.admin-user}' | base64 --decode
# admin-password
kubectl get secret prometheus-stack-grafana -n kube-monitor -o jsonpath='{.data.admin-password}' | base64 --decode

# http://127.0.0.1:8080/metrics
kubectl port-forward -n kube-monitor prometheus-stack-kube-state-metrics-c7c69c8c9-bhgjv 8080
