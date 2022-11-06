#!/bin/sh


export CLIENTNAME=lalifeier
export OVPN_DATA=/data/openvpn

# 生成配置文件
docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u udp://<IP>
# 生成密钥文件
docker run -v $OVPN_DATA:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki

# 生成客户端证书
docker run -v $OVPN_DATA:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full $CLIENTNAME nopass

# 导出客户端配置
docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient $CLIENTNAME > $OVPN_DATA/conf/$CLIENTNAME.ovpn
