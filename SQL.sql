Create database if not exists quanlibanhang;
use quanlibanhang;
create table Users(
id int primary key auto_increment,
	username varchar(20),
	password varchar(255),
	full_name varchar(50),
	email varchar(100),
	phone varchar(15),
	address varchar(255),
	role bit,
	status bit
);
CREATE TABLE quanlibanhang.category (
  id INT AUTO_INCREMENT,
  name VARCHAR(45) ,
  description TEXT ,
  status BIT(1) NULL,
  PRIMARY KEY (id));
