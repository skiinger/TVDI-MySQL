--�д���1,3,5���O����b10~20����������P�⪺���~
select * from ���~��� where  ��� between 10 AND 20  AND  ���O�s�� in (1,3,5) AND ���A�P��=0 
GO


select * from ���~��� where ���~='ī�G��'
go


--Like �m��
--1.�Ч�X�Ȧ�Ȥ�
SELECT * FROM �Ȥ� WHERE ���q�W��  LIKE '%�Ȧ�'
GO

--2.�d�ߦb�������W��������
select * from ������ where �a�} like '%������%'
GO

--3.�d�߫Ȥ�W�ٲ�1�Ӧr�O�j�Τs�ΪF�����
select * from �Ȥ� where ���q�W�� like '[�j�s�F]%'
GO

--4.��X�Ȥ�s���̫�H AS �� AR �� OS �� OR ���������
select * from �Ȥ� where �Ȥ�s�� like '%[AO][SR]'
go

--5.��X�Ȥ�s���ĤG�Ӧr��NAO�γ̫�@�Ӧr��GHIJK���Ȥ���
select * from �Ȥ� where �Ȥ�s�� like '_[NAO]%[G-K]'
go


select count(*) from ���u



select distinct ¾�� from ���u

--�Эp����u¾�٦��h�ֺ�
select count(distinct ¾��) ¾�ٺ��� from ���u
go

--�вέp�ʧO�ƶq
select �٩I,count(���u�s��) �ƶq from ���u group by �٩I
GO

--�Эp��10590�q�檺�`��(���*�ƶq*(1-�馩))
select sum(���*�ƶq*(1-�馩)) �`�� from �q�f���� where  �q�渹�X=10590
GO

--�Эp��10590�P10591�q�檺�`��(���*�ƶq*(1-�馩))
select �q�渹�X,sum(���*�ƶq*(1-�馩)) �`�� from �q�f���� where  �q�渹�X in (10590,10591) group by �q�渹�X
GO


--�Эp��10590��10670�q�檺�`��(���*�ƶq*(1-�馩))�C��100
select �q�渹�X,sum(���*�ƶq*(1-�馩)) �`�� 
from �q�f���� 
where  �q�渹�X between 10590 and 10670
group by �q�渹�X
having sum(���*�ƶq*(1-�馩))<=100
GO










--with rollup
SELECT ���~�s��, ��� , SUM(�ƶq) [�`�ƶq]
FROM dbo.[�q�f����]
WHERE ���~�s�� IN (50,51)
Group By ���~�s��,���
WITH rollup

--with cube
SELECT ���~�s��, ��� , SUM(�ƶq) [�`�ƶq]
FROM dbo.[�q�f����]
WHERE ���~�s�� IN (50,51)
Group By ���~�s��,���
WITH cube


--grouping sets
SELECT ���~�s��, ��� , SUM(�ƶq) [�`�ƶq]
FROM dbo.[�q�f����]
WHERE ���~�s�� IN (50,51)
Group By grouping sets((���~�s��,���),���~�s��,())

--ORDER BY �Ƨ�
SELECT ���~�s��, ���, SUM(�ƶq) [�`�ƶq]
FROM dbo.[�q�f����]
WHERE ���~�s�� IN (50,51,52,53,54,55)
Group By ���~�s��,���
order by ���~�s�� desc,���

--�ʶR���Ƴ̦h��3�����~
select top  3 with ties ���~�s��,count(���~�s��) �ʶR����
FROM   �q�f����
group by ���~�s��
order by �ʶR���� DESC


--����
select * from �q�f�D��
ORDER BY �q�渹�X OFFSET 5 row
go

select * from �q�f�D��
ORDER BY �q�渹�X OFFSET 0 row FETCH NEXT 10 ROWS ONLY






--�ЦC�X�q��10590�M10621���ʶR�����~
select �q�f����.�q�渹�X,���~���.���~ 
from �q�f����  join  ���~���  on  �q�f����.���~�s��=���~���.���~�s��
where �q�f����.�q�渹�X in (10590,10621)
go



--�ЦC�X�q��10590��10621���Ȥ�W�١B�p���H�έt�d���q��H��
SELECT   O.�q�渹�X [�q��s��], C.���q�W�� [�Ȥ�W��], C.�s���H [�Ȥ�s���H], E.�m�W [�t�d���u]
FROM    ���u  E  JOIN  �q�f�D�� O  ON  E.���u�s��=O.���u�s��
				 JOIN  �Ȥ� C      ON  O.�Ȥ�s��=C.�Ȥ�s��
WHERE    �q�渹�X between 10590 AND 10621
ORDER BY  �q�渹�X
GO

--SQL-89
SELECT   O.�q�渹�X [�q��s��], C.���q�W�� [�Ȥ�W��], C.�s���H [�Ȥ�s���H], E.�m�W [�t�d���u]
FROM    ���u  E  , �q�f�D�� O ,  �Ȥ� C  
WHERE    O.�Ȥ�s��=C.�Ȥ�s��  AND  E.���u�s��=O.���u�s��   AND  �q�渹�X between 10590 AND 10621
ORDER BY  �q�渹�X


--�Ч�X�S���q�檺�Ȥ�
SELECT  C.�Ȥ�s�� , C.���q�W�� , O.�q�渹�X
FROM    �Ȥ� C  LEFT  JOIN  �q�f�D�� O  ON C.�Ȥ�s��=O.�Ȥ�s��
WHERE  O.�Ȥ�s�� IS NULL
GO

GO


--UNION�d��(�H��1�Ӭd�ߪ����W�ٰ������浲�G�����W��)
SELECT ���� A, ��F��
FROM dbo.���u
UNION
SELECT ���� B, ��F��
FROM dbo.�Ȥ�
GO


--UNION �۱adistinct�ĪG�Aunion all�i�C�X���и��
SELECT ���� , ��F��
FROM dbo.���u
UNION all
SELECT ���� , ��F��
FROM dbo.�Ȥ�
GO

--UNION����Group by�PHaving�ݩ�b�U�O���d�߫��O���A��ORDER BY�h��b�̫�
SELECT ���� , count(*) �ƶq FROM ���u group by ���� 
UNION 
SELECT ���� , count(*) FROM �Ȥ� group by ����
order by 2
go


--UNION����INTO�u���b��1�Ӭd�߫��O
SELECT ���� , count(*) �ƶq into ���u3 FROM dbo.���u group by ���� 
UNION 
SELECT ���� , count(*) FROM �Ȥ� group by ����
order by 2
go

--UNION�i�H�[�J�{�ɸ��
SELECT ����, ��F��, �ϰ츹�X
FROM ���u
UNION
SELECT ����, ��F��, �l���ϸ�
FROM �Ȥ�
UNION
SELECT '�O�W','�x�_','882'
go

--intersect ���X��Ӭd�ߵ��G���������
SELECT ����, ��F��+'��' ��F��
FROM dbo.���u
INTERSECT
SELECT ����, ��F��
FROM dbo.�Ȥ�

--Except ���X��1�Ӭd�ߵ��G������ơA�Ӳ�2�Ӭd�ڵ��G�S��
SELECT ����, ��F��
FROM dbo.�Ȥ�
EXCEPT
SELECT ����, ��F��+'��' ��F��
FROM dbo.���u


--�إ�VIEW(�˵�)
create view �q��Ȥ�
AS
select A.�q�渹�X,A.�q����,C.�Ȥ�s��,C.���q�W��,C.�s���H
from  �q�f�D�� A join �Ȥ� C ON A.�Ȥ�s��=C.�Ȥ�s��
GO

--�ק�VIEW(�˵�)
alter view �q��Ȥ�
AS
select A.�q�渹�X,A.�q����,A.�Ȥ�s�� �q��Ƚs,C.�Ȥ�s�� �Ȥ�Ƚs,C.���q�W��,C.�s���H,c.�q��,a.���u�s��
from  �q�f�D�� A join �Ȥ� C ON A.�Ȥ�s��=C.�Ȥ�s��
GO

--�d��VIEW(�˵�)
select * from �q��Ȥ�
GO

--��ƪ� JOIN  view(�˵���)
select oc.�q�渹�X,E.�m�W from �q��Ȥ� OC join ���u E ON oc.���u�s��=E.���u�s�� where �q�渹�X=10260
GO

--�l�d��
SELECT �q�渹�X,�`�ƶq=(SELECT SUM(�ƶq) FROM dbo.�q�f���� WHERE dbo.�q�f�D��.�q�渹�X=�q�渹�X)
FROM dbo.�q�f�D��


--��X�S�U�L�q�檺�Ȥ�(�l�d��-���M��)
select * from �Ȥ� where �Ȥ�s�� not in (select �Ȥ�s�� from �q�f�D��)
GO

--��X�S�U�L�q�檺�Ȥ�(�l�d��-���զs�b)
select * from �Ȥ� where not EXISTS (select �Ȥ�s�� from �q�f�D�� where �Ȥ�.�Ȥ�s��=�q�f�D��.�Ȥ�s��)
GO

