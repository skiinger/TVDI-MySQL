--  DDL�y�k�m��
/*
�إ߸�ƮwTestDB,��Ʈw�n���T���ɮ׸s��(�t�w�]�s��),�C�s�ջݦ��G�Ӹ����,
�C�Ӹ���ɪ�l�e�q30MB,�C������30%,�̤j����2G,
�إߨ�ӰO����,��l�e�q10MB,����10MB,�̤j����2G,
����ɽЦsD:\DataBase�ؿ�,�O���ɽЦsD:\DBLog�ؿ�
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
--������Ʈw
sp_detach_db testdb
go
--���[��Ʈw
sp_attach_db testdb , 'D:\DataBase\textdb_1.mdf'
go
--�bPrimary�s�ո̷s�W�@�Ӹ���ɮ� DB3.NDF
alter database testdb add FILE 
(NAME =  DB3,
filename = 'D:\text0520\ DB3.ndf'
)
to filegroup [primary]

--�R������ɮ� DB3.NDF
alter database testdb REMOVE FILE  DB3
go
--�зs�W�@���ɮ׸s��G3
alter database testdb add FILEGROUP G3
go
sp_helpfilegroup
--�s�W�@�Ӹ���ɮ�G3_DB1
alter database testdb add FILE 
(NAME = G3_DB1,
filename = 'D:\text0520\G3_DB1.ndf',
size=30MB,
maxsize = 2gb ,
filegrowth = 30%
)
to filegroup G3
--�N�ɮ׸s��G3�קאּDefault�s��

alter database testdb modify filegroup G3 default;
go

--�NPrimary�s�ո̪�����ɮת�������̤j��
alter database testdb MODIFY FILE (NAME = 'test01' ,maxsize=unlimited)
go
alter database testdb MODIFY FILE (NAME = 'test02' ,maxsize=unlimited)
go
--�s�W�@�ӰO����DB_Log_3,�ɮפj�p500MB
  alter database testdb add LOG FILE 
  (NAME = DB_Log_3,
  filename = 'D:\DBLog\DB_Log_3.ldf',
	size=500MB
	)
