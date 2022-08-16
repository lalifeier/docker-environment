#!/bin/sh

kubectl create ns kubernetes-dashboard
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout dashboard.key -out dashboard.crt -subj "/C=CN/ST=ShangHai/L=ShangHai/O=Lalifeier/OU=Lalifeier/CN=*.domain.com"
kubectl create secret tls kubernetes-dashboard-certs --cert=dashboard.crt --key=dashboard.key -n kubernetes-dashboard

# https
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/recommended.yaml
# http
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/alternative.yaml

# token
kubectl apply -f dashboard/dashboard-admin.yaml
kubectl apply -f dashboard/dashboard-read-only.yaml

# kubectl delete -f dashboard-admin.yaml
# kubectl delete -f dashboard-read-only.yaml

# kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')

kubectl create -f dashboard-ingress.yaml
kubectl get ingress -n kubernetes-dashboard

# API Server
# https://<master-ip>:<apiserver-port>/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

# kubectl proxy
# kubectl proxy --address=0.0.0.0
# http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

# kubectl port-forward
# pod
# kubectl --namespace ${NAMESPACE} port-forward $POD_NAME {local_port}:{pod_port} --address 0.0.0.0
# svc
# kubectl --namespace ${NAMESPACE} port-forward svc/$SERVICE_NAME {local_port}:{svc_port} --address 0.0.0.0

# kubectl --namespace kubernetes-dashboard port-forward svc/kubernetes-dashboard 8443:443 --address 0.0.0.0

# NodePort
# kubectl -n kubernetes-dashboard edit service kubernetes-dashboard
# sed -i '/targetPort: 8443/a\ \ \ \ \ \ nodePort: 31707\n\ \ type: NodePort' recommended.yaml
# kubectl -n kubernetes-dashboard get service kubernetes-dashboard
