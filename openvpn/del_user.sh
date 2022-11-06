#!/bin/bash

read -p "Delete username: " CLIENTNAME

docker run -v /data/openvpn:/etc/openvpn --rm -it kylemanna/openvpn easyrsa revoke $CLIENTNAME
docker run -v /data/openvpn:/etc/openvpn --rm -it kylemanna/openvpn easyrsa gen-crl
docker run -v /data/openvpn:/etc/openvpn --rm -it kylemanna/openvpn rm -f /etc/openvpn/pki/reqs/"CLIENTNAME".req
docker run -v /data/openvpn:/etc/openvpn --rm -it kylemanna/openvpn rm -f /etc/openvpn/pki/private/"CLIENTNAME".key
docker run -v /data/openvpn:/etc/openvpn --rm -it kylemanna/openvpn rm -f /etc/openvpn/pki/issued/"CLIENTNAME".crt
docker restart openvpn
