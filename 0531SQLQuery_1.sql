USE test0520
CREATE TABLE [�q����_1](
	�q��s�� int,
	���~�s�� nchar(3),
	��� int,
	�ƶq int
) ON [PRIMARY]
go

--�R����ƪ�
drop table �q����_1
go

--�إ߭p�����
create table �q�����_1(
	�q��s�� int not null,
	���~�s�� nchar(3) not null,
	��� int,
	�ƶq int,
	�p�p AS ���*�ƶq --AS���i�ٲ�
)

--�إ߭q���ƪ�,�q��s��,�Ȥ�s��,�U����

create table �q��(
	�q��s�� int not null primary key,
	���~�s�� nchar(3) not null,
	�U���� datetime not null)
go

--�R����ƪ�
drop table �q�����_1
go

--�إ߽ƦX�D��
create table �q�����_1(
	�q��s�� int ,
	���~�s�� nchar(3) ,
	��� int,
	�ƶq int,
	CONSTRAINT PK_�q�����_1_�q�沣�~ PRIMARY KEY(�q��s��,���~�s��)
)
go

