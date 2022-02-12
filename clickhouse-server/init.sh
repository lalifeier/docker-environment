#!/bin/sh

docker cp clickhouse-server:/etc/clickhouse-server/config.xml conf/config.xml
docker cp clickhouse-server:/etc/clickhouse-server/users.xml conf/users.xml
