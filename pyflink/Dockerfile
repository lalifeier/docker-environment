FROM flink:latest

ARG FLINK_VERSION=1.14.4

LABEL maintainer="lalifeier <lalifeier@gmail.com>"

ENV TIME_ZONE=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

RUN set -ex && \
    sed -i 's/deb.debian.org/mirrors.aliyun.com/' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/mirrors.aliyun.com/' /etc/apt/sources.list && \
    sed -i 's/security-cdn.debian.org/mirrors.aliyun.com/' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev libffi-dev && \
    wget https://www.python.org/ftp/python/3.8.13/Python-3.8.13.tgz && \
    tar -xvf Python-3.8.13.tgz && \
    cd Python-3.8.13 && \
    ./configure --without-tests --enable-shared && \
    make -j6 && \
    make install && \
    ldconfig /usr/local/lib && \
    cd .. && rm -f Python-3.8.13.tgz && rm -rf Python-3.8.13 && \
    ln -s /usr/local/bin/python3 /usr/local/bin/python && \
    ln -s /usr/local/bin/pip3 /usr/local/bin/pip && \
    python -m pip install --upgrade pip && \
    pip config set global.index-url https://mirrors.aliyun.com/pypi/simple && \
	  pip config set install.trusted-host mirrors.aliyun.com && \
    pip install apache-flink==${FLINK_VERSION} && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

  # echo "taskmanager.memory.jvm-metaspace.size: 512m" >> /opt/flink/conf/flink-conf.yaml; \
  # echo "rest.port: 4000" >> /opt/flink/conf/flink-conf.yaml; \
  # echo "metrics.reporters: prom" >> /opt/flink/conf/flink-conf.yaml; \
  # echo "metrics.reporter.prom.class: org.apache.flink.metrics.prometheus.PrometheusReporter" >> /opt/flink/conf/flink-conf.yaml; \
  # echo "metrics.reporter.prom.port: 9249,9250" >> /opt/flink/conf/flink-conf.yaml
