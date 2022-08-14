#!/bin/sh

# https://doc.traefik.io/traefik/getting-started/install-traefik
helm repo add traefik https://helm.traefik.io/traefik
helm repo update
helm install traefik traefik/traefik
