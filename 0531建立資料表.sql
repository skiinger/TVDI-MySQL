--�إ߸�ƪ�
create table �q�����_1(
	�q��s�� int ,
	���~�s�� nchar(3),
	��� int ,
	�ƶq int
)
go

--�R����ƪ�
drop table �q�����_1
go

--�إ߭p�����
create table �q�����_1(
	�q��s�� int not null ,
	���~�s�� nchar(3) not null,
	��� int ,
	�ƶq int,
	�p�p AS ���*�ƶq   --as���i�ٲ�
)
go


---�إ߭q���ƪ�,�q��s��,�Ȥ�s��,�U����(�D��ѳ�1����t)
create table �q��(
	�q��s�� int not null primary key,
	�Ȥ�s�� nchar(3) not null,
	�U���� datetime not null)
go
drop table �q��
go
create table �q��(
	�q��s�� int not null ,
	�Ȥ�s�� nchar(3) not null,
	�U���� datetime constraint DF_�q��_�U���� default getdate()
	constraint pk_�q��_�q��s�� primary key (�q��s��))
go
--�d�ߨt�Τ��
select getdate()
go
--�s�W1�����
insert �q�� values(2,'C01',default)
go
--�d�߭q����
select * from �q��
GO

--�R����ƪ�
drop table �q�����_1
go

--�إ߽ƦX�D��
create table �q�����_1(
	�q��s�� int ,
	���~�s�� nchar(3),
	��� int ,
	�ƶq int
	CONSTRAINT PK_�q�����_1_�q�沣�~ PRIMARY KEY (�q��s��,���~�s��)
)
go

--�ثȤ��ƪ�(�s���]PK�^,�Ȥ�W��,�Τ@�s���]UIQ�^,�p���q��,�a�})
CREATE TABLE �Ȥ�
(  �s��  int NOT NULL,
   �W��  nvarchar(30) not null,
   �Τ@�s��  nchar(8)  ,  
   �p���q��  nvarchar(20),
   �a�}		 nvarchar(50)   
   CONSTRAINT [PK_�Ȥ�_�s��] PRIMARY KEY (�s��) ,
   CONSTRAINT [UIQ_�Ȥ�_�Τ@�s��] UNIQUE (�Τ@�s��)) 
go

insert �Ȥ� values (1,'�O�_��¾��o�i�ǰ|','12345678','02-28721940','�O�_���h�L�Ϥh�F��301��')
insert �Ȥ� values (2,'�O�_���F��',NULL,NULL,'�O�_��������')
insert �Ȥ� values (3,'�O�_���Ұʧ�','22222222',NULL,NULL)
go

select * from �Ȥ�

--�إߨ�CHECK����������Ȥ��ƪ�
drop table �Ȥ�
GO
CREATE TABLE �Ȥ�
(  �s��  int NOT NULL,
   �W��  nvarchar(30) not null,
   �Τ@�s��  nchar(8)  ,  
   �p���q��  nvarchar(20),
   �a�}		 nvarchar(50)   
   CONSTRAINT [PK_�Ȥ�_�s��] PRIMARY KEY (�s��) ,
   CONSTRAINT [UIQ_�Ȥ�_�Τ@�s��] UNIQUE (�Τ@�s��),
   CONSTRAINT [CK_�Ȥ�_�q�ܦa�}] CHECK (�p���q�� is not null OR �a�} is not null)) 
go


---�ˮ֭q����Ӫ��ƶq�u���J1~100
drop table �q�����
go

create table �q�����(
	�q��s�� int ,
	���~�s�� nchar(3),
	��� int ,
	�ƶq int,
	�p�p AS ���*�ƶq

	CONSTRAINT PK_�q�����_�q�沣�~ PRIMARY KEY (�q��s��,���~�s��),
	CONSTRAINT CK_�q�����_�ƶq CHECK (�ƶq Between 1 AND 100)
)
go

insert �q�����  (�q��s��,���~�s��,���,�ƶq) values (3,'P01',250,101)
go

select * from �q�����


--�إߥ~����Ѧ�

drop table �q�����
go

create table �q�����(
	�q��s�� int ,
	���~�s�� nchar(3),
	��� int ,
	�ƶq int,
	�p�p AS ���*�ƶq

	CONSTRAINT PK_�q�����_�q�沣�~ PRIMARY KEY (�q��s��,���~�s��),
	CONSTRAINT CK_�q�����_�ƶq CHECK (�ƶq Between 1 AND 100),
	CONSTRAINT FK_�q�����_�q��_�q��s�� FOREIGN KEY (�q��s��) REFERENCES  �q��(�q��s��)
)
go

select * from �q��
insert �q�� values (2,'C01',DEFAULT)
go

select * from �q�����
insert �q����� values (1,'P01',50,500)
go
insert �q����� values (1,'P02',100,30)
go

--�s�W���ѡA�L�k�Ѧҭq��s��--->3
insert �q����� values (3,'P02',100,30)
go

--�R���q��s��1�A�]�D��v�Q�ѦҡA�G�L�k�R��
select * from �q��
go
delete �q�� where �q��s��=1
go

--�d�߸�ƪ��������(table constraint)
sp_helpconstraint �q�����
go

