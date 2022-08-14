#!/bin/sh

# https
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/recommended.yaml
# http
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/alternative.yaml

# token
kubectl apply -f dashboard-admin.yaml
kubectl apply -f dashboard-read-only.yaml

# kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')

# kubectl delete -f dashboard-admin.yaml
# kubectl delete -f dashboard-read-only.yaml

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


# ingress
# mkdir certs
# cd certs
# openssl genrsa -out dashboard.key 2048
# openssl req -new -key dashboard.key -out dashboard.csr
# openssl x509 -req -sha256 -days 365 -in dashboard.csr -signkey dashboard.key -out dashboard.crt

# kubectl -n kubernetes-dashboard create secret generic kubernetes-dashboard-certs --from-file=dashboard.key --from-file=dashboard.crt

# kubectl -n kubernetes-dashboard create secret tls kubernetes-dashboard-certs1 --cert=certs/tls.crt --key=certs/tls.key
# mkdir certs
# openssl req -nodes -newkey rsa:2048 -keyout certs/dashboard.key -out certs/dashboard.csr -subj "/C=/ST=/L=/O=/OU=/CN=kubernetes-dashboard"
# openssl x509 -req -sha256 -days 10000 -in certs/dashboard.csr -signkey certs/dashboard.key -out certs/dashboard.crt
# kubectl create secret generic kubernetes-dashboard-certs --from-file=certs -n kube-system
