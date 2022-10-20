#!/bin/sh

openssl rand -base64 756 > ./conf/keyFile.key
chmod 400 ./conf/keyFile.key
