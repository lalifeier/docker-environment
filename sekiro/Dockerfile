ARG APP_PATH=/app

FROM maven:3.8.4-openjdk-8-slim AS build

ARG APP_PATH
WORKDIR $APP_PATH

RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/mirrors.aliyun.com/' /etc/apt/sources.list && \
    sed -i 's/security-cdn.debian.org/mirrors.aliyun.com/' /etc/apt/sources.list && \
    apt update && \
    apt install -y git zip && \
    git clone --depth 1 https://github.com/yint-tech/sekiro-open && \
    cd sekiro-open && \
    sh ./build_demo_server.sh

FROM openjdk:8-jdk-alpine

ARG APP_PATH
WORKDIR $APP_PATH

COPY --from=build $APP_PATH/sekiro-open/target/sekiro-open-demo $APP_PATH/sekiro-open-demo

ENTRYPOINT ["sh","./sekiro-open-demo/bin/sekiro.sh"]
