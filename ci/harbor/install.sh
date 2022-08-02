#!/bin/sh
set -e

wget https://github.com/goharbor/harbor/releases/download/v2.5.3/harbor-offline-installer-v2.5.3.tgz
sudo tar -zxvf harbor-offline-installer-v2.5.3.tgz -C /usr/local

cd /usr/local/harbor
sudo cp harbor.yml.tmpl harbor.yml

sudo ./install.sh
