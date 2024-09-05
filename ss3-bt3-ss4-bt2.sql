-- drop table PhieuXuat;
-- drop table PhieuXuatChiTiet;
-- drop table ChiTietDonHang;
-- drop table VatTu;
-- drop table PhieuNhap;
-- drop table PhieuNhapChiTiet;
-- drop table NhaCungCap;
-- drop table DonDatHang;
create table PhieuXuat(
soPX int auto_increment primary key,
ngayXuat datetime);
create table VatTu(
maVT int auto_increment primary key,
tenVT varchar(255)
);
create table PhieuNhap(
soPN int auto_increment primary key,
ngayNhap datetime);
create table PhieuNhapChiTiet(
soPN int,
maVT int,
donGiaNhap double,
soLuongNhap int);
create table PhieuXuatChiTiet(
soPX int,
maVT int,
donGiaXuat double,
soLuongXuat int
);
create table ChiTietDonHang(
maVT int ,
soDH int
);
create table NhaCungCap(
maNCC int auto_increment primary key,
tenNCC varchar(255),
diaChi varchar(255),
soDienThoai varchar(11)
);
create table DonDatHang(
soDH int auto_increment primary key,
maNCC int,
ngayDH datetime);
insert into PhieuXuat(soPX, ngayXuat)
values
(1, '2024-08-01'),
(2, '2024-08-05'),
(3, '2024-08-10'),
(4, '2024-08-12'),
(5, '2024-08-15');
INSERT INTO PhieuXuatChiTiet(soPX, maVT, donGiaXuat, soLuongXuat)
VALUES
(1, 101, 50000, 10),
(1, 102, 45000, 5),
(2, 103, 60000, 20),
(2, 101, 50000, 15),
(3, 104, 75000, 7),
(4, 102, 45000, 25),
(5, 105, 90000, 10);
INSERT INTO ChiTietDonHang(maVT, soDH)
VALUES
(101, 201),
(102, 202),
(103, 203),
(104, 204),
(105, 205),
(101, 206),
(102, 207),
(103, 208);
INSERT INTO VatTu(maVT, tenVT)
VALUES
(101, 'Gạch'),
(102, 'Xi măng'),
(103, 'Sắt thép'),
(104, 'Cát'),
(105, 'Đá');
INSERT INTO PhieuNhap(soPN, ngayNhap)
VALUES
(301, '2024-07-01'),
(302, '2024-07-10'),
(303, '2024-07-15'),
(304, '2024-07-20'),
(305, '2024-07-25');
INSERT INTO PhieuNhapChiTiet(soPN, maVT, donGiaNhap, soLuongNhap)
VALUES
(301, 101, 4118000, 12),
(301, 102, 414000, 10),
(302, 103, 580000, 15),
(303, 104, 7000000, 8),
(304, 105, 2188000, 6),
(305, 101, 2148000, 9),
(305, 102, 440000, 7);

INSERT INTO NhaCungCap(maNCC, tenNCC, diaChi, soDienThoai)
VALUES
(401, 'Công ty A', 'Hà Nội', '0912345678'),
(402, 'Công ty B', 'Hồ Chí Minh', '0923456789'),
(403, 'Công ty C', 'Đà Nẵng', '0934567890'),
(404, 'Công ty D', 'Hải Phòng', '0945678901'),
(405, 'Công ty E', 'Cần Thơ', '0956789012'),
(406, 'Công ty F', 'long biên', '0956789012'),
(407, 'Công ty G', 'Cần Thơ', '0956789012'),
(408, 'Công ty H', 'long biên', '0956789012'),
(409, 'Công ty J', 'Hồ Chí Minh', '0956789012');

INSERT INTO DonDatHang(soDH, maNCC, ngayDH)
VALUES
(201, 401, '2024-06-01'),
(202, 402, '2024-06-05'),
(203, 403, '2024-06-10'),
(204, 404, '2024-06-15'),
(205, 405, '2024-06-20'),
(206, 401, '2024-06-25'),
(207, 402, '2024-06-30'),
(208, 403, '2024-07-01');
alter table phieuxuatchitiet
add foreign key (soPX) references phieuxuat(soPX);
alter table phieuxuatchitiet
add foreign key (maVT) references vattu(maVT);
alter table PhieuNhapChiTiet
add foreign key (soPN) references phieunhap(soPN);
alter table PhieuNhapChiTiet
add foreign key (maVT) references vattu(maVT);
alter table DonDatHang
add foreign key (maNCC) references nhacungcap(maNCC) ;
-- alter table ChiTietDonHang
-- add foreign key () references ;

-- Tìm danh sách vật tư bán chạy nhất

-- Tìm danh sách vật tư có trong kho nhiều nhất

-- Hiển thị tất cả vật tự dựa vào phiếu xuất có số lượng lớn hơn 10
select v.* from vattu v join phieuxuatchitiet ct
on v.mavt = ct.maVT
where ct.soLuongXuat > 10;
-- Hiển thị tất cả vật tư được nhập vào với đơn giá lớn hơn 1.200.000
select v.* from vattu v join phieuxuatchitiet ct
on v.mavt = ct.maVT
where ct.soLuongXuat > 1200000;
-- sử dụng trigger
drop trigger before_delete_customer;
delimiter //
create trigger before_delete_customer
before delete on customer
for each row
begin 
delete from orderdetail where o_id = 2;
end;
//
