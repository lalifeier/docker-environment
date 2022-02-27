#!/bin/bash

# 判断haproxy是否已经启动
if [ `ps -C haproxy --no-header |wc -l` -eq 0 ] ; then
    #如果没有启动，则启动
    systemctl start haproxy

    #睡眠3秒以便haproxy完全启动
    sleep 3

    #如果haproxy还是没有启动，此时需要将本机的keepalived服务停掉，以便让VIP自动漂移到另外一台haproxy
    if [ `ps -C haproxy --no-header |wc -l` -eq 0 ] ; then
        systemctl stop keepalived
    fi
fi
