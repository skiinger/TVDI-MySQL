--客戶資料表 調整[名稱]長度
alter table 客戶 alter column 名稱 nvarchar(50)
go

--客戶資料表 增加[聯絡人]長度
alter table 客戶 add 聯絡人 nvarchar(20)
go
select * from 客戶
go
update 客戶 set 聯絡人='未提供'
alter table 客戶 alter column 聯絡人 nvarchar(20)
go

--客戶資料表 刪除[聯絡人]長度
alter table 客戶 drop column 聯絡人
go
