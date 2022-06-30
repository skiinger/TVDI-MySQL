------------------------------單元一、建立資料庫 --------------------------
/*一、請將 Schdb_1.mdf 附加至執行個體(instance)中。請注意下列條件：
1. 資料庫名稱『SchDB』。 2. 資料檔位置『D:\DB\』。*/ 

create database SchDB
ON (FileName='D:\DB\Schdb_1.mdf')
FOR ATTACH
go

sp_attach_db schdb,'D:\DB\schdb_1.mdf'
go


use SchDB
go

/*二、請在該資料庫中新增 1 個檔案群組『G1』，
並在該群組中新增 1 個資料檔 『Schdb_2.ndf』，
初始為 20MB，自動成長 50MB。*/
alter database SchDB add FILEGROUP G1
go
alter database schdb
add file
(name=schdb_2,
filename='D:\DB\Schdb_2.ndf',
size=20MB,
filegrowth=50MB)to filegroup G1
go

--3-1、請為『班級』建立主鍵(PK)及外來鍵(FK)以符合上圖關聯架構
sp_helpconstraint 班級
go
alter table 班級 add constraint PK_班級_教編課編學員 Primary KEY (課程編號,教授編號,學號)
go
alter table 班級 add constraint FK_班級_教編 Foreign KEY (教授編號) references 教授(教授編號)
go
alter table 班級 add constraint FK_班級_課編 Foreign KEY (課程編號) references 課程(課程編號)
go
alter table 班級 add constraint FK_班級_學號 Foreign KEY (學號) references 學生(學號)
go

--3-2、請建立『教室』資料表至『G1』群組，並存入以下資料
create table 教室
(教室編號 nchar(5) primary key,
教室 nvarchar(10) not null)
on G1
go

insert 教室
values 
('100-M','一般教室1'),
('180-M','一般教室2'),
('221-S','特殊教室1'),
('321-M','一般教室3'),
('327-S','特殊教室1'),
('380-L','專業教室1'),
('500-K','專業教室2'),
('622-G','專業教室3')
GO

--3-3、請為『員工』資料表建立『電話』不允許為 NULLL 的檢查條件（5 分）
alter table 員工 with nocheck add constraint CK_員工_電話 CHECK (電話 is not null)
go
--3-4、請將課程『計算概論』改為『計算機概論』。
select * from 課程 
where 名稱='計算概論'
go
update 課程 set 名稱='計算機概論' where 課程編號='CS101'
go

--3-5.移除『G1』群組
sp_helpdb schdb

drop TABLE 教室
go
alter database schdb remove file schdb_2
go
sp_helpfilegroup G1
go
alter database schdb remove FILEGROUP G1
go
--------------------------------單元二、基本查詢（單資料源） --------------------------------
-- 一、 查詢【學生】資料表的所有學生的學號、姓名和生日，若無資料請以『未提供』 顯示
select 學號,姓名,性別,電話,isnull(cast([生日] as varchar),'未提供') '生日'
from 學生
go

--二、 計算每位員工的薪水淨額(收入-支出) 
select 姓名,(薪水-(保險+扣稅)) as [薪水淨額] from [員工]
go

--三、 計算學生的年齡，若無資料請以『未提供』顯示 

--四、 找出薪水最高的前 3 名員工 
select * from 員工

select top 3  with ties 薪水 
from 課程
order by 學分 asc

--五、 找出薪水最低的前 10%名員工 

-- 六、 在【課程】資料表找出學分數最少的 3 筆課程記錄資料，但若有相同學分數的 記錄也一併顯出來 
select top 3  with ties 學分 ,名稱
from 課程
order by 學分 asc

--七、 在【學生】資料表找出所有女同學的資料。
select *
from 學生
where 性別 = '女'
go
--八、 在【班級】資料表找出有幾位學生上 CS203 的課
select count(課程編號) 'CS203上課人數'
from 班級
where 課程編號 = 'CS203'
go

--九、 在【班級】資料表找出教授 I002 共教幾門課
select COUNT(DISTINCT 課程編號) '課程總數'
from 班級
where 教授編號 = 'I002'
go

--十、 在【班級】資料表超過 3 位學生上課的課程


--十一、 查詢【員工】資料表所有員工的保險總和與平均 
select sum(保險) '員工保險總和',avg(保險) '員工保險平均'
from 員工
go

--十二、 查詢【班級】資料表中，上課教室是在二樓的資料(教室第 2 碼代表樓層) 
select * 
from 班級
where 教室 like '_2%'
go

--十三、 找出 1990 年 2 月到 1990 年 10 月出生的學生 
select * 
from 學生
where year(生日) = 1990 and month(生日) not in (1,11,12)
go

--十四、 學生已經修了 CS101、CS222、CS100 和 CS213 等四門課，請幫學生查詢看 看還有什麼課程可以修 

--十五、 請找出住在桃園，但卻沒有留電話的員工 
select 姓名 ,城市,電話
from 員工
where 城市 = '桃園' and 電話 IS NULL
go

--十六、 查詢【課程】資料表的課程編號欄位包含'2'的字串，以及課程名稱欄位有'程 式'的字串或學分大於等於 4 的資料 
select *
from 課程
where 課程編號 like '%2%' and (名稱 like '%程%' or 學分 >= 4)
go

--十七、 請找出淨收入低於 40000 元的員工 
select 姓名, (薪水-保險-扣稅) '淨收入'
from 員工
where (薪水-保險-扣稅) < 40000
go

--十八、 請統計【員工】資料表中，每個城市中的員工數、薪水總額及平均薪資 

--十九、 請用【班級】資料表找出只有教授 1 門課程的教授 

--二十、 使用 Grouping sets 計算教授 I001 和 I003 教授課程的學生數、小計和加


-------------------------單元三、進階查詢（多資料源） ---------------------------
--一、請找出淨收入最高的教師
select * from 教授
select * from 員工

select top 1 姓名,(薪水-保險-扣稅) '淨收入'
FROM 教授 t JOIN 員工 e
ON t.身份證字號 = e.身份證字號
go

--二、--請提供一份依學號遞增排序的學生修業課程資料，資料需包含學號、學生姓名、修業課程、授課教授、上課教室及上課時間 
select * from 教授
select * from 班級
select * from 學生
select * from 課程
select * from 員工

select c.學號,s.姓名,c.上課時間,c.教室,l.名稱 '課程',e.姓名 '教授姓名'
FROM 教授 t JOIN 班級 c
ON t.教授編號 = c.教授編號
join 學生 s
on c.學號 = s.學號
join 課程 l
on c.課程編號 = l.課程編號
join 員工 e
on t.身份證字號 = e.身份證字號
go

--三、 查詢 100-M、221-S、500-K 等教室所開設的課程與上課時間 
--四、 統計每一門課程的修課人數，並以課程名稱遞增排序 
--五、 找出修課人數低於 3 人的課程名稱 
--六、 找出學生與員工同名同姓的名字 
--七、 使用子查詢找出薪水超過 5 萬的員工資料 
--八、 請使用子查詢找出薪水高於平均值的員工資料 
--九、 請計算學生張無忌本學期的選課數(請寫出使用子查詢及內部合併查詢的語法) 
--十、 請找出學號 S004 沒有上的課程清單