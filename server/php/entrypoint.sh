#!/bin/sh

/usr/sbin/sshd -D & nginx & php-fpm
