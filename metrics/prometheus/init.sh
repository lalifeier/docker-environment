#!/bin/sh

docker run --name tmp-prometheus -d bitnami/prometheus:latest
docker cp tmp-prometheus:/etc/prometheus/prometheus.yml $PWD
docker rm -f tmp-prometheus
