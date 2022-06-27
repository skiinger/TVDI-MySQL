--  DDL語法練習
/*
建立資料庫TestDB,資料庫要有三個檔案群組(含預設群組),每群組需有二個資料檔,
每個資料檔初始容量30MB,每次成長30%,最大限制2G,
建立兩個記錄檔,初始容量10MB,成長10MB,最大限制2G,
資料檔請存D:\DataBase目錄,記錄檔請存D:\DBLog目錄
*/
create database testdb
on( name = test01,
	filename = 'D:\DataBase\textdb_1.mdf',
	size = 30mb ,
	maxsize = 2gb ,
	filegrowth = 30%),
	( name = test02,
	filename = 'D:\DataBase\textdb_2.ndf',
	size = 30mb ,
	maxsize = 2gb ,
	filegrowth = 30%),
	FILEGROUP G1
	( name = G1_1,
	filename = 'D:\DataBase\G1_1.ndf',
	size = 30mb ,
	maxsize = 2gb ,
	filegrowth = 30%),
	( name = G1_2,
	filename = 'D:\DataBase\G1_2.ndf',
	size = 30mb ,
	maxsize = 2gb ,
	filegrowth = 30%),
	FILEGROUP G2
	( name = G2_1,
	filename = 'D:\DataBase\G2_1.ndf',
	size = 30mb ,
	maxsize = 2gb ,
	filegrowth = 30%),
	( name = G2_2,
	filename = 'D:\DataBase\G2_2.ndf',
	size = 30mb ,
	maxsize = 2gb ,
	filegrowth = 30%)
log on( name = testdb_1_log_,
	filename = 'D:\DBLog\testdb_1_log.ldf',
	size = 10mb ,
	maxsize = 2gb ,
	filegrowth = 10mb),
	( name = testdb_2_log_,
	filename = 'D:\DBLog\testdb_2_log.ldf',
	size = 10mb ,
	maxsize = 2gb ,
	filegrowth = 10mb)

sp_helpdb testdb
--卸離資料庫
sp_detach_db testdb
go
--附加資料庫
sp_attach_db testdb , 'D:\DataBase\textdb_1.mdf'
go
--在Primary群組裡新增一個資料檔案 DB3.NDF
alter database testdb add FILE 
(NAME =  DB3,
filename = 'D:\text0520\ DB3.ndf'
)
to filegroup [primary]

--刪除資料檔案 DB3.NDF
alter database testdb REMOVE FILE  DB3
go
--請新增一個檔案群組G3
alter database testdb add FILEGROUP G3
go
sp_helpfilegroup
--新增一個資料檔案G3_DB1
alter database testdb add FILE 
(NAME = G3_DB1,
filename = 'D:\text0520\G3_DB1.ndf',
size=30MB,
maxsize = 2gb ,
filegrowth = 30%
)
to filegroup G3
--將檔案群組G3修改為Default群組

alter database testdb modify filegroup G3 default;
go

--將Primary群組裡的資料檔案的不限制最大值
alter database testdb MODIFY FILE (NAME = 'test01' ,maxsize=unlimited)
go
alter database testdb MODIFY FILE (NAME = 'test02' ,maxsize=unlimited)
go
--新增一個記錄檔DB_Log_3,檔案大小500MB
  alter database testdb add LOG FILE 
  (NAME = DB_Log_3,
  filename = 'D:\DBLog\DB_Log_3.ldf',
	size=500MB
	)
