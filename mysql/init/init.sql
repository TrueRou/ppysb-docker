USE mysql;
CREATE DATABASE IF NOT EXISTS banchopy;
USE banchopy;
source /mysql/base.sql
USE mysql;
UPDATE user SET host = '%' WHERE user = 'root';
flush privileges;