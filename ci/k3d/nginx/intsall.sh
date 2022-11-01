#!/bin/sh

kubectl create deployment nginx --image=nginx

kubectl create service clusterip nginx --tcp=80:80

kubectl apply -f thatfile.yaml
