#!/bin/sh

docker run --name tmp-clickhouse-server -d yandex/clickhouse-server:latest
docker cp tmp-clickhouse-server:/etc/clickhouse-server/config.xml conf/config.xml
docker cp tmp-clickhouse-server:/etc/clickhouse-server/users.xml conf/users.xml
docker rm -f tmp-clickhouse-server
