DROP DATABASE IF EXISTS Franco_db;
CREATE DATABASE Franco_db CHARSET utf8mb4;
USE Franco_db;

CREATE TABLE users (
  id int(11) NOT NULL auto_increment,
  name varchar(100) NOT NULL,
  age int(3) NOT NULL,
  email varchar(150) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;





