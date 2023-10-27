CREATE DATABASE DBTHIETBIDIENTU
GO
USE DBTHIETBIDIENTU

CREATE TABLE ADMIN
(
UserAdmin varchar(30) primary key,
PassAdmin varchar(30) not null,
HoTen nvarchar(50),
VaiTro varchar(30)
)
--Bang Category
CREATE TABLE [dbo].[Category] (
 [Id] INT IDENTITY (1, 1) NOT NULL,
 [IDCate] NCHAR (20) NOT NULL,
 [NameCate] NVARCHAR (MAX) NULL,
 PRIMARY KEY CLUSTERED ([IDCate] ASC)
);
--Bang Customer
CREATE TABLE [dbo].[Customer] (
 [IDCus] INT IDENTITY (1, 1) NOT NULL,
 [NameCus] NVARCHAR (MAX) NULL,
 [AddCus] nvarchar (max) null,
 [PhoneCus] NVARCHAR (15) NULL,
 [EmailCus] NVARCHAR (MAX) NULL,
 [PassCus] NCHAR (50),
 [Login] varchar(15) null,
 [Sex] bit default 1,
 [Birthday] datetime null,
 PRIMARY KEY CLUSTERED ([IDCus] ASC)
);
alter table [dbo].[Customer] add [Birthday] datetime
--Bang Products
CREATE TABLE [dbo].[Products] (
 [ProductID] INT IDENTITY (1, 1) NOT NULL,
 [NamePro] NVARCHAR (MAX) NULL,
 [DecriptionPro] NVARCHAR (MAX) NULL,
 [Category] NCHAR (20) NULL,
 [Price] Money check(Price>0) NULL,
 [ImagePro] NVARCHAR (MAX) NULL,
 [ParentID] nchar(10) null,
 PRIMARY KEY CLUSTERED ([ProductID] ASC),
 CONSTRAINT [FK_Pro_Category] FOREIGN KEY ([Category]) REFERENCES [dbo].[Category]
([IDCate])
);
--Bang OrderPro
CREATE TABLE [dbo].[OrderPro] ([dbo].[OrderPro]
 [ID] INT IDENTITY (1, 1) NOT NULL,
 [DateOrder] DATE NULL,
 [IDCus] INT NULL,
 [Trigia] Money check Trigia>0,
 [AddressDeliverry] NVARCHAR (MAX) NULL,
 [Dagiao] bit default 1 null,
[Ngaygiaohang] Smalldatetime,
[TenNguoiNhan] nvarchar(Max),
[DienThoaiNhan] nvarchar(15),
[HTThanhToan] bit Default 0,
[HTGiaoHang] bit Default 0;
 PRIMARY KEY CLUSTERED ([ID] ASC),
 FOREIGN KEY ([IDCus]) REFERENCES [dbo].[Customer] ([IDCus])

);
--Bang OrderDetail
CREATE TABLE [dbo].[OrderDetail] (
 [ID] INT IDENTITY (1, 1) NOT NULL,
 [IDProduct] INT NULL,
 [IDOrder] INT NULL,
 [Quantity] INT NULL,
 [UnitPrice] Money check(UnitPrice >= 0),
 PRIMARY KEY CLUSTERED ([ID] ASC),
 FOREIGN KEY ([IDProduct]) REFERENCES [dbo].[Products] ([ProductID]),
 FOREIGN KEY ([IDOrder]) REFERENCES [dbo].[OrderPro] ([ID])
);
---mã khuyến mãi
Create table [dbo].[MaKhuyenMai] (
[IDMaKM] INT IDENTITY (1, 1) NOT NULL,
[MaKM] NCHAR(5) null,
[TenKM] NVARCHAR(max) null,
[GiaTriKM] DECIMAL (18, 2) NULL,
PRIMARY KEY CLUSTERED ([IDMaKM] ASC),
);

INSERT [dbo].[Category] ([IDCate], [NameCate]) VALUES (1, N'Iphone')
INSERT [dbo].[Category] ([IDCate], [NameCate])  VALUES (2, N'SamSung')
INSERT [dbo].[Category] ([IDCate], [NameCate])  VALUES (3, N'Macbook')
INSERT [dbo].[Category] ([IDCate], [NameCate])  VALUES (4, N'Laptop')
INSERT [dbo].[Category] ([IDCate], [NameCate])  VALUES (5, N'Phụ Kiện')


INSERT [dbo].[Customer] ([IDCus], [NameCus], [AddCus], [PhoneCus], [Login], [PassCus], [Birthday], [Sex], [EmailCus]) VALUES (1, N'Nguyễn Tiến Luân', N'Trần Huy Liệu', N'0918062755', N'phetcm', N'123', CAST(0x59310000 AS SmallDateTime), 1, N'pvkhoa@hcmuns.edu.vn')
INSERT [dbo].[Customer] ([IDCus], [NameCus], [AddCus], [PhoneCus], [Login], [PassCus], [Birthday], [Sex], [EmailCus]) VALUES (2, N'Nguyễn Tiến Luân', N'Quận 6', N'Chua có', N'thang', N'123456', CAST(0x6A570000 AS SmallDateTime), 1, N'ntluan@hcmuns.edu.vn')
INSERT [dbo].[Customer] ([IDCus], [NameCus], [AddCus], [PhoneCus], [Login], [PassCus], [Birthday], [Sex], [EmailCus]) VALUES (3, N'Đặng Quốc Hòa', N'Sư Vạn Hạnh', N'Chua có', N'dqhoa', N'hoa', CAST(0x5D890000 AS SmallDateTime), 1, N'dqhoa@hcmuns.edu.vn')
INSERT [dbo].[Customer] ([IDCus], [NameCus], [AddCus], [PhoneCus], [Login], [PassCus], [Birthday], [Sex], [EmailCus]) VALUES (4, N'Ngô Ngọc Ngân', N'Khu chung cư', N'0918544699', N'nnngan', N'ngan', CAST(0x42830000 AS SmallDateTime), 1, N'nnngan@hcmuns.edu.vn')
INSERT [dbo].[Customer] ([IDCus], [NameCus], [AddCus], [PhoneCus], [Login], [PassCus], [Birthday], [Sex], [EmailCus]) VALUES (5, N'Đỗ Quỳnh Hương', N'Cống Quỳnh', N'0908123456', N'dqhuong', N'huong', CAST(0x75500000 AS SmallDateTime), 0, N'dqhuong@hcmuns.edu.vn')

SET IDENTITY_INSERT [dbo].[Customer] ON

INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 1 ,N'iPhone 14 Pro 128GB - Chính hãng VN/A', 24990000, N'iPhone 14 Pro sở hữu màn hình Dynamic Island cùng công nghệ Super Retina XDR mang lại trải nghiệm hình ảnh ấn tượng. Camera trên iPhone 14 Pro cũng được nâng cấp lên đến 48MP với nhiều công nghệ chụp mang lại hình ảnh chuẩn nhiếp ảnh gia. Hiệu năng iPhone 14 Pro cũng mạnh mẽ với con chip hàng đầu Apple A16 Bionic giúp các thao tác diễn ra nhanh chóng, bộ nhớ RAM 6GB mang lại đa nhiệm mượt mà và ổn định trong mọi tác vụ.', 1,N't_m_12.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 2,N'Samsung Galaxy A14 4G', 3840000, N'Samsung Galaxy A14 4G có màn hình rộng 6.6 inch, tần số quét 60Hz, cụm camera 50MP+5MP+2MP và camera selfie 13MP. Dung lượng pin của máy lên đến 5.000 mAh, sử dụng cả ngày dài, khi gần cạn pin nhanh chóng nạp đầy thông qua củ sạc đi kèm. Nhờ vậy, người dùng có thể dễ dàng lướt web, đắm mình trong thế giới giải trí hay tận hưởng khoảnh khắc vui vẻ bên cạnh người thân, gia đình.',2,N'fdeen_1_.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 3,N'Macbook Pro 14 inch 2021 | Chính hãng Apple Việt Nam',43990000,N'Kế thừa những tinh hoa từ đời MacBook tốt nhất cùng với những nâng cấp đáng kể trong nhiều năm qua, Macbook Pro 14 inch dự kiến sẽ là mẫu laptop làm cho giới công nghệ "phát sốt", cũng như là cỗ máy xử lý công việc tối ưu hiệu quả.',3,N'pro_2021.png',3)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (4,N'Laptop Asus Vivobook X415EA BV451W',6990000,N'Laptop Asus Vivobook X415EA BV451W hướng đến người dùng là học sinh sinh viên và nhân viên văn phòng. Không chỉ sở hữu thiết kế sang trọng, nhỏ gọn mà còn được trang bị cấu hình mang lại hiệu năng ổn định.',4,N'7_15_13.png',4)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (5,N'Tai nghe Bluetooth JBL T115BT',450000,N'Tai nghe JBL T115BT sẽ là lựa chọn hết sức tuyệt vời với các bạn yêu thích các dòng tai nghe JBL có dây đeo cổ. Với dung lượng pin lên đến 8 tiếng, khả năng sạc nhanh trong 2h, công nghệ âm thanh độc quyền JBL Pure Bass Sound, driver 8.6mm dynamic cho âm thanh sống động.',5, N'jbl_t115bt_1.png',5)

INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 6 ,N'iPhone 14 Pro 128GB - Chính hãng VN/A', 24990000, N'iPhone 14 Pro sở hữu màn hình Dynamic Island cùng công nghệ Super Retina XDR mang lại trải nghiệm hình ảnh ấn tượng. Camera trên iPhone 14 Pro cũng được nâng cấp lên đến 48MP với nhiều công nghệ chụp mang lại hình ảnh chuẩn nhiếp ảnh gia. Hiệu năng iPhone 14 Pro cũng mạnh mẽ với con chip hàng đầu Apple A16 Bionic giúp các thao tác diễn ra nhanh chóng, bộ nhớ RAM 6GB mang lại đa nhiệm mượt mà và ổn định trong mọi tác vụ.', 1,N't_m_12.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 7,N'Samsung Galaxy A14 4G', 3840000, N'Samsung Galaxy A14 4G có màn hình rộng 6.6 inch, tần số quét 60Hz, cụm camera 50MP+5MP+2MP và camera selfie 13MP. Dung lượng pin của máy lên đến 5.000 mAh, sử dụng cả ngày dài, khi gần cạn pin nhanh chóng nạp đầy thông qua củ sạc đi kèm. Nhờ vậy, người dùng có thể dễ dàng lướt web, đắm mình trong thế giới giải trí hay tận hưởng khoảnh khắc vui vẻ bên cạnh người thân, gia đình.',2,N'fdeen_1_.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 8,N'Macbook Pro 14 inch 2021 | Chính hãng Apple Việt Nam',43990000,N'Kế thừa những tinh hoa từ đời MacBook tốt nhất cùng với những nâng cấp đáng kể trong nhiều năm qua, Macbook Pro 14 inch dự kiến sẽ là mẫu laptop làm cho giới công nghệ "phát sốt", cũng như là cỗ máy xử lý công việc tối ưu hiệu quả.',3,N'pro_2021.png',3)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (9,N'Laptop Asus Vivobook X415EA BV451W',6990000,N'Laptop Asus Vivobook X415EA BV451W hướng đến người dùng là học sinh sinh viên và nhân viên văn phòng. Không chỉ sở hữu thiết kế sang trọng, nhỏ gọn mà còn được trang bị cấu hình mang lại hiệu năng ổn định.',4,N'7_15_13.png',4)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (10,N'Tai nghe Bluetooth JBL T115BT',450000,N'Tai nghe JBL T115BT sẽ là lựa chọn hết sức tuyệt vời với các bạn yêu thích các dòng tai nghe JBL có dây đeo cổ. Với dung lượng pin lên đến 8 tiếng, khả năng sạc nhanh trong 2h, công nghệ âm thanh độc quyền JBL Pure Bass Sound, driver 8.6mm dynamic cho âm thanh sống động.',5, N'jbl_t115bt_1.png',5)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 11 ,N'iPhone 14 Pro 128GB - Chính hãng VN/A', 24990000, N'iPhone 14 Pro sở hữu màn hình Dynamic Island cùng công nghệ Super Retina XDR mang lại trải nghiệm hình ảnh ấn tượng. Camera trên iPhone 14 Pro cũng được nâng cấp lên đến 48MP với nhiều công nghệ chụp mang lại hình ảnh chuẩn nhiếp ảnh gia. Hiệu năng iPhone 14 Pro cũng mạnh mẽ với con chip hàng đầu Apple A16 Bionic giúp các thao tác diễn ra nhanh chóng, bộ nhớ RAM 6GB mang lại đa nhiệm mượt mà và ổn định trong mọi tác vụ.', 1,N't_m_12.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 12,N'Samsung Galaxy A14 4G', 3840000, N'Samsung Galaxy A14 4G có màn hình rộng 6.6 inch, tần số quét 60Hz, cụm camera 50MP+5MP+2MP và camera selfie 13MP. Dung lượng pin của máy lên đến 5.000 mAh, sử dụng cả ngày dài, khi gần cạn pin nhanh chóng nạp đầy thông qua củ sạc đi kèm. Nhờ vậy, người dùng có thể dễ dàng lướt web, đắm mình trong thế giới giải trí hay tận hưởng khoảnh khắc vui vẻ bên cạnh người thân, gia đình.',2,N'fdeen_1_.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 13,N'Macbook Pro 14 inch 2021 | Chính hãng Apple Việt Nam',43990000,N'Kế thừa những tinh hoa từ đời MacBook tốt nhất cùng với những nâng cấp đáng kể trong nhiều năm qua, Macbook Pro 14 inch dự kiến sẽ là mẫu laptop làm cho giới công nghệ "phát sốt", cũng như là cỗ máy xử lý công việc tối ưu hiệu quả.',3,N'pro_2021.png',3)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (14,N'Laptop Asus Vivobook X415EA BV451W',6990000,N'Laptop Asus Vivobook X415EA BV451W hướng đến người dùng là học sinh sinh viên và nhân viên văn phòng. Không chỉ sở hữu thiết kế sang trọng, nhỏ gọn mà còn được trang bị cấu hình mang lại hiệu năng ổn định.',4,N'7_15_13.png',4)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (15,N'Tai nghe Bluetooth JBL T115BT',450000,N'Tai nghe JBL T115BT sẽ là lựa chọn hết sức tuyệt vời với các bạn yêu thích các dòng tai nghe JBL có dây đeo cổ. Với dung lượng pin lên đến 8 tiếng, khả năng sạc nhanh trong 2h, công nghệ âm thanh độc quyền JBL Pure Bass Sound, driver 8.6mm dynamic cho âm thanh sống động.',5, N'jbl_t115bt_1.png',5)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 16 ,N'iPhone 14 Pro 128GB - Chính hãng VN/A', 24990000, N'iPhone 14 Pro sở hữu màn hình Dynamic Island cùng công nghệ Super Retina XDR mang lại trải nghiệm hình ảnh ấn tượng. Camera trên iPhone 14 Pro cũng được nâng cấp lên đến 48MP với nhiều công nghệ chụp mang lại hình ảnh chuẩn nhiếp ảnh gia. Hiệu năng iPhone 14 Pro cũng mạnh mẽ với con chip hàng đầu Apple A16 Bionic giúp các thao tác diễn ra nhanh chóng, bộ nhớ RAM 6GB mang lại đa nhiệm mượt mà và ổn định trong mọi tác vụ.', 1,N't_m_12.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 17,N'Samsung Galaxy A14 4G', 3840000, N'Samsung Galaxy A14 4G có màn hình rộng 6.6 inch, tần số quét 60Hz, cụm camera 50MP+5MP+2MP và camera selfie 13MP. Dung lượng pin của máy lên đến 5.000 mAh, sử dụng cả ngày dài, khi gần cạn pin nhanh chóng nạp đầy thông qua củ sạc đi kèm. Nhờ vậy, người dùng có thể dễ dàng lướt web, đắm mình trong thế giới giải trí hay tận hưởng khoảnh khắc vui vẻ bên cạnh người thân, gia đình.',2,N'fdeen_1_.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 18,N'Macbook Pro 14 inch 2021 | Chính hãng Apple Việt Nam',43990000,N'Kế thừa những tinh hoa từ đời MacBook tốt nhất cùng với những nâng cấp đáng kể trong nhiều năm qua, Macbook Pro 14 inch dự kiến sẽ là mẫu laptop làm cho giới công nghệ "phát sốt", cũng như là cỗ máy xử lý công việc tối ưu hiệu quả.',3,N'pro_2021.png',3)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (19,N'Laptop Asus Vivobook X415EA BV451W',6990000,N'Laptop Asus Vivobook X415EA BV451W hướng đến người dùng là học sinh sinh viên và nhân viên văn phòng. Không chỉ sở hữu thiết kế sang trọng, nhỏ gọn mà còn được trang bị cấu hình mang lại hiệu năng ổn định.',4,N'7_15_13.png',4)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (20,N'Tai nghe Bluetooth JBL T115BT',450000,N'Tai nghe JBL T115BT sẽ là lựa chọn hết sức tuyệt vời với các bạn yêu thích các dòng tai nghe JBL có dây đeo cổ. Với dung lượng pin lên đến 8 tiếng, khả năng sạc nhanh trong 2h, công nghệ âm thanh độc quyền JBL Pure Bass Sound, driver 8.6mm dynamic cho âm thanh sống động.',5, N'jbl_t115bt_1.png',5)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 21 ,N'iPhone 14 Pro 128GB - Chính hãng VN/A', 24990000, N'iPhone 14 Pro sở hữu màn hình Dynamic Island cùng công nghệ Super Retina XDR mang lại trải nghiệm hình ảnh ấn tượng. Camera trên iPhone 14 Pro cũng được nâng cấp lên đến 48MP với nhiều công nghệ chụp mang lại hình ảnh chuẩn nhiếp ảnh gia. Hiệu năng iPhone 14 Pro cũng mạnh mẽ với con chip hàng đầu Apple A16 Bionic giúp các thao tác diễn ra nhanh chóng, bộ nhớ RAM 6GB mang lại đa nhiệm mượt mà và ổn định trong mọi tác vụ.', 1,N't_m_12.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 22,N'Samsung Galaxy A14 4G', 3840000, N'Samsung Galaxy A14 4G có màn hình rộng 6.6 inch, tần số quét 60Hz, cụm camera 50MP+5MP+2MP và camera selfie 13MP. Dung lượng pin của máy lên đến 5.000 mAh, sử dụng cả ngày dài, khi gần cạn pin nhanh chóng nạp đầy thông qua củ sạc đi kèm. Nhờ vậy, người dùng có thể dễ dàng lướt web, đắm mình trong thế giới giải trí hay tận hưởng khoảnh khắc vui vẻ bên cạnh người thân, gia đình.',2,N'fdeen_1_.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 23,N'Macbook Pro 14 inch 2021 | Chính hãng Apple Việt Nam',43990000,N'Kế thừa những tinh hoa từ đời MacBook tốt nhất cùng với những nâng cấp đáng kể trong nhiều năm qua, Macbook Pro 14 inch dự kiến sẽ là mẫu laptop làm cho giới công nghệ "phát sốt", cũng như là cỗ máy xử lý công việc tối ưu hiệu quả.',3,N'pro_2021.png',3)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (24,N'Laptop Asus Vivobook X415EA BV451W',6990000,N'Laptop Asus Vivobook X415EA BV451W hướng đến người dùng là học sinh sinh viên và nhân viên văn phòng. Không chỉ sở hữu thiết kế sang trọng, nhỏ gọn mà còn được trang bị cấu hình mang lại hiệu năng ổn định.',4,N'7_15_13.png',4)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (25,N'Tai nghe Bluetooth JBL T115BT',450000,N'Tai nghe JBL T115BT sẽ là lựa chọn hết sức tuyệt vời với các bạn yêu thích các dòng tai nghe JBL có dây đeo cổ. Với dung lượng pin lên đến 8 tiếng, khả năng sạc nhanh trong 2h, công nghệ âm thanh độc quyền JBL Pure Bass Sound, driver 8.6mm dynamic cho âm thanh sống động.',5, N'jbl_t115bt_1.png',5)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 26 ,N'iPhone 14 Pro 128GB - Chính hãng VN/A', 24990000, N'iPhone 14 Pro sở hữu màn hình Dynamic Island cùng công nghệ Super Retina XDR mang lại trải nghiệm hình ảnh ấn tượng. Camera trên iPhone 14 Pro cũng được nâng cấp lên đến 48MP với nhiều công nghệ chụp mang lại hình ảnh chuẩn nhiếp ảnh gia. Hiệu năng iPhone 14 Pro cũng mạnh mẽ với con chip hàng đầu Apple A16 Bionic giúp các thao tác diễn ra nhanh chóng, bộ nhớ RAM 6GB mang lại đa nhiệm mượt mà và ổn định trong mọi tác vụ.', 1,N't_m_12.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 27,N'Samsung Galaxy A14 4G', 3840000, N'Samsung Galaxy A14 4G có màn hình rộng 6.6 inch, tần số quét 60Hz, cụm camera 50MP+5MP+2MP và camera selfie 13MP. Dung lượng pin của máy lên đến 5.000 mAh, sử dụng cả ngày dài, khi gần cạn pin nhanh chóng nạp đầy thông qua củ sạc đi kèm. Nhờ vậy, người dùng có thể dễ dàng lướt web, đắm mình trong thế giới giải trí hay tận hưởng khoảnh khắc vui vẻ bên cạnh người thân, gia đình.',2,N'fdeen_1_.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 28,N'Macbook Pro 14 inch 2021 | Chính hãng Apple Việt Nam',43990000,N'Kế thừa những tinh hoa từ đời MacBook tốt nhất cùng với những nâng cấp đáng kể trong nhiều năm qua, Macbook Pro 14 inch dự kiến sẽ là mẫu laptop làm cho giới công nghệ "phát sốt", cũng như là cỗ máy xử lý công việc tối ưu hiệu quả.',3,N'pro_2021.png',3)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (29,N'Laptop Asus Vivobook X415EA BV451W',6990000,N'Laptop Asus Vivobook X415EA BV451W hướng đến người dùng là học sinh sinh viên và nhân viên văn phòng. Không chỉ sở hữu thiết kế sang trọng, nhỏ gọn mà còn được trang bị cấu hình mang lại hiệu năng ổn định.',4,N'7_15_13.png',4)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (30,N'Tai nghe Bluetooth JBL T115BT',450000,N'Tai nghe JBL T115BT sẽ là lựa chọn hết sức tuyệt vời với các bạn yêu thích các dòng tai nghe JBL có dây đeo cổ. Với dung lượng pin lên đến 8 tiếng, khả năng sạc nhanh trong 2h, công nghệ âm thanh độc quyền JBL Pure Bass Sound, driver 8.6mm dynamic cho âm thanh sống động.',5, N'jbl_t115bt_1.png',5)

INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 31 ,N'iPhone 14 Pro 128GB - Chính hãng VN/A', 24990000, N'iPhone 14 Pro sở hữu màn hình Dynamic Island cùng công nghệ Super Retina XDR mang lại trải nghiệm hình ảnh ấn tượng. Camera trên iPhone 14 Pro cũng được nâng cấp lên đến 48MP với nhiều công nghệ chụp mang lại hình ảnh chuẩn nhiếp ảnh gia. Hiệu năng iPhone 14 Pro cũng mạnh mẽ với con chip hàng đầu Apple A16 Bionic giúp các thao tác diễn ra nhanh chóng, bộ nhớ RAM 6GB mang lại đa nhiệm mượt mà và ổn định trong mọi tác vụ.', 1,N't_m_12.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 32,N'Samsung Galaxy A14 4G', 3840000, N'Samsung Galaxy A14 4G có màn hình rộng 6.6 inch, tần số quét 60Hz, cụm camera 50MP+5MP+2MP và camera selfie 13MP. Dung lượng pin của máy lên đến 5.000 mAh, sử dụng cả ngày dài, khi gần cạn pin nhanh chóng nạp đầy thông qua củ sạc đi kèm. Nhờ vậy, người dùng có thể dễ dàng lướt web, đắm mình trong thế giới giải trí hay tận hưởng khoảnh khắc vui vẻ bên cạnh người thân, gia đình.',2,N'fdeen_1_.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 33,N'Macbook Pro 14 inch 2021 | Chính hãng Apple Việt Nam',43990000,N'Kế thừa những tinh hoa từ đời MacBook tốt nhất cùng với những nâng cấp đáng kể trong nhiều năm qua, Macbook Pro 14 inch dự kiến sẽ là mẫu laptop làm cho giới công nghệ "phát sốt", cũng như là cỗ máy xử lý công việc tối ưu hiệu quả.',3,N'pro_2021.png',3)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (34,N'Laptop Asus Vivobook X415EA BV451W',6990000,N'Laptop Asus Vivobook X415EA BV451W hướng đến người dùng là học sinh sinh viên và nhân viên văn phòng. Không chỉ sở hữu thiết kế sang trọng, nhỏ gọn mà còn được trang bị cấu hình mang lại hiệu năng ổn định.',4,N'7_15_13.png',4)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (35,N'Tai nghe Bluetooth JBL T115BT',450000,N'Tai nghe JBL T115BT sẽ là lựa chọn hết sức tuyệt vời với các bạn yêu thích các dòng tai nghe JBL có dây đeo cổ. Với dung lượng pin lên đến 8 tiếng, khả năng sạc nhanh trong 2h, công nghệ âm thanh độc quyền JBL Pure Bass Sound, driver 8.6mm dynamic cho âm thanh sống động.',5, N'jbl_t115bt_1.png',5)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 36 ,N'iPhone 14 Pro 128GB - Chính hãng VN/A', 24990000, N'iPhone 14 Pro sở hữu màn hình Dynamic Island cùng công nghệ Super Retina XDR mang lại trải nghiệm hình ảnh ấn tượng. Camera trên iPhone 14 Pro cũng được nâng cấp lên đến 48MP với nhiều công nghệ chụp mang lại hình ảnh chuẩn nhiếp ảnh gia. Hiệu năng iPhone 14 Pro cũng mạnh mẽ với con chip hàng đầu Apple A16 Bionic giúp các thao tác diễn ra nhanh chóng, bộ nhớ RAM 6GB mang lại đa nhiệm mượt mà và ổn định trong mọi tác vụ.', 1,N't_m_12.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 37,N'Samsung Galaxy A14 4G', 3840000, N'Samsung Galaxy A14 4G có màn hình rộng 6.6 inch, tần số quét 60Hz, cụm camera 50MP+5MP+2MP và camera selfie 13MP. Dung lượng pin của máy lên đến 5.000 mAh, sử dụng cả ngày dài, khi gần cạn pin nhanh chóng nạp đầy thông qua củ sạc đi kèm. Nhờ vậy, người dùng có thể dễ dàng lướt web, đắm mình trong thế giới giải trí hay tận hưởng khoảnh khắc vui vẻ bên cạnh người thân, gia đình.',2,N'fdeen_1_.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 38,N'Macbook Pro 14 inch 2021 | Chính hãng Apple Việt Nam',43990000,N'Kế thừa những tinh hoa từ đời MacBook tốt nhất cùng với những nâng cấp đáng kể trong nhiều năm qua, Macbook Pro 14 inch dự kiến sẽ là mẫu laptop làm cho giới công nghệ "phát sốt", cũng như là cỗ máy xử lý công việc tối ưu hiệu quả.',3,N'pro_2021.png',3)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (39,N'Laptop Asus Vivobook X415EA BV451W',6990000,N'Laptop Asus Vivobook X415EA BV451W hướng đến người dùng là học sinh sinh viên và nhân viên văn phòng. Không chỉ sở hữu thiết kế sang trọng, nhỏ gọn mà còn được trang bị cấu hình mang lại hiệu năng ổn định.',4,N'7_15_13.png',4)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (40,N'Tai nghe Bluetooth JBL T115BT',450000,N'Tai nghe JBL T115BT sẽ là lựa chọn hết sức tuyệt vời với các bạn yêu thích các dòng tai nghe JBL có dây đeo cổ. Với dung lượng pin lên đến 8 tiếng, khả năng sạc nhanh trong 2h, công nghệ âm thanh độc quyền JBL Pure Bass Sound, driver 8.6mm dynamic cho âm thanh sống động.',5, N'jbl_t115bt_1.png',5)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 41 ,N'iPhone 14 Pro 128GB - Chính hãng VN/A', 24990000, N'iPhone 14 Pro sở hữu màn hình Dynamic Island cùng công nghệ Super Retina XDR mang lại trải nghiệm hình ảnh ấn tượng. Camera trên iPhone 14 Pro cũng được nâng cấp lên đến 48MP với nhiều công nghệ chụp mang lại hình ảnh chuẩn nhiếp ảnh gia. Hiệu năng iPhone 14 Pro cũng mạnh mẽ với con chip hàng đầu Apple A16 Bionic giúp các thao tác diễn ra nhanh chóng, bộ nhớ RAM 6GB mang lại đa nhiệm mượt mà và ổn định trong mọi tác vụ.', 1,N't_m_12.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 42,N'Samsung Galaxy A14 4G', 3840000, N'Samsung Galaxy A14 4G có màn hình rộng 6.6 inch, tần số quét 60Hz, cụm camera 50MP+5MP+2MP và camera selfie 13MP. Dung lượng pin của máy lên đến 5.000 mAh, sử dụng cả ngày dài, khi gần cạn pin nhanh chóng nạp đầy thông qua củ sạc đi kèm. Nhờ vậy, người dùng có thể dễ dàng lướt web, đắm mình trong thế giới giải trí hay tận hưởng khoảnh khắc vui vẻ bên cạnh người thân, gia đình.',2,N'fdeen_1_.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 43,N'Macbook Pro 14 inch 2021 | Chính hãng Apple Việt Nam',43990000,N'Kế thừa những tinh hoa từ đời MacBook tốt nhất cùng với những nâng cấp đáng kể trong nhiều năm qua, Macbook Pro 14 inch dự kiến sẽ là mẫu laptop làm cho giới công nghệ "phát sốt", cũng như là cỗ máy xử lý công việc tối ưu hiệu quả.',3,N'pro_2021.png',3)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (44,N'Laptop Asus Vivobook X415EA BV451W',6990000,N'Laptop Asus Vivobook X415EA BV451W hướng đến người dùng là học sinh sinh viên và nhân viên văn phòng. Không chỉ sở hữu thiết kế sang trọng, nhỏ gọn mà còn được trang bị cấu hình mang lại hiệu năng ổn định.',4,N'7_15_13.png',4)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (45,N'Tai nghe Bluetooth JBL T115BT',450000,N'Tai nghe JBL T115BT sẽ là lựa chọn hết sức tuyệt vời với các bạn yêu thích các dòng tai nghe JBL có dây đeo cổ. Với dung lượng pin lên đến 8 tiếng, khả năng sạc nhanh trong 2h, công nghệ âm thanh độc quyền JBL Pure Bass Sound, driver 8.6mm dynamic cho âm thanh sống động.',5, N'jbl_t115bt_1.png',5)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 46 ,N'iPhone 14 Pro 128GB - Chính hãng VN/A', 24990000, N'iPhone 14 Pro sở hữu màn hình Dynamic Island cùng công nghệ Super Retina XDR mang lại trải nghiệm hình ảnh ấn tượng. Camera trên iPhone 14 Pro cũng được nâng cấp lên đến 48MP với nhiều công nghệ chụp mang lại hình ảnh chuẩn nhiếp ảnh gia. Hiệu năng iPhone 14 Pro cũng mạnh mẽ với con chip hàng đầu Apple A16 Bionic giúp các thao tác diễn ra nhanh chóng, bộ nhớ RAM 6GB mang lại đa nhiệm mượt mà và ổn định trong mọi tác vụ.', 1,N't_m_12.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 47,N'Samsung Galaxy A14 4G', 3840000, N'Samsung Galaxy A14 4G có màn hình rộng 6.6 inch, tần số quét 60Hz, cụm camera 50MP+5MP+2MP và camera selfie 13MP. Dung lượng pin của máy lên đến 5.000 mAh, sử dụng cả ngày dài, khi gần cạn pin nhanh chóng nạp đầy thông qua củ sạc đi kèm. Nhờ vậy, người dùng có thể dễ dàng lướt web, đắm mình trong thế giới giải trí hay tận hưởng khoảnh khắc vui vẻ bên cạnh người thân, gia đình.',2,N'fdeen_1_.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 48,N'Macbook Pro 14 inch 2021 | Chính hãng Apple Việt Nam',43990000,N'Kế thừa những tinh hoa từ đời MacBook tốt nhất cùng với những nâng cấp đáng kể trong nhiều năm qua, Macbook Pro 14 inch dự kiến sẽ là mẫu laptop làm cho giới công nghệ "phát sốt", cũng như là cỗ máy xử lý công việc tối ưu hiệu quả.',3,N'pro_2021.png',3)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (49,N'Laptop Asus Vivobook X415EA BV451W',6990000,N'Laptop Asus Vivobook X415EA BV451W hướng đến người dùng là học sinh sinh viên và nhân viên văn phòng. Không chỉ sở hữu thiết kế sang trọng, nhỏ gọn mà còn được trang bị cấu hình mang lại hiệu năng ổn định.',4,N'7_15_13.png',4)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (50,N'Tai nghe Bluetooth JBL T115BT',450000,N'Tai nghe JBL T115BT sẽ là lựa chọn hết sức tuyệt vời với các bạn yêu thích các dòng tai nghe JBL có dây đeo cổ. Với dung lượng pin lên đến 8 tiếng, khả năng sạc nhanh trong 2h, công nghệ âm thanh độc quyền JBL Pure Bass Sound, driver 8.6mm dynamic cho âm thanh sống động.',5, N'jbl_t115bt_1.png',5)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 51 ,N'iPhone 14 Pro 128GB - Chính hãng VN/A', 24990000, N'iPhone 14 Pro sở hữu màn hình Dynamic Island cùng công nghệ Super Retina XDR mang lại trải nghiệm hình ảnh ấn tượng. Camera trên iPhone 14 Pro cũng được nâng cấp lên đến 48MP với nhiều công nghệ chụp mang lại hình ảnh chuẩn nhiếp ảnh gia. Hiệu năng iPhone 14 Pro cũng mạnh mẽ với con chip hàng đầu Apple A16 Bionic giúp các thao tác diễn ra nhanh chóng, bộ nhớ RAM 6GB mang lại đa nhiệm mượt mà và ổn định trong mọi tác vụ.', 1,N't_m_12.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 52,N'Samsung Galaxy A14 4G', 3840000, N'Samsung Galaxy A14 4G có màn hình rộng 6.6 inch, tần số quét 60Hz, cụm camera 50MP+5MP+2MP và camera selfie 13MP. Dung lượng pin của máy lên đến 5.000 mAh, sử dụng cả ngày dài, khi gần cạn pin nhanh chóng nạp đầy thông qua củ sạc đi kèm. Nhờ vậy, người dùng có thể dễ dàng lướt web, đắm mình trong thế giới giải trí hay tận hưởng khoảnh khắc vui vẻ bên cạnh người thân, gia đình.',2,N'fdeen_1_.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 53,N'Macbook Pro 14 inch 2021 | Chính hãng Apple Việt Nam',43990000,N'Kế thừa những tinh hoa từ đời MacBook tốt nhất cùng với những nâng cấp đáng kể trong nhiều năm qua, Macbook Pro 14 inch dự kiến sẽ là mẫu laptop làm cho giới công nghệ "phát sốt", cũng như là cỗ máy xử lý công việc tối ưu hiệu quả.',3,N'pro_2021.png',3)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (54,N'Laptop Asus Vivobook X415EA BV451W',6990000,N'Laptop Asus Vivobook X415EA BV451W hướng đến người dùng là học sinh sinh viên và nhân viên văn phòng. Không chỉ sở hữu thiết kế sang trọng, nhỏ gọn mà còn được trang bị cấu hình mang lại hiệu năng ổn định.',4,N'7_15_13.png',4)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (55,N'Tai nghe Bluetooth JBL T115BT',450000,N'Tai nghe JBL T115BT sẽ là lựa chọn hết sức tuyệt vời với các bạn yêu thích các dòng tai nghe JBL có dây đeo cổ. Với dung lượng pin lên đến 8 tiếng, khả năng sạc nhanh trong 2h, công nghệ âm thanh độc quyền JBL Pure Bass Sound, driver 8.6mm dynamic cho âm thanh sống động.',5, N'jbl_t115bt_1.png',5)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 56 ,N'iPhone 14 Pro 128GB - Chính hãng VN/A', 24990000, N'iPhone 14 Pro sở hữu màn hình Dynamic Island cùng công nghệ Super Retina XDR mang lại trải nghiệm hình ảnh ấn tượng. Camera trên iPhone 14 Pro cũng được nâng cấp lên đến 48MP với nhiều công nghệ chụp mang lại hình ảnh chuẩn nhiếp ảnh gia. Hiệu năng iPhone 14 Pro cũng mạnh mẽ với con chip hàng đầu Apple A16 Bionic giúp các thao tác diễn ra nhanh chóng, bộ nhớ RAM 6GB mang lại đa nhiệm mượt mà và ổn định trong mọi tác vụ.', 1,N't_m_12.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 57,N'Samsung Galaxy A14 4G', 3840000, N'Samsung Galaxy A14 4G có màn hình rộng 6.6 inch, tần số quét 60Hz, cụm camera 50MP+5MP+2MP và camera selfie 13MP. Dung lượng pin của máy lên đến 5.000 mAh, sử dụng cả ngày dài, khi gần cạn pin nhanh chóng nạp đầy thông qua củ sạc đi kèm. Nhờ vậy, người dùng có thể dễ dàng lướt web, đắm mình trong thế giới giải trí hay tận hưởng khoảnh khắc vui vẻ bên cạnh người thân, gia đình.',2,N'fdeen_1_.png',1)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES ( 58,N'Macbook Pro 14 inch 2021 | Chính hãng Apple Việt Nam',43990000,N'Kế thừa những tinh hoa từ đời MacBook tốt nhất cùng với những nâng cấp đáng kể trong nhiều năm qua, Macbook Pro 14 inch dự kiến sẽ là mẫu laptop làm cho giới công nghệ "phát sốt", cũng như là cỗ máy xử lý công việc tối ưu hiệu quả.',3,N'pro_2021.png',3)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (59,N'Laptop Asus Vivobook X415EA BV451W',6990000,N'Laptop Asus Vivobook X415EA BV451W hướng đến người dùng là học sinh sinh viên và nhân viên văn phòng. Không chỉ sở hữu thiết kế sang trọng, nhỏ gọn mà còn được trang bị cấu hình mang lại hiệu năng ổn định.',4,N'7_15_13.png',4)
INSERT [dbo].[Products] ([ProductID], [NamePro], [Price], [DecriptionPro], [Category], [ImagePro], [ParentID]) VALUES (60,N'Tai nghe Bluetooth JBL T115BT',450000,N'Tai nghe JBL T115BT sẽ là lựa chọn hết sức tuyệt vời với các bạn yêu thích các dòng tai nghe JBL có dây đeo cổ. Với dung lượng pin lên đến 8 tiếng, khả năng sạc nhanh trong 2h, công nghệ âm thanh độc quyền JBL Pure Bass Sound, driver 8.6mm dynamic cho âm thanh sống động.',5, N'jbl_t115bt_1.png',5)


INSERT INTO ADMIN VALUES('admin', 'admin', N'Nguyễn Văn A', 'ADMIN')
INSERT INTO ADMIN VALUES('user', 'user', N'Nguyễn Văn B', 'ADMIN')


SET IDENTITY_INSERT [dbo].[Products] ON
SET IDENTITY_INSERT [dbo].[Products] OFF

SET IDENTITY_INSERT [dbo].[OrderPro] ON
SET IDENTITY_INSERT [dbo].[OrderPro] OFF
INSERT [dbo].[OrderPro] ([ID], [IDCus], [DateOrder], [Trigia], [Dagiao], [Ngaygiaohang]) VALUES (1, 1, CAST(0x9D500000 AS SmallDateTime),  CAST(75000.00 AS Decimal(9, 2)), 0, CAST(0x9D500000 AS SmallDateTime))
INSERT [dbo].[OrderPro] ([ID], [IDCus], [DateOrder], [Trigia], [Dagiao], [Ngaygiaohang]) VALUES (2, 1, CAST(0x9DA30000 AS SmallDateTime),  CAST(80000.00 AS Decimal(9, 2)), 0, CAST(0x9DA30000 AS SmallDateTime))
SET IDENTITY_INSERT [dbo].[DONDATHANG] OFF

INSERT [dbo].[OrderDetail] ([IDOrder], [IDProduct], [Quantity], [UnitPrice]) VALUES (1, 1, 1, 25000)
INSERT [dbo].[OrderDetail] ([IDOrder], [IDProduct], [Quantity], [UnitPrice]) VALUES (1, 2, 2, 25000)
INSERT [dbo].[OrderDetail] ([IDOrder], [IDProduct], [Quantity], [UnitPrice]) VALUES (2, 3, 1, 26000)
INSERT [dbo].[OrderDetail] ([IDOrder], [IDProduct], [Quantity], [UnitPrice]) VALUES (2, 4, 3, 18000)

SET IDENTITY_INSERT [dbo].[OrderDeTail] ON
SET IDENTITY_INSERT [dbo].[OrderDeTail] OFF

alter table [dbo].[Products] add ParentID int

create procedure Sp_GetReportProductByYear

alter table [dbo].[OrderPro] ADD  TTrang bit default 1 null;







