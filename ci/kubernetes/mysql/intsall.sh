#!/bin/sh

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm search repo mysql

helm show values bitnami/mysql > mysql.yaml-default

# - mysql-standalone.yaml
helm install mysql-standalone bitnami/mysql \
    -f mysql-standalone.yaml \
    -n kube-server \
    --create-namespace \
    --version 8.9.2 --debug

helm upgrade --install mysql-standalone bitnami/mysql \
    -f mysql-standalone.yaml \
    -n kube-server \
    --create-namespace \
    --version 8.9.2 --debug

helm -n kube-server uninstall mysql-standalone

# - mysql-replication.yaml
helm install mysql-replication bitnami/mysql \
    -f mysql-replication.yaml \
    -n kube-server \
    --create-namespace \
    --version 8.9.2 --debug

helm upgrade --install mysql-replication bitnami/mysql \
    -f mysql-replication.yaml \
    -n kube-server \
    --create-namespace \
    --version 8.9.2 --debug

helm -n kube-server uninstall mysql-replication
