-- drop table color;
-- drop table size;
-- drop table product;
-- drop table product_detail;
create table color(
id int auto_increment primary key ,
name varchar(100),
status bit check( status in ( 0,1))
);
create table product(
id int auto_increment primary key,
name varchar(100),
created date
);
create table size(
id int auto_increment primary key,
name varchar(100),
status bit check( status in ( 0,1))
);
create table product_detail(
id int auto_increment primary key,
product_id int,
color_id int,
size_id int,
price double,
stock int,
status bit check( status in ( 0,1))
);
alter table product_detail 
add foreign key (size_id) references size(id);
alter table product_detail 
add foreign key (color_id) references color(id);
alter table product_detail 
add foreign key (product_id) references product(id);

insert into color( name)
values ('RED'),('BLUE'),('GREEN')
;
insert into size( name )
values('X'),('M'),('L'),('XL'),('XXL')
;
insert into product( name, created)
values('Quần Dài','1990-05-19'),('Áo Dài','1990-05-19'),('Mũ Phớt','1990-05-19')
;
insert into product_detail( product_id, color_id,size_id,price,stock)
values('1','1','1','1200','5'),('2','1','1','1500','2'),('1','2','3','500','3'),('1','2','3','1600','3'),('3','1','4','1200','5'),('3','3','5','1200','6')
;
-- hiển thị thông tin sản phẩm chi tiết (product_detail) có giá lớn hơn 1200
select * from product_detail where price > 1200;
-- hiển thị tất cả thông tin các màu
select product_detail.id,price,stock , color.name from product_detail join color
on product_detail.color_id = color.id;
-- hiển thị tất cả thông tin các size
select product_detail.id,price,stock , size.name from product_detail join size
on product_detail.size_id = size.id;
-- hiển thị tất cả sản phẩm chi tiết (product_detail) của mã sản phầm là 1
select * from product_detail where product_id = '1';

