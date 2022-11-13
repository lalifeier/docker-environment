#!/bin/sh

# SHOW VARIABLES WHERE (Variable_name = 'log_bin'
# AND upper(Value) = 'ON')
# OR (Variable_name = 'binlog_format'
# AND upper(Value) = 'ROW')
# OR (Variable_name = 'binlog_row_image'
# AND upper(Value) = 'FULL')
# OR (Variable_name = 'default_authentication_plugin'
# AND upper(Value) = 'MYSQL_NATIVE_PASSWORD')
# OR (Variable_name = 'log_bin_use_v1_row_events'
# AND upper(Value) = 'OFF');

CREATE USER canal IDENTIFIED BY  'canal';
GRANT SELECT, REPLICATION SLAVE,  REPLICATION CLIENT ON *.* TO 'canal'@'%';
# -- GRANT ALL PRIVILEGES ON *.* TO 'canal'@'%' ;
FLUSH PRIVILEGES;

# set allow_experimental_database_materialized_mysql = 1;

# CREATE DATABASE mysql ENGINE = MaterializedMySQL('127.0.0.1:3306', 'collection', 'root', '123123')
#      SETTINGS
#         allows_query_when_mysql_lost=true,
#         max_wait_time_when_mysql_unavailable=10000;

# docker cp canal-server:/home/admin/canal-server/conf/example/instance.properties ./
