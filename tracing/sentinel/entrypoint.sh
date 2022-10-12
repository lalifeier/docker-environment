#!/bin/sh
set -e

java -Dserver.port=8858 -Dcsp.sentinel.dashboard.server=localhost:8858 -Dproject.name=sentinel-dashboard -jar $SENTINEL_HOME/sentinel-dashboard.jar