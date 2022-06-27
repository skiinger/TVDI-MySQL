use master 

select * from sys.databases
go

create database test0520
go

DROP database test0520
go

--������
--�إ�test0520��Ʈw�A�ñN��Ʃ�bD:\DB
create database test0520
on( name = test0520_1,
	filename = 'D:\DB\test0520_1.mdf')


/*
�Ыإ�test0520��Ʈw�A�ñN����ɩ�bD:\DB
��l�Ȭ�20MB�A������̤j�ȡA�۰ʦ���20MB

�t��1�s�աA�s�դ����@�Ӹ���ɩ�bD:\DB
��l�Ȭ�20MB�A������̤j�ȡA�۰ʦ���20MB

�t�O����LOG�A��l�Ȭ�15MB�A�̤j��1G
�۰ʦ�����30%
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

--������Ʈw
sp_detach_db test0520
go

--���[��Ʈw(���m���[)
sp_attach_db test0520 , 'D:\db\test0520_1.mdf'
go

--���[��Ʈw(���P��m���[)
sp_attach_db test0520   , 'D:\text0520\test0520_1.mdf'
						, 'D:\text0520\test0520_GROUP.ndf' 
						, 'D:\text0520\test0520_log.ldf'

--���[��Ʈw(���P��m���[ create database ...for attach)
create database test0520 on
(filename = 'd:\text0520\test0520_1.mdf'),
(filename = 'D:\text0520\test0520_GROUP.ndf'),
(filename = 'D:\text0520\test0520_log.ldf')
for attach 
go

--�ܧ����ɪ�l��
alter database test0520 MODIFY FILE (NAME = 'test0520' ,size=60MB)


/*�bprimary�s�դ��W�[�@�Ӹ����
  �W�٦ۭq�A��l30MB�A�̤j��2GB�A�۰ʦ���30%
*/
  alter database test0520 add FILE 
  (NAME = text0525,
  filename = 'D:\text0520\test0525.ndf',
	size=30MB,
	maxsize = 2gb ,
	filegrowth = 30%
	)
	to filegroup [primary]

/*�bG1�s�դ��ټW�[�@�Ӹ����
  �W�٦۩w�A��l30MB�A�̤j��2GB�A�۰ʦ���30%

  */
  alter database test0520 add FILE 
  (NAME = G1_0525,
  filename = 'D:\text0520\G1_0525.ndf',
	size=30MB,
	maxsize = 2gb ,
	filegrowth = 30%
	)
  to filegroup G1

--�d�߸�Ʈw
sp_helpdb test0520

--�R�����Ыت�2�Ӹ����
alter database test0520 REMOVE FILE  G1_0525
go
alter database test0520 REMOVE FILE  text0525
go

--�d�߸s��
sp_helpfilegroup
--�s�WG2�s��
alter database test0520 add FILEGROUP G2
--�R���s��
alter database test0520 remove FILEGROUP G2
