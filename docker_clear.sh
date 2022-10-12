#!/bin/sh

sudo du -hs /var/lib/docker

docker system df

docker system prune

# docker system prune -a

# docker volume rm $(docker volume ls -q)
# docker volume ls
