#!/bin/bash

cd ${KE_HOME}
sed -i "s/ZKSERVER/${ZKSERVER}/g" ./conf/system-config.properties
mkdir -p ./db/
chmod +x ./bin/ke.sh
sh ./bin/ke.sh start
tail -f ./logs/log.log
