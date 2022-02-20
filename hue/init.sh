#!/bin/sh

docker run --name tmp-hue -d gethue/hue
docker cp tmp-hue:/usr/share/hue/desktop/conf/hue.ini hue.ini
docker rm -f tmp-hue
