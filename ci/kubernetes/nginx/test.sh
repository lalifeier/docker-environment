#!/bin/sh


kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/cloud/deploy.yaml

kubectl get pods --namespace=ingress-nginx

kubectl create deployment demo --image=nginx --port=80
kubectl expose deployment demo

kubectl create ingress demo-localhost --class=nginx --rule="demo.localdev.me/*=demo:80"

kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 80:80 --address 0.0.0.0

echo '127.0.0.1 demo.localdev.me' >> /etc/hosts

# kubectl delete ingress demo
# kubectl delete service demo
# kubectl delete deployment demo

# kubectl --namespace kube-server get services -o wide -w ingress-nginx-controller
