#!/bin/sh

# https://signoz.io/docs/install/docker/
git clone -b main https://github.com/SigNoz/signoz.git && cd signoz/deploy/

docker-compose -f docker/clickhouse-setup/docker-compose.yaml up -d

# http://localhost:3301
