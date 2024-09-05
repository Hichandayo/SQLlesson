-- drop table Classes;
-- drop table student;
-- drop table mark;
-- drop table subjectsv;
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
subjectid int auto_increment primary key ,
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

insert into Classes(className,startDate,status)
values ('HN-JV231103','2023-11-03',true),('HN-JV231119','2023-12-29',true),('HN-JV231504','2023-06-15',true);

insert into student(StudentName,address,phone,class_id,status)
values ('Ho Da Hung','HN','0987654321','1',true),('duong my huyen','DN','0987654332','1',true),
('hoang minh hieu','HN','0987654355','2',true),('hien','NA','0987654355','2',true),
('nguyen vinh','HN','0987654355','3',true),
('Nam cao','HT','0987654355','1',true),
('Nguyen Du','NA','0987654355','3',true);

insert into subjectsv(subjectName,credit,status)
values ('Toan','3',true),('Van','3',true),('Anh','2',true);

insert into mark(student_Id,subject_Id,mark,examTime)
values ('1','1','7','2024-05-12'),('1','1','7','2024-03-15'),('2','2','8','2024-05-15'),('2','3','9','2024-03-08'),('3','3','10','2024-02-11');

select * from classes;
select * from student;
-- Hiển thị tất cả lớp học được sắp xếp theo tên giảm dần
select className from classes order by className desc;
-- Hiển thị tất cả học sinh có address ở “Hà Nội”
select * from student where address = 'HN';
-- Hiển thị tất cả học sinh thuộc lớp HN-JV231103
select studentId,StudentName,address,phone,classname from student join classes
on student.class_id = classes.classid where classes.className = 'HN-JV231103'
;
 -- Hiển thị tát cả các môn học có credit trên 2
 select * from subjectsv where credit > 2 ;
-- Hiển thị tất cả học sinh có phone bắt đầu bằng số 09
select * from student where phone like '09%';
-- Hiển thị số lượng sinh viên theo từng địa chỉ nơi ở. (sử dụng count để đếm)
select address, count(studentId) from student group by address;
-- Hiển thị các thông tin môn học có điểm thi lớn nhất.
select * from mark join subjectsv
on mark.subject_Id = subjectsv.subjectid
where mark.mark =(select max(mark) from mark);
-- Tính điểm trung bình các môn học của từng học sinh.
select subjectsv.subjectid, subjectsv.subjectName,studentId,StudentName, avg(mark.mark) from mark join subjectsv 
on mark.subject_Id = subjectsv.subjectid
join student 
on mark.student_Id = student.studentId
group by subjectsv.subjectid, subjectsv.subjectName,studentId,StudentName;
-- Hiển thị thông tin học viên có điểm trung bình các môn lớn nhất.
with student_avg as (
    select 
        m.student_Id, 
        avg(m.mark) as avg_mark
    from 
        mark m
    group by 
        m.student_Id
)
select s.studentId, s.StudentName, s.address, s.phone, sa.avg_mark
from student s
join student_avg sa on s.studentId = sa.student_Id
where sa.avg_mark = (select MAX(avg_mark) from student_avg);
-- bt3-ss5
-- Tạo store procedure lấy ra tất cả lớp học có số lượng học sinh lớn hơn 5

delimiter //
create procedure GetClassesWithMoreThanFiveStudents()
begin
    select c.classid, c.className, COUNT(s.studentId) as NumberOfStudents
    from Classes c
    join Student s on c.classid = s.class_id
    group by c.classid, c.className
    having count(s.studentId) > 5;
end //
call GetClassesWithMoreThanFiveStudents();

-- Tạo store procedure hiển thị ra danh sách môn học có điểm thi là 10

delimiter //
create procedure GetSubjectsWithPerfectScore()
begin
    select s.subjectid, s.subjectName, m.mark, m.examTime
    from subjectsv s
    join mark m on s.subjectid = m.subject_Id
    where m.mark = 10;
end //
call GetSubjectsWithPerfectScore();

-- Tạo store procedure hiển thị thông tin các lớp học có học sinh đạt điểm 10
delimiter //

create procedure GetClassesWithTopScoringStudents()
begin
    select distinct c.classid, c.className, c.startDate, c.status
    from Classes c
    join Student s on c.classid = s.class_id
    join Mark m on s.studentId = m.student_Id
    where m.mark = 10;
end //
call GetClassesWithTopScoringStudents();

-- Tạo store procedure thêm mới student và trả ra id vừa mới thêm
delimiter //
create procedure AddNewStudent(p_StudentName varchar(255),p_Address varchar(255),p_Phone varchar(15),p_ClassId int,p_Status bit,
    out p_NewStudentId int
)
begin
    -- Insert the new student into the Student table
    insert into Student (StudentName, Address, Phone, Class_id, Status)
    value (p_StudentName, p_Address, p_Phone, p_ClassId, p_Status);
    
    -- Get the last inserted ID
    set p_NewStudentId = LAST_INSERT_ID();
end //
call AddNewStudent('John Doe', '123 Main St', '1234567890', 1, 1, @NewStudentId);
select @NewStudentId;

-- Tạo store procedure hiển thị subject chưa được ai thi

delimiter //
create procedure GetSubjectsNotTaken()
begin
    select s.subjectid, s.subjectName, s.credit, s.status
    from subjectsv s
    where not exists (
        select 1
        from mark m
        where m.subject_Id = s.subjectid
    );
end //
call GetSubjectsNotTaken();
