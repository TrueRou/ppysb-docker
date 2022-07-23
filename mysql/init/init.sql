USE mysql;
CREATE DATABASE IF NOT EXISTS banchopy;
USE banchopy;
source /mysql/base.sql
USE mysql;
UPDATE user SET host = '%' WHERE user = 'root';
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'banchopy';
flush privileges;