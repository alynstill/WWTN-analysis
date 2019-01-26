DROP DATABASE IF EXISTS wwtn;
CREATE DATABASE wwtn
  DEFAULT CHARACTER SET latin1;

USE wwtn;
SET NAMES 'latin1';
DROP USER IF EXISTS wwtn;
CREATE USER 'wwtn' IDENTIFIED BY 'supersecretpassword';
GRANT ALL PRIVILEGES ON wwtn.* TO 'wwtn';
FLUSH PRIVILEGES;