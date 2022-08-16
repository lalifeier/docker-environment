
#!/bin/sh

cd /usr/src
curl -O  https://www.openssl.org/source/openssl-3.0.5.tar.gz
tar zxvf openssl-3.0.5.tar.gz
cd /usr/src/openssl-3.0.5/
./config
make
make install
ldconfig /usr/local/lib64/
openssl version
