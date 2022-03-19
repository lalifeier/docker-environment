#!/bin/sh

docker run --name tmp-nginx -d nginx
docker cp tmp-nginx:/etc/nginx/conf.d/default.conf default.conf
docker rm -f tmp-nginx
