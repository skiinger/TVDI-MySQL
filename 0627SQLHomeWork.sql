--������ƪ�
create database data0606 
ON (FileName='D:\DB\NorthwindC.mdf')
FOR ATTACH
go

--�d�߭��u��ƪ�_����W��
select * from data0606.dbo.���u

--�d�߭��u��ƪ�_�����W��
use data0606
go 

select * from ���u
go 

select ���u�s��,�m�W,¾�� From ���u

--�p������
select [���]*[�ƶq] as [����] from [�q�f����]
go

select �m�W+' ' +¾�� as [���q����] from [���u]
go

select LEFT(�m�W,1)+¾��+' '+RIGHT(�m�W,len(�m�W)-1) as [���q����] from ���u
go

--�������Ƹ�ƦC(�O�d�@��)
select distinct ¾�� from ���u
go

--�զX���P���������(���~)
USE data0606
SELECT 14+�m�W [�L��]
FROM DBO.���u
GO
--�զX���P���������(���T)
USE data0606
SELECT CONVERT(nvarchar,14)+�m�W �L��
FROM DBO.���u
GO

USE data0606
SELECT '14'+�m�W [�L��]
FROM DBO.���u
GO

--where �l�y�d��
select * from dbo.���u where ¾��= '�~��'
go

select * from ���u

select ���u�s��,�m�W,¾�� from dbo.���u
where year(���Τ��)<=1993
go

--�ϥ��޿�B��l not > and > or
use data0606
select *
FROM dbo.���u WHERE ¾��= '�~�ȥD��'  AND  �٩I= '�p�j' 
go

--�޿�B��l �s���h�ӱ���P
use data0606
select *
FROM dbo.���~��� 
WHERE  �w�s�q<=�w���s�q  and  (���O�s��=1 or ���O�s��=3) 
go

--IN����r
use data0606
select *
FROM dbo.������ 
WHERE ��F��='�x�_' OR ��F��='�s��' OR ��F��='����'
go

use data0606
select *
FROM dbo.������ 
WHERE ��F�� IN ('�x�_','�s��','����') 
GO

--null��
use data0606
select *
FROM dbo.���u
WHERE �ۤ� is not null
go

select ���u�s��,�m�W,isnull(�ۤ�,'��ú��') as �ۤ� from ���u
go

--�d�߲��~���O��_����W��
select * from data0606.dbo.���~���
go

----�д���1,3,5���O����b10~20����������P�⪺���~ HomeMade
use data0606
select *
FROM dbo.���~���
WHERE (���O�s��='1' OR ���O�s��='3' OR ���O�s��='5') 
AND ���A�P��=0 AND (���>=10 AND ���<=20) 
go
----�д���1,3,5���O����b10~20����������P�⪺���~ �Ѯv��
use data0606
select *
FROM dbo.���~���
WHERE  ��� between 10 And 20 AND ���O�s�� in (1,3,5) AND ���A�P��=0
go

--1.�Ч�X�Ȧ�Ȥ�
select * from data0606.dbo.�Ȥ�
go

use data0606
select *
FROM dbo.�Ȥ�
WHERE  ���q�W�� LIKE'%�Ȧ�%'
go

--2.�d�ߦb�������W��������
select * from data0606.dbo.������
go

use data0606
select *
FROM dbo.������
WHERE  �a�} LIKE'%������%'
go
--3.�d�߫Ȥ�W�ٲ�1�Ӧr�O�j�Τs�ΪF�����
select * from data0606.dbo.�Ȥ�
go

use data0606
select *
FROM dbo.�Ȥ�
WHERE  ���q�W�� LIKE '[�j�s�F]%'
go

--4.��X�Ȥ�s���̫�H AS �� AR �� OS �� OR ���������
use data0606
select *
FROM dbo.�Ȥ�
WHERE  �Ȥ�s�� LIKE'%[AO][SR]'
go

--5.��X�Ȥ�s���ĤG�Ӧr��NAO�γ̫�@�Ӧr��GHIJK���Ȥ���
use data0606
select *
FROM dbo.�Ȥ�
WHERE  �Ȥ�s�� LIKE '_[NAO]%[G-K]'
go

--�E�X���
use data0606
select SUM(�ƶq)'�q���`��',COUNT(�q�渹�X)'�q�浧��',
AVG(�ƶq)'�����ƶq',MIN(�ƶq)'�浧�q�ʳ̤p��',MAX(�ƶq)'�浧�q�ʳ̤j��'
FROM dbo.[�q�f����]
WHERE ���~�s�� = 51
go

--Group By �l�y
use data0606
select ¾��,count(*)
FROM dbo.���u
Group by ¾��
go

--�Эp����u¾�٦��h�ֺ�
use data0606
select ¾��,count(*)
FROM dbo.���u
Group by ¾��
go
--�Эp����u¾�٦��h�ֺ� �ѵ�
SELECT COUNT(DISTINCT ¾��) FROM dbo.���u

--�вέp�ʧO�ƶq
use data0606
select �٩I,count(*)
FROM dbo.���u
Group by �٩I
go

--�Эp��10590�q�檺�`��(���*�ƶq*(1-�馩))
use data0606
select sum(���*�ƶq*(1-�馩))'10590�q��-�`��'
FROM dbo.[�q�f����]
WHERE �q�渹�X = 10590
go

--�Эp��10590�P10591�q�檺�`��
use data0606
select �q�渹�X,sum(���*�ƶq*(1-�馩))'�`��'
FROM dbo.[�q�f����]
WHERE �q�渹�X in(10590,10591)
group by �q�渹�X
go

--�Эp��10590��10670�q�檺�`��(���*�ƶq*(1-�馩))�C��100
use data0606
select �q�渹�X,sum(���*�ƶq*(1-�馩))'�`��'
FROM dbo.[�q�f����]
group by �q�渹�X
Having �q�渹�X between 10590 and 10670 and sum(���*�ƶq*(1-�馩))<100
go

--WITH ROLLUP�B��l 
USE    data0606
SELECT    ���~�s��, ��� , SUM(�ƶq)  [�`�ƶq] 
FROM      dbo.[�q�f����] 
WHERE    ���~�s�� IN (50,51)
Group By  ���~�s��,���
WITH ROLLUP

--WITH CUBE�B��l 
USE    data0606
SELECT    ���~�s��, ��� , SUM(�ƶq)  [�`�ƶq] 
FROM      dbo.[�q�f����] 
WHERE    ���~�s�� IN (50,51)
Group By  ���~�s��,���
WITH CUBE 

--GROUPING SETS�l�y
USE    data0606
SELECT    ���~�s��, ��� , SUM(�ƶq)  [�`�ƶq] 
FROM      dbo.[�q�f����] 
WHERE    ���~�s�� IN (50,51)
Group By  Grouping sets((���~�s��,���),���~�s��)

--GROUPING SETS�l�y �̫�[�`
USE    data0606
SELECT    ���~�s��, ��� , SUM(�ƶq)  [�`�ƶq] 
FROM      dbo.[�q�f����] 
WHERE    ���~�s�� IN (50,51)
Group By  Grouping sets((���~�s��,���),���~�s��,())

--�ƧǸ��ORDER BY ���W�]ASC�^����]DESC�^ 

USE    data0606
SELECT ���O�s��[���~���O�N��],���~[���~�W��],���[���~���] 
FROM   dbo.���~��� 
ORDER BY  ���  DESC

USE    data0606
SELECT ���O�s��[���~���O�N��],���~[���~�W��],���[���~���] 
FROM   dbo.���~��� 
ORDER BY  [���~���] ASC  

USE    data0606
SELECT ���O�s��[���~���O�N��],���~[���~�W��],���[���~���] 
FROM   dbo.���~��� 
ORDER BY  3

--�ʶR���Ƴ̦h��3�����~
SELECT TOP 3 WITH ties ���~�s��,count(���~�s��) �ʶR����
FROM �q�f����
GROUP BY ���~�s��
ORDER BY �ʶR���� DESC

--���� (offset row ��Ʀ첾)
select * from �q�f�D��
order by �q�渹�X OFFSET 5 ROW

--�Ĥ@���}�l(OFFSET ROW)�A�C��10��(FETCH NEXT ROW ONLY)
select * from �q�f�D��
order by �q�渹�X OFFSET 0 ROW FETCH NEXT 10 ROW ONLY

--�ЦC�X�q��10590�M10621���ʶR�����~
select * from data0606.dbo.���~���
select * from data0606.dbo.�q�f����

use data0606
select �q�渹�X,���~
FROM �q�f���� JOIN ���~���
ON �q�f����.���~�s�� = ���~���.���~�s��
WHERE �q�渹�X in(10590,10621)
go

--�ЦC�X�q��10590��10621���Ȥ�W�١B�p���H�έt�d���q��H��
select * from data0606.dbo.�q�f�D��
select * from data0606.dbo.���u
select * from data0606.dbo.�Ȥ�

use data0606
select C.�s���H[�Ȥ�W��],A.�q�渹�X,A.���f�H [�p���H],B.�m�W[�t�d�q��H��]
FROM �q�f�D�� A JOIN ���u B
ON A.���u�s�� = B.���u�s��
JOIN �Ȥ� C ON A.�Ȥ�s�� = C.�Ȥ�s��
WHERE A.�q�渹�X between 10590 and 10621
go

--�Ч�X�S���q�檺�Ȥ�
--(�Q��right join�s�@�X�s����ƪ�A�P�_�Ȥ�s���P�q��s�����X�{��null��)
select *
FROM �q�f�D�� A RIGHT JOIN �Ȥ� B
ON A.�Ȥ�s�� = B.�Ȥ�s��
go
select B.�s���H[�S���q�檺�Ȥ�]
FROM �q�f�D�� A right JOIN �Ȥ� B
ON A.�Ȥ�s�� = B.�Ȥ�s��
where A.�q�渹�X is null
go
--�Ч�X�S���q�檺�Ȥ�(�l�d�� ���M��)
select * from �Ȥ� where �Ȥ�s�� not in (select �Ȥ�s�� from �q�f�D��)
--�Ч�X�S���q�檺�Ȥ�(�l�d�� ���ղM��)
select * from �Ȥ� where not EXISTS (select �Ȥ�s�� from �q�f�D�� where �Ȥ�.�Ȥ�s��=�q�f�D��.�Ȥ�s��)

--SELF JOIN (�ۤvJOIN�ۤv)
use data0606
SELECT 
E1.���u�s��  [���u�s��], 
E1.�m�W  [���u�m�W], 
E2.���u�s��   [�D�޽s��], 
E2.�m�W   [�D�ީm�W] 
FROM   dbo.���u  E1   LEFT  JOIN  dbo.���u   E2 
ON  E1.�D��=E2.���u�s�� 


--UNION �d��(�۰ʹL�o)
USE  data0606
SELECT ����, ��F�� 
FROM dbo.���u 
UNION 
SELECT ����, ��F�� 
FROM dbo.�Ȥ�

--UNION �d��(ALL)
USE  data0606
SELECT ����, ��F�� 
FROM dbo.���u 
UNION ALL
SELECT ����, ��F�� 
FROM dbo.�Ȥ�

--UNION �p��ƦC
USE  data0606
SELECT ����, count(*) �ƶq
FROM dbo.���u 
group by ����
UNION
SELECT ����, count(*)
FROM dbo.�Ȥ�
group by ����
order by 2

--INTERSECT�涰�d�� (�ۦP���)
USE  data0606
SELECT   ����, ��F��+ '��' ��F��
FROM     dbo.���u 
INTERSECT 
SELECT   ����, ��F�� 
FROM     dbo.�Ȥ� 

--EXCEPT�t���d�� (���P���)
USE  data0606
SELECT   ����, ��F��+ '��' ��F��
FROM     dbo.���u 
EXCEPT
SELECT   ����, ��F�� 
FROM     dbo.�Ȥ� 

--�إ�view��ƪ�
create view �q��Ȥ�
AS
select A.�q�渹�X,A.�q����,C.�Ȥ�s��,C.���q�W��,C.�s���H
from �q�f�D�� A join �Ȥ� C ON  A.�Ȥ�s��=C.�Ȥ�s��

--�ק�view��ƪ�
alter view �q��Ȥ�
AS
select A.�q�渹�X,A.�q����,C.�Ȥ�s��,C.���q�W��,C.�s���H,C.�q��, a.���u�s��
from �q�f�D�� A join �Ȥ� C ON  A.�Ȥ�s��=C.�Ȥ�s��

select * from �q��Ȥ� where �q�渹�X=10260

select oc.�q�渹�X, E.�m�W from �q��Ȥ� OC join ���u E on oc.���u�s��=E.���u�s�� where �q�渹�X=10260

--Subquery�l�d��  [select(select...)���浲�G �Afrom(select...)��ƨӷ��Awhere(select...)��ƹL�o]

SELECT  �q�渹�X,(SELECT SUM(�ƶq)  
FROM dbo.�q�f����      
WHERE  dbo.�q�f�D��.�q�渹�X=�q�渹�X ) �`�ƶq
FROM  dbo.�q�f�D��

SELECT  O.�q�渹�X,D.�ƶq 
FROM  dbo.�q�f�D�� O 
JOIN (SELECT �q�渹�X,SUM(�ƶq) �ƶq   
FROM dbo.�q�f����  
GROUP BY �q�渹�X ) D  
ON  o.�q�渹�X=d.�q�渹�X 

--�W�ߤl�d�߻P���p�l�d�� 
USE  data0606
SELECT * FROM dbo.�Ȥ�
WHERE ����  IN (SELECT DISTINCT ����  FROM dbo.���u) 

--���p(Corelated)�l�d��   ���L�k��W�s�b���l�d�� 
USE  data0606
SELECT  * FROM  dbo.�q�f�D�� 
WHERE  (SELECT SUM(�ƶq) FROM dbo.�q�f���� WHERE  dbo.�q�f�D��.�q�渹�X=�q�渹�X)>100 


--1.�вέp���u�t�d���q��ơB�P�ⲣ�~�ӼơB�P�ⲣ�~���O�ӼơC
select �m�W [���u�m�W],count(OC.�q�渹�X) '�t�d�q���',sum(OD.�ƶq) '�P�ⲣ�~�Ӽ�',count(distinct PD.���O�s��) '�P�ⲣ�~���O�Ӽ�'
FROM ���u E JOIN �q�f�D�� OC
on E.���u�s�� = OC.���u�s��
JOIN �q�f���� OD
on OC.�q�渹�X = OD.�q�渹�X
JOIN ���~��� PD
on OD.���~�s�� = PD.���~�s��
group by �m�W
go


--2.�д���1997�~�~�Z�̦n���T�W���u�C
select top 3 with ties E.�m�W,sum(PD.���*PD.�ƶq*(1-PD.�馩))'�~�׷~�Z'
from �q�f�D�� OC join ���u E
on OC.���u�s�� = E.���u�s��
join �q�f���� OD
on OC.�q�渹�X =OD.�q�渹�X
where year(OC.�q����) = 1997
group by  E.�m�W
order by �~�׷~�Z desc
go


--3.�д���1996�~���������~�P��ƶq�C��������~��~�׾P�⥭���ƶq���q�渹�X�ΫȤ�

select PD.���~�s��,PD.���~,OC.�q�渹�X,OD.�ƶq [�q�ʼƶq],C.���q�W��
from �q�f�D�� OC join �Ȥ� C
on OC.�Ȥ�s�� = C.�Ȥ�s��
join �q�f���� OD
on OC.�q�渹�X = OD.�q�渹�X
join ���~��� PD
on OD.���~�s�� = PD.���~�s��
where year(OC.�q����) = 1996 and PD.���O�s�� = 1
group by OC.�q�渹�X,PD.���~�s��,PD.���~,OD.�ƶq,C.���q�W��
having OD.�ƶq <
(select sum(�q�f����.�ƶq)/count ( �q�f����.�q�渹�X)
from �q�f���� join ���~���
on �q�f����.���~�s�� = ���~���.���~�s��
where ���~���.���O�s�� = 1)
order by 1
go

--4.�Ч�X������B(���*�ƶq*(1-�馩))�F15,000���H�W���q��B�ӿ�H���ΫȤ�C(������)
select OD.�q�渹�X , E.�m�W [�ӿ�H��],C.���q�W�� [�Ȥ�],sum(OD.���*OD.�ƶq*(1-OD.�馩)) [������B]
from �q�f���� OD join �q�f�D�� OC
on OD.�q�渹�X = OC.�q�渹�X
join ���u E
on OC.���u�s�� = E.���u�s��
join �Ȥ� C
on OC.�Ȥ�s�� = C.�Ȥ�s��
group by OD.�q�渹�X,E.�m�W,C.���q�W��
having sum(OD.���*OD.�ƶq*(1-OD.�馩)) >=15000
order by OD.�q�渹�X
go

--5.�вέp���u1996,1997,1998�~�~�Z�A�~�Z���ܤp�Ʀ��2��A��3��|�ˤ��J�A
--  �åH�~�׬������ܲέp��ơA��~�רS���~�Z�̥H�L�����ܡC