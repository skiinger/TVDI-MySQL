--�Ȥ��ƪ� �վ�[�W��]����
alter table �Ȥ� alter column �W�� nvarchar(50)
go

--�Ȥ��ƪ� �W�[[�p���H]����
alter table �Ȥ� add �p���H nvarchar(20)
go
select * from �Ȥ�
go
update �Ȥ� set �p���H='������'
alter table �Ȥ� alter column �p���H nvarchar(20)
go

--�Ȥ��ƪ� �R��[�p���H]����
alter table �Ȥ� drop column �p���H
go
