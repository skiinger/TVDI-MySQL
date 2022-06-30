--������ƪ�
create database data0606 
ON (FileName='D:\DB\NorthwindC.mdf')
FOR ATTACH
go

use data0606

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
select top 3 with ties E.�m�W,round(sum(���*�ƶq*(1-�馩)),2)'�~�׷~�Z'
from �q�f�D�� OC join ���u E
on OC.���u�s�� = E.���u�s��
join �q�f���� OD
on OC.�q�渹�X =OD.�q�渹�X
where year(OC.�q����) = 1997
group by  E.�m�W
order by �~�׷~�Z desc
go


--3.�д���1996�~���������~�P��ƶq�C��������~��~�׾P�⥭���ƶq���q�渹�X�ΫȤ�

select PD.���~�s��,PD.���~,OC.�q�渹�X,OD.�ƶq '�q�ʼƶq',C.���q�W��
from �q�f�D�� OC join �Ȥ� C
on OC.�Ȥ�s�� = C.�Ȥ�s��
join �q�f���� OD
on OC.�q�渹�X = OD.�q�渹�X
join ���~��� PD
on OD.���~�s�� = PD.���~�s��
where year(OC.�q����) = 1996 and PD.���O�s�� = 1
group by OC.�q�渹�X,PD.���~�s��,PD.���~,OD.�ƶq,C.���q�W��
having OD.�ƶq < (select sum(�q�f����.�ƶq)/count ( �q�f����.�q�渹�X)
from �q�f���� join ���~���
on �q�f����.���~�s�� = ���~���.���~�s��
where ���~���.���O�s�� = 1)
order by 1
go

--4.�Ч�X������B(���*�ƶq*(1-�馩))�F15,000���H�W���q��B�ӿ�H���ΫȤ�C
select OD.�q�渹�X , E.�m�W [�ӿ�H��],C.���q�W�� [�Ȥ�],sum(OD.���*OD.�ƶq*(1-OD.�馩)) [������B]
from �q�f���� OD join �q�f�D�� OC
on OD.�q�渹�X = OC.�q�渹�X
join ���u E
on OC.���u�s�� = E.���u�s��
join �Ȥ� C
on OC.�Ȥ�s�� = C.�Ȥ�s��
group by OD.�q�渹�X,E.�m�W,C.���q�W��
having sum(OD.���*OD.�ƶq*(1-OD.�馩)) >= 15000
order by 1
go

--5.�вέp���u1996,1997,1998�~�~�Z�A�~�Z���ܤp�Ʀ��2��A��3��|�ˤ��J�A
--  �åH�~�׬������ܲέp��ơA��~�רS���~�Z�̥H�L�����ܡC

select ���u�m�W, isnull(cast([1996] as varchar),'�L���')'1996�~�~�Z',isnull(cast([1997] as varchar),'�L���')'1997�~�~�Z',isnull(cast([1998] as varchar),'�L���')'1998�~�~�Z'
from (select �m�W as ���u�m�W,round(sum(OD.���*OD.�ƶq*(1-OD.�馩)),2) as �~�Z,year(�q����) as �~��
FROM ���u E full JOIN �q�f�D�� OC
on E.���u�s�� = OC.���u�s��
full JOIN �q�f���� OD
on OC.�q�渹�X = OD.�q�渹�X
group by �m�W,year(�q����)) as ONY
pivot (sum(�~�Z) for ONY.�~�� in ([1996],[1997],[1998])) as P
go