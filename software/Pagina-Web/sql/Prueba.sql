DROP DATABASE IF EXISTS Franco_db;
CREATE DATABASE Franco_db CHARSET utf8mb4;
USE Franco_db;

CREATE TABLE users (
  id int(11) NOT NULL auto_increment,
  name varchar(100) NOT NULL,
  email varchar(100) NOT NULL,
  PRIMARY KEY (id)
  created datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE USER IF NOT EXISTS 'Franco'@'%';
SET PASSWORD FOR 'Franco'@'%' = '11Ww222Ee';
GRANT ALL PRIVILEGES ON Franco_db.* TO 'Franco'@'%';



