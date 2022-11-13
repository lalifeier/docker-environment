FROM openjdk:8-jre-alpine

LABEL maintainer="lalifeier <lalifeier@gmail.com>"

ENV TIME_ZONE=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

ADD https://github.com/alibaba/canal/releases/download/canal-1.1.6/canal.adapter-1.1.6.tar.gz /opt/canal/adapter/

# RUN apk update && \
#     apk add curl && \
#     mkdir -p /opt/canal/adapter && \
#     curl -OL https://github.com/alibaba/canal/releases/download/canal-1.1.6/canal.adapter-1.1.6.tar.gz && \
#     tar -xzvf canal.adapter-1.1.6.tar.gz -C /opt/canal/adapter

WORKDIR /opt/canal/adapter

ENTRYPOINT ["sh", "-c", "sh bin/startup.sh && tail -F logs/adapter/adapter.log"]
