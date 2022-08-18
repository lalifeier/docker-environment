#!/bin/sh

kubectl create namespace kube-logging

helm repo add elastic https://helm.elastic.co
helm repo update

# elasticsearch
helm install elasticsearch elastic/elasticsearch -n kube-logging

# kibana
helm install kibana elastic/kibana -n kube-logging

kubectl get pods -n kube-logging

# fluentd
# https://hub.docker.com/r/fluent/fluentd-kubernetes-daemonset
