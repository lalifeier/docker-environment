
#!/bin/sh


cd /usr/src
curl -O  https://www.openssl.org/source/openssl-3.0.5.tar.gz
tar zxvf openssl-3.0.5.tar.gz
cd /usr/src/openssl-3.0.1/
./config
make
make install
ldconfig /usr/local/lib64/
openssl version


# 生成私钥和证书签名请求
openssl genrsa -des3 -passout pass:over4chars -out dashboard.pass.key 2048
...
openssl rsa -passin pass:over4chars -in dashboard.pass.key -out dashboard.key
# Writing RSA key
rm dashboard.pass.key
openssl req -new -key dashboard.key -out dashboard.csr
...
Country Name (2 letter code) [AU]: US
...
A challenge password []:
...

# 生成 SSL 证书
openssl x509 -req -sha256 -days 365 -in dashboard.csr -signkey dashboard.key -out dashboard.crt
