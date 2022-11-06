#!/bin/sh

# k3d registry create docker-io `# Create a registry named k3d-docker-io` \
#   -p 5000 `# listening on local host port 5000` \
#   --proxy-remote-url https://registry-1.docker.io `# let it mirror the Docker Hub registry` \
#   -v ~/.local/share/docker-io-registry:/var/lib/registry `# also persist the downloaded images on the device outside the container`

# k3d cluster create dev \
#   --registry-use k3d-docker-io:5000 \
#   --registry-config registry.yml \
#   --port 8080:80@loadbalancer \
#   --port 8443:443@loadbalancer \
#   --api-port 6443 \
#   --servers 1 \
#   --agents 3 \
#   --k3s-arg "--disable=traefik@server:0"

k3d cluster create dev \
  --registry-config registry.yml \
  --port 8080:80@loadbalancer \
  --port 8443:443@loadbalancer \
  --api-port 6443 \
  --servers 1 \
  --agents 3 \
  --k3s-arg "--disable=traefik@server:0"
