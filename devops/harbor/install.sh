#!/bin/sh
set -e

wget https://github.com/goharbor/harbor/releases/download/v2.2.0/harbor-offline-installer-v2.2.0.tgz
tar -zxvf harbor-offline-installer-v1.10.4-rc1.tgz -C /usr/local/harbor

cd /usr/local/harbor
cp harbor.yml.tmpl harbor.yml

sudo ./install.sh
