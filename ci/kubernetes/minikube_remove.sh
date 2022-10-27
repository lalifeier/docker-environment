#!/bin/sh

sudo minikube stop
sudo minikube delete --purge=true --all=true

# docker stop (docker ps -aq)
# rm -r ~/.kube ~/.minikube
# sudo rm /usr/local/bin/localkube /usr/local/bin/minikube
# systemctl stop '*kubelet*.mount'
# sudo rm -rf /etc/kubernetes/
# docker system prune -af --volumes
