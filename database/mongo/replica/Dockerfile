# docker build -t mongo-replset .

FROM mongo:5.7

LABEL maintainer="lalifeier <lalifeier@gmail.com>"

ENV TIME_ZONE=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

COPY .conf/keyFile.key /data/configdb/keyFile.key
RUN chmod 400 /data/configdb/keyFile.key
RUN chown -R mongodb:mongodb /data/configdb/keyFile.key
