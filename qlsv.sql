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
WITH student_avg AS (
    SELECT 
        m.student_Id, 
        AVG(m.mark) AS avg_mark
    FROM 
        mark m
    GROUP BY 
        m.student_Id
)
SELECT s.studentId, s.StudentName, s.address, s.phone, sa.avg_mark
FROM student s
JOIN student_avg sa ON s.studentId = sa.student_Id
WHERE sa.avg_mark = (SELECT MAX(avg_mark) FROM student_avg);
-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
