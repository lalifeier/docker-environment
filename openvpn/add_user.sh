#!/bin/bash

read -p "please your username: " CLIENTNAME

docker run -v /data/openvpn:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full $CLIENTNAME nopass
docker run -v /data/openvpn:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient $CLIENTNAME > /data/openvpn/conf/"$CLIENTNAME".ovpn
docker restart openvpn
