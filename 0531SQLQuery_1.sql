USE test0520
CREATE TABLE [訂單資料_1](
	訂單編號 int,
	產品編號 nchar(3),
	單價 int,
	數量 int
) ON [PRIMARY]
go

--刪除資料表
drop table 訂單資料_1
go

--建立計算欄位
create table 訂單明細_1(
	訂單編號 int not null,
	產品編號 nchar(3) not null,
	單價 int,
	數量 int,
	小計 AS 單價*數量 --AS不可省略
)

--建立訂單資料表,訂單編號,客戶編號,下單日期

create table 訂單(
	訂單編號 int not null primary key,
	產品編號 nchar(3) not null,
	下單日期 datetime not null)
go

--刪除資料表
drop table 訂單明細_1
go

--建立複合主鍵
create table 訂單明細_1(
	訂單編號 int ,
	產品編號 nchar(3) ,
	單價 int,
	數量 int,
	CONSTRAINT PK_訂單明細_1_訂單產品 PRIMARY KEY(訂單編號,產品編號)
)
go

