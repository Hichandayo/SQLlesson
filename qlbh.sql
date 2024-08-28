-- drop table Customer;
-- drop table OrderPro;
-- drop table product;
-- drop table Customer;
create table Customer(
cid int auto_increment primary key,
name varchar(255),
cAge tinyint
);
create table orderPro(
oid int auto_increment primary key,
c_id int,
oDate date,
ototalprice int
);
create table product(
pid int auto_increment primary key,
pName varchar(25),
pPrice int
);
create table orderdetail(
o_id int ,
p_id int,
odQTY int
);
alter table orderpro
add foreign key (c_id) references Customer(cid);
alter table orderdetail
add foreign key (o_id) references orderPro(oid);
alter table orderdetail
add foreign key (p_id) references product(pid);
insert into Customer(name,cAge)
values ('Minh Quan','10'),('Ngoc Oanh','20'),('Hong Ha','50');
insert into orderPro(c_id,oDate,oTotalprice)
values ('1','2006-03-21','150000'),('2','2006-03-23','200000'),('1','2006-03-16','170000');
insert into product(pname,pprice)
values ('May Giat','300'),('tu lanh','500'),('Dieu Hoa','700'),('Quat','100'),('Bep Dien','200'),('May Hut Mui','500');
insert into orderdetail(o_id,p_id,odqty)
values ('1','1','3'),('1','3','7'),('1','4','2'),('2','1','1'),('3','1','8'),('2','5','4'),('2','3','3');
-- hiển thị oID, oDdate, oPrice của order
select oid, oDate, ototalprice from orderpro;
-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách hàng đó.
SELECT c.name , p.pName , od.odQTY , op.oDate FROM Customer c
join orderPro op 
on c.cid = op.c_id
join orderdetail od 
on op.oid = od.o_id
join product p
on od.p_id = p.pid
ORDER BY c.name, op.oDate;
-- Hiển thị tất cả customer có đơn hàng trên 150000
select * from customer join orderpro 
on customer.cid = orderpro.c_id
where orderpro.oTotalprice > '150000'; 
-- Hiển thị sản phẩm chưa được bán cho bất cứ ai

-- Hiển thị tất cả đơn hàng mua trên 2 sản phẩm

-- Hiển thị đơn hàng có tổng giá tiền lớn nhất

-- Hiển thị sản phẩm có giá tiền lớn nhất

-- Hiển thị người dùng nào mua nhiều sản phẩm “Bep Dien” nhất




