FROM openjdk:8-jre-alpine

LABEL maintainer="lalifeier <lalifeier@gmail.com>"

ENV TIME_ZONE=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

WORKDIR /opt/canal/adapter

ADD https://github.com/alibaba/canal/releases/download/canal-1.1.6/canal.adapter-1.1.6.tar.gz ./

RUN tar -xzvf canal.adapter-1.1.6.tar.gz && \
    rm -rf canal.adapter-1.1.6.tar.gz

ENTRYPOINT ["sh", "-c", "sh bin/startup.sh && tail -F logs/adapter/adapter.log"]
