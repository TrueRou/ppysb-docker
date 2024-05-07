USE mysql;
CREATE DATABASE IF NOT EXISTS banchopy;

set innodb_lock_wait_timeout=100;
set sql_log_bin=off;
set autocommit=0;

USE banchopy;
start transaction;
source /mysql/base.sql
commit;

set sql_log_bin=on;
set autocommit=1;

USE mysql;
UPDATE user SET host = '%' WHERE user = 'root';
flush privileges;