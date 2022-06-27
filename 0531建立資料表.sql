--建立資料表
create table 訂單明細_1(
	訂單編號 int ,
	產品編號 nchar(3),
	單價 int ,
	數量 int
)
go

--刪除資料表
drop table 訂單明細_1
go

--建立計算欄位
create table 訂單明細_1(
	訂單編號 int not null ,
	產品編號 nchar(3) not null,
	單價 int ,
	數量 int,
	小計 AS 單價*數量   --as不可省略
)
go


---建立訂單資料表,訂單編號,客戶編號,下單日期(主鍵由單1欄位扮演)
create table 訂單(
	訂單編號 int not null primary key,
	客戶編號 nchar(3) not null,
	下單日期 datetime not null)
go
drop table 訂單
go
create table 訂單(
	訂單編號 int not null ,
	客戶編號 nchar(3) not null,
	下單日期 datetime constraint DF_訂單_下單日期 default getdate()
	constraint pk_訂單_訂單編號 primary key (訂單編號))
go
--查詢系統日期
select getdate()
go
--新增1筆資料
insert 訂單 values(2,'C01',default)
go
--查詢訂單資料
select * from 訂單
GO

--刪除資料表
drop table 訂單明細_1
go

--建立複合主鍵
create table 訂單明細_1(
	訂單編號 int ,
	產品編號 nchar(3),
	單價 int ,
	數量 int
	CONSTRAINT PK_訂單明細_1_訂單產品 PRIMARY KEY (訂單編號,產品編號)
)
go

--建客戶資料表(編號（PK）,客戶名稱,統一編號（UIQ）,聯絡電話,地址)
CREATE TABLE 客戶
(  編號  int NOT NULL,
   名稱  nvarchar(30) not null,
   統一編號  nchar(8)  ,  
   聯絡電話  nvarchar(20),
   地址		 nvarchar(50)   
   CONSTRAINT [PK_客戶_編號] PRIMARY KEY (編號) ,
   CONSTRAINT [UIQ_客戶_統一編號] UNIQUE (統一編號)) 
go

insert 客戶 values (1,'臺北市職能發展學院','12345678','02-28721940','臺北市士林區士東路301號')
insert 客戶 values (2,'臺北市政府',NULL,NULL,'臺北市市府路')
insert 客戶 values (3,'臺北市勞動局','22222222',NULL,NULL)
go

select * from 客戶

--建立具CHECK條件約束的客戶資料表
drop table 客戶
GO
CREATE TABLE 客戶
(  編號  int NOT NULL,
   名稱  nvarchar(30) not null,
   統一編號  nchar(8)  ,  
   聯絡電話  nvarchar(20),
   地址		 nvarchar(50)   
   CONSTRAINT [PK_客戶_編號] PRIMARY KEY (編號) ,
   CONSTRAINT [UIQ_客戶_統一編號] UNIQUE (統一編號),
   CONSTRAINT [CK_客戶_電話地址] CHECK (聯絡電話 is not null OR 地址 is not null)) 
go


---檢核訂單明細的數量只能填入1~100
drop table 訂單明細
go

create table 訂單明細(
	訂單編號 int ,
	產品編號 nchar(3),
	單價 int ,
	數量 int,
	小計 AS 單價*數量

	CONSTRAINT PK_訂單明細_訂單產品 PRIMARY KEY (訂單編號,產品編號),
	CONSTRAINT CK_訂單明細_數量 CHECK (數量 Between 1 AND 100)
)
go

insert 訂單明細  (訂單編號,產品編號,單價,數量) values (3,'P01',250,101)
go

select * from 訂單明細


--建立外來鍵參考

drop table 訂單明細
go

create table 訂單明細(
	訂單編號 int ,
	產品編號 nchar(3),
	單價 int ,
	數量 int,
	小計 AS 單價*數量

	CONSTRAINT PK_訂單明細_訂單產品 PRIMARY KEY (訂單編號,產品編號),
	CONSTRAINT CK_訂單明細_數量 CHECK (數量 Between 1 AND 100),
	CONSTRAINT FK_訂單明細_訂單_訂單編號 FOREIGN KEY (訂單編號) REFERENCES  訂單(訂單編號)
)
go

select * from 訂單
insert 訂單 values (2,'C01',DEFAULT)
go

select * from 訂單明細
insert 訂單明細 values (1,'P01',50,500)
go
insert 訂單明細 values (1,'P02',100,30)
go

--新增失敗，無法參考訂單編號--->3
insert 訂單明細 values (3,'P02',100,30)
go

--刪除訂單編號1，因主鍵己被參考，故無法刪除
select * from 訂單
go
delete 訂單 where 訂單編號=1
go

--查詢資料表的條件約束(table constraint)
sp_helpconstraint 訂單明細
go

