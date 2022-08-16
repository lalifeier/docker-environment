#!/bin/sh

# https://kubernetes.io/docs/tasks/administer-cluster/certificates

mkdir certs
cd certs
# openssl genrsa -out dashboard.key 2048
# openssl req -new -key dashboard.key -out dashboard.csr
# openssl x509 -req -sha256 -days 365 -in dashboard.csr -signkey dashboard.key -out dashboard.crt

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout dashboard.key -out dashboard.crt -subj "/CN=dk8s-dashboard.domain.com/O=dk8s-dashboard.domain.com"


kubectl create ns kubernetes-dashboard
# kubectl delete secret kubernetes-dashboard-certs -n kubernetes-dashboard
# kubectl -n kubernetes-dashboard create secret generic kubernetes-dashboard-certs --from-file=dashboard.key --from-file=dashboard.crt
kubectl create secret tls kubernetes-dashboard-certs --cert=dashboard.crt --key=dashboard.key -n kubernetes-dashboard

# kubectl -n kubernetes-dashboard create secret tls kubernetes-dashboard-certs --cert=dashboard.crt --key=dashboard.key --dry-run -o yaml |kubectl apply  -f -


kubectl get secrets -n kubernetes-dashboard
kubectl describe secret -n kubernetes-dashboard kubernetes-dashboard-certs
