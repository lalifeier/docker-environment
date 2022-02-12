#!/bin/sh

docker cp php:/usr/local/etc/php-fpm.d/www.conf.default conf/php-fpm.d/www.conf
docker cp php:/usr/local/etc/php/php.ini-production conf/php.ini
