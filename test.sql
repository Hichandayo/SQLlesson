create database Quanliphongban;
SELECT * FROM Employee
         WHERE Email NOT REGEXP "^[a-zA-Z0-9][a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]*?[a-zA-Z0-9._-]?@[a-zA-Z0-9][a-zA-Z0-9._-]*?[a-zA-Z0-9]?\\.[a-zA-Z]{2,63}$";
-- bảng phòng ban
create table Department(
id int auto_increment primary key,
name varchar(100) not null unique 
);
-- bảng cấp độ
create table Levels(
id int auto_increment primary key,
name varchar(100) not null unique ,
BasicSalary float not null check(BasicSalary >=3500000),
AllowanceSalary float default(500000)
);
-- bảng nhân viên
create table Employee(
id int auto_increment primary key,
name Varchar(150) not null ,
Email Varchar(150) not null unique,
Phone Varchar(50) not null unique,
Address Varchar(255),
Gender Tinyint check( gender in (0,1,2)),
BirthDay Date not null,
LevelId Int not null,
DepartmentId Int not null
);
Alter table Employee
add foreign key(levelId) references Levels(id);
Alter table Employee
add foreign key(DepartmentId) references Department(id);
insert into Department(name)
value ('Phòng Marketing'),('Phòng Chăm sóc khách hàng'),('Phòng Ăn Nhậu');
insert into Levels(name,BasicSalary)
value ('Trưởng Phòng',3500000),('Phó Phòng',3600000),('PGĐ',3700000);
insert into Employee(name,Email,Phone,Address,Gender,BirthDay,LevelId,DepartmentId)
value ('Hiển','hien@gmail.com','0909889990','hcm','1','2001/12/21','1','2');
-- ('Hiển1','hien1@gmail.com','0909889991','hcm','2','12/12/3221','2','2'),
-- ('Hiển2','hien1@gmail.com','0909889992','hcm','0','12/12/3221','1','1'),
-- ('Hiển3','hien1@gmail.com','0909889993','hcm','1','12/12/3221','2','2'),
-- ('Hiển4','hien1@gmail.com','0909889994','hcm','0','12/12/3221','1','3'),
-- ('Hiển5','hien1@gmail.com','0909889995','hcm','2','12/12/3221','2','2'),
-- ('Hiển6','hien1@gmail.com','0909889996','hcm','0','12/12/3221','1','1'),
-- ('Hiển7','hien1@gmail.com','0909889997','hcm','1','12/12/3221','2','2'),
-- ('Hiển8','hien1@gmail.com','0909889998','hcm','2','12/12/3221','1','3'),
-- ('Hiển9','hien1@gmail.com','0909889999','hcm','1','12/12/3221','3','2'),
-- ('Hiển10','hien1@gmail.com','0909889910','hcm','1','12/12/3221','1','1'),
-- ('Hiển11','hien1@gmail.com','0909889911','hcm','2','12/12/3221','3','2'),
-- ('Hiển12','hien1@gmail.com','0909889912','hcm','2','12/12/3221','1','3'),
-- ('Hiển13','hien1@gmail.com','0909889913','hcm','1','12/12/3221','3','23'),
-- ('Hiển14','hien1@gmail.com','0909889914','hcm','0','12/12/3221','1','2'),
-- ('Hiển15','hien1@gmail.com','0909889915','hcm','1','12/12/3221','3','1');

