USE mysql;
CREATE DATABASE IF NOT EXISTS banchopy;
USE banchopy;
source /base.sql
USE mysql;
UPDATE user SET host = '%' WHERE user = 'root';
flush privileges;