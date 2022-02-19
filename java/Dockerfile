FROM openjdk:8-jdk-alpine

LABEL maintainer="lalifeier <lalifeier@gmail.com>"

ENV TIME_ZONE=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# RUN apk add --no-cache curl tar bash procps

ENV MAVEN_VERSION 3.8.4
ENV MAVEN_HOME /usr/local/mvn
ENV PATH $MAVEN_HOME/bin:$PATH

RUN wget https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
 tar -xzf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
 rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
 mv apache-maven-$MAVEN_VERSION  /usr/local/mvn
