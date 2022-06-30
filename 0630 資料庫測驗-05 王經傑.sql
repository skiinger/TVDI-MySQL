------------------------------�椸�@�B�إ߸�Ʈw --------------------------
/*�@�B�бN Schdb_1.mdf ���[�ܰ������(instance)���C�Ъ`�N�U�C����G
1. ��Ʈw�W�١ySchDB�z�C 2. ����ɦ�m�yD:\DB\�z�C*/ 

create database SchDB
ON (FileName='D:\DB\Schdb_1.mdf')
FOR ATTACH
go

sp_attach_db schdb,'D:\DB\schdb_1.mdf'
go


use SchDB
go

/*�G�B�Цb�Ӹ�Ʈw���s�W 1 ���ɮ׸s�աyG1�z�A
�æb�Ӹs�դ��s�W 1 �Ӹ���� �ySchdb_2.ndf�z�A
��l�� 20MB�A�۰ʦ��� 50MB�C*/
alter database SchDB add FILEGROUP G1
go
alter database schdb
add file
(name=schdb_2,
filename='D:\DB\Schdb_2.ndf',
size=20MB,
filegrowth=50MB)to filegroup G1
go

--3-1�B�Ь��y�Z�šz�إߥD��(PK)�Υ~����(FK)�H�ŦX�W�����p�[�c
sp_helpconstraint �Z��
go
alter table �Z�� add constraint PK_�Z��_�нs�ҽs�ǭ� Primary KEY (�ҵ{�s��,�б½s��,�Ǹ�)
go
alter table �Z�� add constraint FK_�Z��_�нs Foreign KEY (�б½s��) references �б�(�б½s��)
go
alter table �Z�� add constraint FK_�Z��_�ҽs Foreign KEY (�ҵ{�s��) references �ҵ{(�ҵ{�s��)
go
alter table �Z�� add constraint FK_�Z��_�Ǹ� Foreign KEY (�Ǹ�) references �ǥ�(�Ǹ�)
go

--3-2�B�Ыإߡy�Ыǡz��ƪ�ܡyG1�z�s�աA�æs�J�H�U���
create table �Ы�
(�Ыǽs�� nchar(5) primary key,
�Ы� nvarchar(10) not null)
on G1
go

insert �Ы�
values 
('100-M','�@��Ы�1'),
('180-M','�@��Ы�2'),
('221-S','�S��Ы�1'),
('321-M','�@��Ы�3'),
('327-S','�S��Ы�1'),
('380-L','�M�~�Ы�1'),
('500-K','�M�~�Ы�2'),
('622-G','�M�~�Ы�3')
GO

--3-3�B�Ь��y���u�z��ƪ�إߡy�q�ܡz�����\�� NULLL ���ˬd����]5 ���^
alter table ���u with nocheck add constraint CK_���u_�q�� CHECK (�q�� is not null)
go
--3-4�B�бN�ҵ{�y�p�ⷧ�סz�אּ�y�p������סz�C
select * from �ҵ{ 
where �W��='�p�ⷧ��'
go
update �ҵ{ set �W��='�p�������' where �ҵ{�s��='CS101'
go

--3-5.�����yG1�z�s��
sp_helpdb schdb

drop TABLE �Ы�
go
alter database schdb remove file schdb_2
go
sp_helpfilegroup G1
go
alter database schdb remove FILEGROUP G1
go
--------------------------------�椸�G�B�򥻬d�ߡ]���Ʒ��^ --------------------------------
-- �@�B �d�ߡi�ǥ͡j��ƪ��Ҧ��ǥͪ��Ǹ��B�m�W�M�ͤ�A�Y�L��ƽХH�y�����ѡz ���
select �Ǹ�,�m�W,�ʧO,�q��,isnull(cast([�ͤ�] as varchar),'������') '�ͤ�'
from �ǥ�
go

--�G�B �p��C����u���~���b�B(���J-��X) 
select �m�W,(�~��-(�O�I+���|)) as [�~���b�B] from [���u]
go

--�T�B �p��ǥͪ��~�֡A�Y�L��ƽХH�y�����ѡz��� 

--�|�B ��X�~���̰����e 3 �W���u 
select * from ���u

select top 3  with ties �~�� 
from �ҵ{
order by �Ǥ� asc

--���B ��X�~���̧C���e 10%�W���u 

-- ���B �b�i�ҵ{�j��ƪ��X�Ǥ��Ƴ̤֪� 3 ���ҵ{�O����ơA���Y���ۦP�Ǥ��ƪ� �O���]�@����X�� 
select top 3  with ties �Ǥ� ,�W��
from �ҵ{
order by �Ǥ� asc

--�C�B �b�i�ǥ͡j��ƪ��X�Ҧ��k�P�Ǫ���ơC
select *
from �ǥ�
where �ʧO = '�k'
go
--�K�B �b�i�Z�šj��ƪ��X���X��ǥͤW CS203 ����
select count(�ҵ{�s��) 'CS203�W�ҤH��'
from �Z��
where �ҵ{�s�� = 'CS203'
go

--�E�B �b�i�Z�šj��ƪ��X�б� I002 �@�дX����
select COUNT(DISTINCT �ҵ{�s��) '�ҵ{�`��'
from �Z��
where �б½s�� = 'I002'
go

--�Q�B �b�i�Z�šj��ƪ�W�L 3 ��ǥͤW�Ҫ��ҵ{


--�Q�@�B �d�ߡi���u�j��ƪ�Ҧ����u���O�I�`�M�P���� 
select sum(�O�I) '���u�O�I�`�M',avg(�O�I) '���u�O�I����'
from ���u
go

--�Q�G�B �d�ߡi�Z�šj��ƪ��A�W�ұЫǬO�b�G�Ӫ����(�Ыǲ� 2 �X�N��Ӽh) 
select * 
from �Z��
where �Ы� like '_2%'
go

--�Q�T�B ��X 1990 �~ 2 ��� 1990 �~ 10 ��X�ͪ��ǥ� 
select * 
from �ǥ�
where year(�ͤ�) = 1990 and month(�ͤ�) not in (1,11,12)
go

--�Q�|�B �ǥͤw�g�פF CS101�BCS222�BCS100 �M CS213 ���|���ҡA�����ǥͬd�߬� ���٦�����ҵ{�i�H�� 

--�Q���B �Ч�X��b���A���o�S���d�q�ܪ����u 
select �m�W ,����,�q��
from ���u
where ���� = '���' and �q�� IS NULL
go

--�Q���B �d�ߡi�ҵ{�j��ƪ��ҵ{�s�����]�t'2'���r��A�H�νҵ{�W����즳'�{ ��'���r��ξǤ��j�󵥩� 4 ����� 
select *
from �ҵ{
where �ҵ{�s�� like '%2%' and (�W�� like '%�{%' or �Ǥ� >= 4)
go

--�Q�C�B �Ч�X�b���J�C�� 40000 �������u 
select �m�W, (�~��-�O�I-���|) '�b���J'
from ���u
where (�~��-�O�I-���|) < 40000
go

--�Q�K�B �вέp�i���u�j��ƪ��A�C�ӫ����������u�ơB�~���`�B�Υ����~�� 

--�Q�E�B �ХΡi�Z�šj��ƪ��X�u���б� 1 ���ҵ{���б� 

--�G�Q�B �ϥ� Grouping sets �p��б� I001 �M I003 �б½ҵ{���ǥͼơB�p�p�M�[


-------------------------�椸�T�B�i���d�ߡ]�h��Ʒ��^ ---------------------------
--�@�B�Ч�X�b���J�̰����Юv
select * from �б�
select * from ���u

select top 1 �m�W,(�~��-�O�I-���|) '�b���J'
FROM �б� t JOIN ���u e
ON t.�����Ҧr�� = e.�����Ҧr��
go

--�G�B--�д��Ѥ@���̾Ǹ����W�ƧǪ��ǥͭ׷~�ҵ{��ơA��ƻݥ]�t�Ǹ��B�ǥͩm�W�B�׷~�ҵ{�B�½ұб¡B�W�ұЫǤΤW�Үɶ� 
select * from �б�
select * from �Z��
select * from �ǥ�
select * from �ҵ{
select * from ���u

select c.�Ǹ�,s.�m�W,c.�W�Үɶ�,c.�Ы�,l.�W�� '�ҵ{',e.�m�W '�б©m�W'
FROM �б� t JOIN �Z�� c
ON t.�б½s�� = c.�б½s��
join �ǥ� s
on c.�Ǹ� = s.�Ǹ�
join �ҵ{ l
on c.�ҵ{�s�� = l.�ҵ{�s��
join ���u e
on t.�����Ҧr�� = e.�����Ҧr��
go

--�T�B �d�� 100-M�B221-S�B500-K ���ЫǩҶ}�]���ҵ{�P�W�Үɶ� 
--�|�B �έp�C�@���ҵ{���׽ҤH�ơA�åH�ҵ{�W�ٻ��W�Ƨ� 
--���B ��X�׽ҤH�ƧC�� 3 �H���ҵ{�W�� 
--���B ��X�ǥͻP���u�P�W�P�m���W�r 
--�C�B �ϥΤl�d�ߧ�X�~���W�L 5 �U�����u��� 
--�K�B �ШϥΤl�d�ߧ�X�~�����󥭧��Ȫ����u��� 
--�E�B �Эp��ǥͱi�L�ҥ��Ǵ�����Ҽ�(�мg�X�ϥΤl�d�ߤΤ����X�֬d�ߪ��y�k) 
--�Q�B �Ч�X�Ǹ� S004 �S���W���ҵ{�M��