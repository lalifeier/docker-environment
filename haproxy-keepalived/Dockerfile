FROM haproxy:alpine

LABEL maintainer="lalifeier <lalifeier@gmail.com>"

USER root

ENV TIME_ZONE=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk update && apk upgrade && \
    apk add --no-cache bash curl ipvsadm iproute2 openrc keepalived && \
    rm -f /var/cache/apk/* /tmp/*

COPY entrypoint.sh /etc/keepalived/entrypoint.sh

RUN chmod +x /etc/keepalived/entrypoint.sh

CMD ["/etc/keepalived/entrypoint.sh"]

# CMD /usr/sbin/keepalived -f /etc/keepalived/keepalived.conf
