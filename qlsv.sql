-- drop table Classes;
-- drop table student;
-- drop table mark;
-- drop table subject;
create table Classes(
classid int auto_increment primary key,
className varchar(255),
startDate varchar(255),
status bit check( status in ( 0,1))
);
create table student(
studentId int auto_increment primary key,
StudentName varchar(255),
address varchar(255),
phone varchar(15),
class_id int,
status bit check( status in ( 0,1))
);
create table mark(
markid int auto_increment primary key,
student_Id int,
subject_Id int,
mark double,
examTime datetime
);
create table subjectsv(
subjectid int ,
subjectName varchar(100),
credit int,
status bit check( status in ( 0,1))
);
alter table student
add foreign key (class_id) references Classes(classid);
alter table mark
add foreign key (student_Id) references student(studentId);
alter table mark
add foreign key (subject_Id) references subjectsv(subjectid);
insert into Classes(name,cAge)
values ('Minh Quan','10'),('Ngoc Oanh','20'),('Hong Ha','50');
insert into student(c_id,oDate,oTotalprice)
values ('1','2006-03-21','150000'),('2','2006-03-23','200000'),('1','2006-03-16','170000');
insert into mark(pname,pprice)
values ('May Giat','300'),('tu lanh','500'),('Dieu Hoa','700'),('Quat','100'),('Bep Dien','200'),('May Hut Mui','500');
insert into subjectsv(o_id,p_id,odqty)
values ('1','1','3'),('1','3','7'),('1','4','2'),('2','1','1'),('3','1','8'),('2','5','4'),('2','3','3');
