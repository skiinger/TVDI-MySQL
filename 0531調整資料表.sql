--�Ȥ��ƪ�-�վ�y�W�١z����
alter table �Ȥ� alter column �W�� nvarchar(50)
go

--�Ȥ��ƪ�-�W�[�y�p���H�z���
alter table �Ȥ� add �p���H nvarchar(20) 
go
select * from �Ȥ�
go

--�Ȥ��ƪ�-�R���y�p���H�z���
alter table �Ȥ� drop column �p���H
go

--�R���Ȥ᪺�D��
sp_helpconstraint �Ȥ�
go

alter table �Ȥ� drop constraint PK_�Ȥ�_�s��
go

--���w�Ȥ��ƪ�D��
alter table �Ȥ� alter column �Τ@�s�� nchar(8) not null
go
alter table �Ȥ� add constraint PK_�Ȥ�_�s�� primary key (�Τ@�s��)
go

sp_helpconstraint �q�����

--�q����Ӫ��ƶq���u���J1-50
alter table �q����� drop constraint CK_�q�����_�ƶq
go
alter table �q����� add constraint CK_�q�����_�ƶq check (�ƶq between 1 and 50)
go
---�U����O�нƻs�K�W-----

create database DB0531
GO
use DB0531
go
--�s�W�������
CREATE TABLE �Ȥ�
(  �Ȥ�s��  int identity NOT NULL,
   �����Ҧr��  nchar(10) NOT NULL ,  
   �~��  tinyint ,
   �a�}  nvarchar(50),
   �q��  nchar(12))
go

insert into �Ȥ� (�����Ҧr��,�~��,�a�},�q��) values ('a1234565',25,'a123455','02889445')
go 100


select count(*) from �Ȥ�

select * from �Ȥ�

sp_helpconstraint �Ȥ�
--with NO check
alter table �Ȥ� with nocheck add constraint [CK_�Ȥ�q��] check (�q�� is not null)
go

--drop constraint
alter table �Ȥ� drop constraint [CK_�Ȥ�q��] 
go

--with check
alter table �Ȥ� add constraint [CK_�Ȥ�q��] check (�q�� is not null)
go


--�s�W�������Primary KEY
alter table �Ȥ� add constraint [PK_�Ȥ�s��] PRIMARY KEY (�Ȥ�s��)
go


--���J�@�ӽs���b�ѧO����
select * from �Ȥ�

alter table �Ȥ� add �Ȥ�m�W nvarchar(50)
delete �Ȥ� where �Ȥ�s��=1


SET IDENTITY_INSERT �Ȥ� ON


INSERT INTO �Ȥ� (�Ȥ�s��,�����Ҧr��,�a�},�q��) values (101,'A123456789','�x�_��','123456789')

SELECT * FROM �Ȥ�

SET IDENTITY_INSERT �Ȥ� OFF
go



--�Ѧҧ����
use DB0531
go


if exists (select * from sys.tables where name='�q��')
drop table �q��
go

if exists (select * from sys.tables where name='�Ȥ�')
drop table �Ȥ�
go


CREATE TABLE dbo.[�Ȥ�](
   �Ȥ�s��  int  not null,
   �Ȥ�m�W  nvarchar(20) not null,
   �����Ҧr��  nchar(10) not null,   
   �a�}  nvarchar(50),
   �q��  nvarchar(12),     
   CONSTRAINT [PK_�Ȥ�s��] PRIMARY KEY (�Ȥ�s��)   
)
go

CREATE TABLE dbo.[�q��](
	�q��s��  int identity not null,
    �Ȥ�s��  int	,
	�U����  datetime,	
	���  int,
	�ƶq  int,
	�p�p  as ���*�ƶq,
	CONSTRAINT [FK_�Ȥ�s��_�Ȥ�] FOREIGN KEY(�Ȥ�s��)
	REFERENCES [�Ȥ�](�Ȥ�s��)
)
go

INSERT [�Ȥ�] VALUES (1,'�p��','A123456789','�x�_��','1112233')
INSERT [�Ȥ�] VALUES (2,'�p�i','A234567890','�x�_��','3456221')
INSERT [�Ȥ�] VALUES (3,'�p��','A122343212','��饫','5454554')
INSERT [�Ȥ�] VALUES (4,'�p��','A125427565','�x����','5221456')

INSERT [�q��] VALUES (1,'2009/03/03 15:00:02',5,100)
INSERT [�q��] VALUES (1,'2009/03/04 15:15:30',6,120)
INSERT [�q��] VALUES (2,'2009/02/03 11:20:02',10,121)
INSERT [�q��] VALUES (2,'2009/03/01 15:50:30',8,50)
INSERT [�q��] VALUES (3,'2009/03/04 16:44:00',60,60)
INSERT [�q��] VALUES (3,'2009/03/04 09:33:00',2,80)
go

select * from �Ȥ�
select * from �q��

--�L�k�R���Ȥ�s���y1�z�����
DELETE �Ȥ� WHERE �Ȥ�s��=1
go

delete from �q�� where �Ȥ�s��=1
go

--�Ȯɰ��Υ~����Ѧ�
exec sp_helpconstraint �Ȥ�

alter table �q�� nocheck constraint [FK_�Ȥ�s��_�Ȥ�]
--�ҥ�
ALTER TABLE �q�� CHECK CONSTRAINT [FK_�Ȥ�s��_�Ȥ�]
go



--�ܧ�~����ѦҳB�z�覡
ALTER TABLE �q�� DROP CONSTRAINT  [FK_�Ȥ�s��_�Ȥ�]
go

sp_helpconstraint �q��
GO

ALTER TABLE �q�� ADD  CONSTRAINT  [FK_�Ȥ�s��_�Ȥ�] FOREIGN KEY (�Ȥ�s��) REFERENCES [�Ȥ�](�Ȥ�s��) 
  ON DELETE CASCADE  
  ON UPDATE CASCADE
go

SELECT * FROM �Ȥ�
SELECT * FROM �q��

UPDATE �Ȥ� SET �Ȥ�s��=5 WHERE �Ȥ�s��=3


delete �Ȥ� WHERE �Ȥ�s��=5


SELECT * FROM �Ȥ�
go



--delete AND Truncate
use master
go

if exists(select * from sys.databases where name='mydb')
drop database mydb
go

CREATE DATABASE MyDB
--�D�s�ժ������
ON primary(
	NAME=MyDB1,
	FileName='D:\DB\MyDB1.mdf',	
	SIZE=8MB),

--�s�ظs�ժ������
FileGroup G1(
	NAME=MyDB_G1_1,
	FileName='D:\DB\MyDB_G1_1.ndf',
	SIZE=8MB),
	(
	NAME=MyDB_G1_2,
	FileName='D:\DB\MyDB_G1_2.ndf',
	SIZE=8MB)
--�إ�Log��
Log ON (
	NAME=MyDB_Log,
	FileName='D:\DB\MyDB_Log.ldf'
	)
GO



use MYDB
go


CREATE TABLE �Ȥ�1
(  �Ȥ�s��  int identity NOT NULL,
   �����Ҧr��  nchar(10) NOT NULL ,  
   �~��  tinyint ,
   �a�}  nvarchar(50),
   �q��  nchar(12)) on [primary]
go

CREATE TABLE �Ȥ�2
(  �Ȥ�s��  int identity NOT NULL,
   �����Ҧr��  nchar(10) NOT NULL ,  
   �~��  tinyint ,
   �a�}  nvarchar(50),
   �q��  nchar(12)) on G1
go

insert into �Ȥ�1 values ('a1234565',25,'a123455',null)
go 2000000

insert into �Ȥ�2 values ('a1234565',25,'a123455',null)
go 2000000

select COUNT(*) from �Ȥ�1
select COUNT(*) from �Ȥ�2
select * from �Ȥ�1 
select * from �Ȥ�2

--�q�����M��
Truncate table �Ȥ�1

--�@���@���R��
delete from �Ȥ�2
go

use master
go

--�Ƥ���Ʈw
backup database mydb to disk ='D:\DB\mydb.bak'
go

drop database MyDB
go

--�٭��Ʈw
restore database mydb from disk='D:\DB\mydb.bak'
go

--�����ɤ��٦���ƮɡA�L�k�R�������
alter database mydb remove file MyDB_G1_2
go

--SHRINKFILE�i�H�N��Ʋ��X�ܦP�@�s�ժ�����ɤ�
DBCC SHRINKFILE (MyDB_G1_2, EMPTYFILE);  
GO 

sp_helpdb mydb

--�������ɦ��ΪŶ��A���i�C����l�Ȯe�q
DBCC SHRINKFILE (MYDB1,1)
go

--�������ɦ��ΪŶ��A���̦h���C����l�Ȯe�q
DBCC SHRINKDATABASE (mydb)
go

--������ƪ�
create database data0606 
ON (FileName='D:\DB\NorthwindC.mdf')
FOR ATTACH
go

use data0606
go

select COUNT(*) from �Ȥ�
select * from �Ȥ�
go

