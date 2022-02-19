FROM java:8-alpine

LABEL maintainer="lalifeier <lalifeier@gmail.com>"

ENV TIME_ZONE=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

ENV KE_HOME=/opt/kafka-eagle
ENV EAGLE_VERSION=2.1.0
ENV PATH=$PATH:$KE_HOME/bin

WORKDIR /opt/kafka-eagle

COPY system-config.properties ./conf/system-config.properties
COPY entrypoint.sh ./bin/entrypoint.sh/

RUN apk update && \
    apk add curl sqlite && \
    curl -OL "https://mirror.ghproxy.com/https://github.com/smartloli/kafka-eagle-bin/archive/v${EAGLE_VERSION}.tar.gz" && \
    tar -xzvf v${EAGLE_VERSION}.tar.gz && \
    tar -xzvf kafka-eagle-bin-${EAGLE_VERSION}/efak-web-${EAGLE_VERSION}-bin.tar.gz && \
    mv efak-web-${EAGLE_VERSION} /opt/kafka-eagle && \
    rm -rf $v{EAGLE_VERSION}.tar.gz kafka-eagle-bin-${EAGLE_VERSION}

CMD ["sh", "/opt/kafka-eagle/bin/entrypoint.sh"]
