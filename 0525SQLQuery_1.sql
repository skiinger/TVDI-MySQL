use master 

select * from sys.databases
go

create database test0520
go

DROP database test0520
go

--單行註解
--建立test0520資料庫，並將資料放在D:\DB
create database test0520
on( name = test0520_1,
	filename = 'D:\DB\test0520_1.mdf')


/*
請建立test0520資料庫，並將資料檔放在D:\DB
初始值為20MB，不限制最大值，自動成長20MB

另建1群組，群組中有一個資料檔放在D:\DB
初始值為20MB，不限制最大值，自動成長20MB

另記錄檔LOG，初始值為15MB，最大值1G
自動成長為30%
*/
create database test0520
on( name = test0520,
	filename = 'D:\DB\test0520_1.mdf',
	size = 20mb ,
	maxsize = unlimited ,
	filegrowth = 20mb),
	FILEGROUP G1
	( name = G1,
	filename = 'D:\DB\test0520_GROUP.ndf',
	size = 20mb ,
	maxsize = unlimited ,
	filegrowth = 20mb)
log on( name = test0520_log,
	filename = 'D:\LOG\test0520_log.ldf',
	size = 15mb ,
	maxsize = 1gb ,
	filegrowth = 30%)

--卸離資料庫
sp_detach_db test0520
go

--附加資料庫(原位置附加)
sp_attach_db test0520 , 'D:\db\test0520_1.mdf'
go

--附加資料庫(不同位置附加)
sp_attach_db test0520   , 'D:\text0520\test0520_1.mdf'
						, 'D:\text0520\test0520_GROUP.ndf' 
						, 'D:\text0520\test0520_log.ldf'

--附加資料庫(不同位置附加 create database ...for attach)
create database test0520 on
(filename = 'd:\text0520\test0520_1.mdf'),
(filename = 'D:\text0520\test0520_GROUP.ndf'),
(filename = 'D:\text0520\test0520_log.ldf')
for attach 
go

--變更資料檔初始值
alter database test0520 MODIFY FILE (NAME = 'test0520' ,size=60MB)


/*在primary群組中增加一個資料檔
  名稱自訂，初始30MB，最大值2GB，自動成長30%
*/
  alter database test0520 add FILE 
  (NAME = text0525,
  filename = 'D:\text0520\test0525.ndf',
	size=30MB,
	maxsize = 2gb ,
	filegrowth = 30%
	)
	to filegroup [primary]

/*在G1群組中稱增加一個資料檔
  名稱自定，初始30MB，最大值2GB，自動成長30%

  */
  alter database test0520 add FILE 
  (NAME = G1_0525,
  filename = 'D:\text0520\G1_0525.ndf',
	size=30MB,
	maxsize = 2gb ,
	filegrowth = 30%
	)
  to filegroup G1

--查詢資料庫
sp_helpdb test0520

--刪除剛剛創建的2個資料檔
alter database test0520 REMOVE FILE  G1_0525
go
alter database test0520 REMOVE FILE  text0525
go

--查詢群組
sp_helpfilegroup
--新增G2群組
alter database test0520 add FILEGROUP G2
--刪除群組
alter database test0520 remove FILEGROUP G2
