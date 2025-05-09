CREATE DATABASE QLBanHang
ON PRIMARY(
        	NAME = 'QLBanHang _DATA',
        	FILENAME = 'D:\CSDL\QLBanHang_data.mdf',
        	SIZE = 10MB,
        	MAXSIZE = 15MB,
        	FILEGROWTH = 20%)
LOG ON(
        	NAME = 'QLBanHang_LOG',
        	FILENAME = 'D:\CSDL\QLBanHang_log.ldf',
        	SIZE = 10MB,
        	MAXSIZE = 15MB,
        	FILEGROWTH = 10%)
GO
USE QLBanHang;
GO
-- Tạo bảng Đơn vị
CREATE TABLE DonVi (
    MaDonVi NVARCHAR(10) PRIMARY KEY,
    TenDonVi NVARCHAR(100) NOT NULL,
    DiaChiDonVi NVARCHAR(255) NOT NULL,
    SoDienThoaiDonVi NVARCHAR(15) NOT NULL UNIQUE
);

-- Tạo bảng DuAn
CREATE TABLE DuAn (
    MaDuAn NVARCHAR(10) PRIMARY KEY,
    TenDuAn NVARCHAR(100) NOT NULL
);

-- Tạo bảng NhanVien
CREATE TABLE NhanVien (
    MaNhanVien NVARCHAR(10) PRIMARY KEY,
    TenNhanVien NVARCHAR(100) NOT NULL,
    GioiTinh NVARCHAR(10) CHECK (GioiTinh IN ('Nam', 'Nu')),
    DiaChiNhanVien NVARCHAR(255),
    SoDienThoaiNhanVien NVARCHAR(15) UNIQUE,
    MaDonVi NVARCHAR(10) NOT NULL,
    MaDuAn NVARCHAR(10) NOT NULL,
    FOREIGN KEY (MaDonVi) REFERENCES DonVi(MaDonVi),
    FOREIGN KEY (MaDuAn) REFERENCES DuAn(MaDuAn)
);

-- Tạo bảng KhachHang
CREATE TABLE KhachHang (
    MaKhachHang NVARCHAR(10) PRIMARY KEY,
    TenKhachHang NVARCHAR(100) NOT NULL,
    SDTKhachHang NVARCHAR(15) NOT NULL UNIQUE,
    DiaChiKhachHang NVARCHAR(255)
);

-- Tạo bảng Hang
CREATE TABLE Hang (
    MaHang NVARCHAR(10) PRIMARY KEY,
    TenHang NVARCHAR(100) NOT NULL,
    SoLuongTrongKho INT CHECK (SoLuongTrongKho >= 0)
);


-- Tạo bảng HoaDon
CREATE TABLE HoaDon (
    MaHoaDon NVARCHAR(10) PRIMARY KEY,
    NgayDatHang DATE NOT NULL,
    MaKhachHang NVARCHAR(10) NOT NULL,
    MaNhanVien NVARCHAR(10) NOT NULL,
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang),
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien (MaNhanVien)
);

-- Tạo bảng ChiTietHoaDon
CREATE TABLE ChiTietHoaDon(
    MaHoaDon NVARCHAR(10),
    MaHang NVARCHAR(10),
    SoLuongDatHang INT CHECK (SoLuongDatHang > 0),
    PRIMARY KEY (MaHoaDon, MaHang),
    FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHoaDon),
    FOREIGN KEY (MaHang) REFERENCES Hang(MaHang)
);
-- Thêm thông tin DonVi
INSERT INTO DonVi (MaDonVi, TenDonVi, DiaChiDonVi, SoDienThoaiDonVi)
VALUES
(N'DV001', N'Phòng Kinh Doanh', N'123 Lê Lợi, Q.1, TP.HCM', '0961234567'),
(N'DV002', N'Phòng Kế Toán', N'45 Nguyễn Huệ, Q.1, TP.HCM', '0352345678'),
(N'DV003', N'Phòng Nhân Sự', N'78 Trần Hưng Đạo, Q.5', '0913456780'),
(N'DV004', N'Phòng Kỹ Thuật', N'90 Cách Mạng Tháng 8, Q.3', '0984567801'),
(N'DV005', N'Phòng Marketing', N'10 Hai Bà Trưng, Q.1', '0955678902');
-- Thêm thông tin DuAn
INSERT INTO DuAn (MaDuAn, TenDuAn)
VALUES
(N'DA001',N'Hệ thống bán hàng A'),
(N'DA002',N'Quản lý nhân sự'),
(N'DA003',N'Ứng dụng đặt hàng trực tuyến'),
(N'DA004',N'Phần mềm kế toán doanh nghiệp'),
(N'DA005',N'Hệ thống quản lý kho');
-- Thêm thông tin NhanVien
INSERT INTO NhanVien (MaNhanVien, TenNhanVien, GioiTinh, DiaChiNhanVien, SoDienThoaiNhanVien, MaDonVi, MaDuAn)
VALUES
(N'NV001', N'Trần Văn An', N'Nam', N'25 Phạm Ngũ Lão, Q.1', '0912345678', N'DV001', N'DA001'),
(N'NV002', N'Nguyễn Thị Bình', N'Nu', N'88 Lý Thường Kiệt, Q.3', '0934567890', N'DV002', N'DA002'),
(N'NV003', N'Lê Minh Tuấn', N'Nam', N'12 Điện Biên Phủ, Q.5', '0909876543', N'DV001', N'DA003'),
(N'NV004', N'Phạm Hồng Hạnh', N'Nu', N'33 Nguyễn Đình Chiểu', '0945678901', N'DV003', N'DA004'),
(N'NV005', N'Vũ Quốc Cường', N'Nam', N'76 Võ Thị Sáu, Q.3', '0981234567', N'DV004', N'DA005');
-- Thêm thông tin KhachHang
INSERT INTO KhachHang (MaKhachHang, TenKhachHang, SDTKhachHang, DiaChiKhachHang)
VALUES
(N'KH001',N'Nguyễn Thị Lan','0985412341',N'Hà Nội'),
(N'KH002',N'Trần Minh Hoàng','037514235',N'Đà Nẵng'),
(N'KH003',N'Phạm Mai Lan','0951245879',N'TP.HCM'),
(N'KH004',N'Nguyễn Văn Tuấn','0821456341',N'Cần Thơ'),
(N'KH005',N'Lê Thị Bích','0379012453',N'Đồng Tháp');

-- Thêm thông tin Hang
INSERT INTO Hang (MaHang, TenHang, SoLuongTrongKho) VALUES
(N'H001', N'Bút Bi', 120),
(N'H002', N'Vở', 75),
(N'H003', N'Giấy A4', 200),
(N'H004', N'Bìa Cứng', 60),
(N'H005', N'Kẹp giấy', 300);
-- Thêm thông tin HoaDon
INSERT INTO HoaDon (MaHoaDon, NgayDatHang, MaKhachHang, MaNhanVien) VALUES
(N'HD01', N'2024-04-01', N'KH001', N'NV001'),
(N'HD02', N'2024-04-02', N'KH002', N'NV002'),
(N'HD03', N'2024-04-03', N'KH003', N'NV003'),
(N'HD04', N'2024-04-04', N'KH004', N'NV004'),
(N'HD05', N'2024-04-04', N'KH005', N'NV005');
-- Thêm thông tin ChiTietHoaDon
INSERT INTO ChiTietHoaDon(MaHoaDon, MaHang, SoLuongDatHang) VALUES
(N'HD01', N'H001', 20),
(N'HD02', N'H002', 10),
(N'HD03', N'H003', 50),
(N'HD04', N'H004', 30),
(N'HD05', N'H005', 80);
