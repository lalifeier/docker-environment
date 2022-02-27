#!/bin/sh
set -e

/usr/local/sbin/haproxy -f /usr/local/etc/haproxy/haproxy.cfg

# /usr/sbin/keepalived --dont-fork --dump-conf --log-console --log-detail --log-facility 7 --vrrp -f /etc/keepalived/keepalived.conf

/usr/sbin/keepalived -n -l -D -f /etc/keepalived/keepalived.conf --dont-fork --log-console
# /usr/sbin/keepalived -D -f /etc/keepalived/keepalived.conf
