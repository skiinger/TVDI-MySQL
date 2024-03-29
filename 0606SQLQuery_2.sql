--掛載資料表
create database data0606 
ON (FileName='D:\DB\NorthwindC.mdf')
FOR ATTACH
go

--查詢員工資料表_完整名稱
select * from data0606.dbo.員工

--查詢員工資料表_部分名稱
use data0606
go 

select * from 員工
go 

select 員工編號,姓名,職稱 From 員工

--計算值欄位
select [單價]*[數量] as [價格] from [訂貨明細]
go

select 姓名+' ' +職稱 as [公司成員] from [員工]
go

select LEFT(姓名,1)+職稱+' '+RIGHT(姓名,len(姓名)-1) as [公司成員] from 員工
go

--移除重複資料列(保留一筆)
select distinct 職稱 from 員工
go

--組合不同類型的資料(錯誤)
USE data0606
SELECT 14+姓名 [尊稱]
FROM DBO.員工
GO
--組合不同類型的資料(正確)
USE data0606
SELECT CONVERT(nvarchar,14)+姓名 尊稱
FROM DBO.員工
GO

USE data0606
SELECT '14'+姓名 [尊稱]
FROM DBO.員工
GO

--where 子句範例
select * from dbo.員工 where 職稱= '業務'
go

select * from 員工

select 員工編號,姓名,職稱 from dbo.員工
where year(雇用日期)<=1993
go

--使用邏輯運算子 not > and > or
use data0606
select *
FROM dbo.員工 WHERE 職稱= '業務主管'  AND  稱呼= '小姐' 
go

--邏輯運算子 連接多個條件與
use data0606
select *
FROM dbo.產品資料 
WHERE  庫存量<=安全存量  and  (類別編號=1 or 類別編號=3) 
go

--IN關鍵字
use data0606
select *
FROM dbo.供應商 
WHERE 行政區='台北' OR 行政區='新竹' OR 行政區='高雄'
go

use data0606
select *
FROM dbo.供應商 
WHERE 行政區 IN ('台北','新竹','高雄') 
GO

--null值
use data0606
select *
FROM dbo.員工
WHERE 相片 is not null
go

select 員工編號,姓名,isnull(相片,'未繳交') as 相片 from 員工
go

--查詢產品類別表_完整名稱
select * from data0606.dbo.產品資料
go

----請提供1,3,5類別單價在10~20之間仍持續銷售的產品 HomeMade
use data0606
select *
FROM dbo.產品資料
WHERE (類別編號='1' OR 類別編號='3' OR 類別編號='5') 
AND 不再銷售=0 AND (單價>=10 AND 單價<=20) 
go
----請提供1,3,5類別單價在10~20之間仍持續銷售的產品 老師版
use data0606
select *
FROM dbo.產品資料
WHERE  單價 between 10 And 20 AND 類別編號 in (1,3,5) AND 不再銷售=0
go

--1.請找出銀行客戶
select * from data0606.dbo.客戶
go

use data0606
select *
FROM dbo.客戶
WHERE  公司名稱 LIKE'%銀行%'
go

--2.查詢在中正路上的供應商
select * from data0606.dbo.供應商
go

use data0606
select *
FROM dbo.供應商
WHERE  地址 LIKE'%中正路%'
go
--3.查詢客戶名稱第1個字是大或山或東的資料
select * from data0606.dbo.客戶
go

use data0606
select *
FROM dbo.客戶
WHERE  公司名稱 LIKE '[大山東]%'
go

--4.找出客戶編號最後以 AS 或 AR 或 OS 或 OR 結尾的資料
use data0606
select *
FROM dbo.客戶
WHERE  客戶編號 LIKE'%[AO][SR]'
go

--5.找出客戶編號第二個字為NAO及最後一個字為GHIJK的客戶資料
use data0606
select *
FROM dbo.客戶
WHERE  客戶編號 LIKE '_[NAO]%[G-K]'
go

--聚合函數
use data0606
select SUM(數量)'訂購總數',COUNT(訂單號碼)'訂單筆數',
AVG(數量)'平均數量',MIN(數量)'單筆訂購最小值',MAX(數量)'單筆訂購最大值'
FROM dbo.[訂貨明細]
WHERE 產品編號 = 51
go

--Group By 子句
use data0606
select 職稱,count(*)
FROM dbo.員工
Group by 職稱
go

--請計算員工職稱有多少種
use data0606
select 職稱,count(*)
FROM dbo.員工
Group by 職稱
go
--請計算員工職稱有多少種 解答
SELECT COUNT(DISTINCT 職稱) FROM dbo.員工

--請統計性別數量
use data0606
select 稱呼,count(*)
FROM dbo.員工
Group by 稱呼
go

--請計算10590訂單的總價(單價*數量*(1-折扣))
use data0606
select sum(單價*數量*(1-折扣))'10590訂單-總價'
FROM dbo.[訂貨明細]
WHERE 訂單號碼 = 10590
go

--請計算10590與10591訂單的總價
use data0606
select 訂單號碼,sum(單價*數量*(1-折扣))'總價'
FROM dbo.[訂貨明細]
WHERE 訂單號碼 in(10590,10591)
group by 訂單號碼
go

--請計算10590到10670訂單的總價(單價*數量*(1-折扣))低於100
use data0606
select 訂單號碼,sum(單價*數量*(1-折扣))'總價'
FROM dbo.[訂貨明細]
group by 訂單號碼
Having 訂單號碼 between 10590 and 10670 and sum(單價*數量*(1-折扣))<100
go

--WITH ROLLUP運算子 
USE    data0606
SELECT    產品編號, 單價 , SUM(數量)  [總數量] 
FROM      dbo.[訂貨明細] 
WHERE    產品編號 IN (50,51)
Group By  產品編號,單價
WITH ROLLUP

--WITH CUBE運算子 
USE    data0606
SELECT    產品編號, 單價 , SUM(數量)  [總數量] 
FROM      dbo.[訂貨明細] 
WHERE    產品編號 IN (50,51)
Group By  產品編號,單價
WITH CUBE 

--GROUPING SETS子句
USE    data0606
SELECT    產品編號, 單價 , SUM(數量)  [總數量] 
FROM      dbo.[訂貨明細] 
WHERE    產品編號 IN (50,51)
Group By  Grouping sets((產品編號,單價),產品編號)

--GROUPING SETS子句 最後加總
USE    data0606
SELECT    產品編號, 單價 , SUM(數量)  [總數量] 
FROM      dbo.[訂貨明細] 
WHERE    產品編號 IN (50,51)
Group By  Grouping sets((產品編號,單價),產品編號,())

--排序資料ORDER BY 遞增（ASC）遞減（DESC） 

USE    data0606
SELECT 類別編號[產品類別代號],產品[產品名稱],單價[產品單價] 
FROM   dbo.產品資料 
ORDER BY  單價  DESC

USE    data0606
SELECT 類別編號[產品類別代號],產品[產品名稱],單價[產品單價] 
FROM   dbo.產品資料 
ORDER BY  [產品單價] ASC  

USE    data0606
SELECT 類別編號[產品類別代號],產品[產品名稱],單價[產品單價] 
FROM   dbo.產品資料 
ORDER BY  3

--購買次數最多的3項產品
SELECT TOP 3 WITH ties 產品編號,count(產品編號) 購買次數
FROM 訂貨明細
GROUP BY 產品編號
ORDER BY 購買次數 DESC

--分頁 (offset row 資料位移)
select * from 訂貨主檔
order by 訂單號碼 OFFSET 5 ROW

--第一頁開始(OFFSET ROW)，每次10筆(FETCH NEXT ROW ONLY)
select * from 訂貨主檔
order by 訂單號碼 OFFSET 0 ROW FETCH NEXT 10 ROW ONLY

--請列出訂單10590和10621所購買的產品
select * from data0606.dbo.產品資料
select * from data0606.dbo.訂貨明細

use data0606
select 訂單號碼,產品
FROM 訂貨明細 JOIN 產品資料
ON 訂貨明細.產品編號 = 產品資料.產品編號
WHERE 訂單號碼 in(10590,10621)
go

--請列出訂單10590至10621的客戶名稱、聯絡人及負責的訂單人員
select * from data0606.dbo.訂貨主檔
select * from data0606.dbo.員工
select * from data0606.dbo.客戶

use data0606
select C.連絡人[客戶名稱],A.訂單號碼,A.收貨人 [聯絡人],B.姓名[負責訂單人員]
FROM 訂貨主檔 A JOIN 員工 B
ON A.員工編號 = B.員工編號
JOIN 客戶 C ON A.客戶編號 = C.客戶編號
WHERE A.訂單號碼 between 10590 and 10621
go

--請找出沒有訂單的客戶
--(利用right join製作出新的資料表，判斷客戶編號與訂單編號中出現的null值)
select *
FROM 訂貨主檔 A RIGHT JOIN 客戶 B
ON A.客戶編號 = B.客戶編號
go
select B.連絡人[沒有訂單的客戶]
FROM 訂貨主檔 A right JOIN 客戶 B
ON A.客戶編號 = B.客戶編號
where A.訂單號碼 is null
go
--請找出沒有訂單的客戶(子查詢 比對清單)
select * from 客戶 where 客戶編號 not in (select 客戶編號 from 訂貨主檔)
--請找出沒有訂單的客戶(子查詢 測試清單)
select * from 客戶 where not EXISTS (select 客戶編號 from 訂貨主檔 where 客戶.客戶編號=訂貨主檔.客戶編號)

--SELF JOIN (自己JOIN自己)
use data0606
SELECT 
E1.員工編號  [員工編號], 
E1.姓名  [員工姓名], 
E2.員工編號   [主管編號], 
E2.姓名   [主管姓名] 
FROM   dbo.員工  E1   LEFT  JOIN  dbo.員工   E2 
ON  E1.主管=E2.員工編號 


--UNION 查詢(自動過濾)
USE  data0606
SELECT 城市, 行政區 
FROM dbo.員工 
UNION 
SELECT 城市, 行政區 
FROM dbo.客戶

--UNION 查詢(ALL)
USE  data0606
SELECT 城市, 行政區 
FROM dbo.員工 
UNION ALL
SELECT 城市, 行政區 
FROM dbo.客戶

--UNION 計算排列
USE  data0606
SELECT 城市, count(*) 數量
FROM dbo.員工 
group by 城市
UNION
SELECT 城市, count(*)
FROM dbo.客戶
group by 城市
order by 2

--INTERSECT交集查詢 (相同資料)
USE  data0606
SELECT   城市, 行政區+ '區' 行政區
FROM     dbo.員工 
INTERSECT 
SELECT   城市, 行政區 
FROM     dbo.客戶 

--EXCEPT差集查詢 (不同資料)
USE  data0606
SELECT   城市, 行政區+ '區' 行政區
FROM     dbo.員工 
EXCEPT
SELECT   城市, 行政區 
FROM     dbo.客戶 

--建立view資料表
create view 訂單客戶
AS
select A.訂單號碼,A.訂單日期,C.客戶編號,C.公司名稱,C.連絡人
from 訂貨主檔 A join 客戶 C ON  A.客戶編號=C.客戶編號

--修改view資料表
alter view 訂單客戶
AS
select A.訂單號碼,A.訂單日期,C.客戶編號,C.公司名稱,C.連絡人,C.電話, a.員工編號
from 訂貨主檔 A join 客戶 C ON  A.客戶編號=C.客戶編號

select * from 訂單客戶 where 訂單號碼=10260

select oc.訂單號碼, E.姓名 from 訂單客戶 OC join 員工 E on oc.員工編號=E.員工編號 where 訂單號碼=10260

--Subquery子查詢  [select(select...)執行結果 ，from(select...)資料來源，where(select...)資料過濾]

SELECT  訂單號碼,(SELECT SUM(數量)  
FROM dbo.訂貨明細      
WHERE  dbo.訂貨主檔.訂單號碼=訂單號碼 ) 總數量
FROM  dbo.訂貨主檔

SELECT  O.訂單號碼,D.數量 
FROM  dbo.訂貨主檔 O 
JOIN (SELECT 訂單號碼,SUM(數量) 數量   
FROM dbo.訂貨明細  
GROUP BY 訂單號碼 ) D  
ON  o.訂單號碼=d.訂單號碼 

--獨立子查詢與關聯子查詢 
USE  data0606
SELECT * FROM dbo.客戶
WHERE 城市  IN (SELECT DISTINCT 城市  FROM dbo.員工) 

--關聯(Corelated)子查詢   指無法單獨存在的子查詢 
USE  data0606
SELECT  * FROM  dbo.訂貨主檔 
WHERE  (SELECT SUM(數量) FROM dbo.訂貨明細 WHERE  dbo.訂貨主檔.訂單號碼=訂單號碼)>100 


--1.請統計員工負責的訂單數、銷售產品個數、銷售產品類別個數。
select 姓名 [員工姓名],count(OC.訂單號碼) '負責訂單數',sum(OD.數量) '銷售產品個數',count(distinct PD.類別編號) '銷售產品類別個數'
FROM 員工 E JOIN 訂貨主檔 OC
on E.員工編號 = OC.員工編號
JOIN 訂貨明細 OD
on OC.訂單號碼 = OD.訂單號碼
JOIN 產品資料 PD
on OD.產品編號 = PD.產品編號
group by 姓名
go


--2.請提供1997年業績最好的三名員工。
select top 3 with ties E.姓名,sum(PD.單價*PD.數量*(1-PD.折扣))'年度業績'
from 訂貨主檔 OC join 員工 E
on OC.員工編號 = E.員工編號
join 訂貨明細 PD
on OC.訂單號碼 =PD.訂單號碼
where year(OC.訂單日期) = 1997
group by  E.姓名
order by 年度業績 desc
go


--3.請提供1996年飲料類產品銷售數量低於該類產品當年度銷售平均數量的訂單號碼及客戶

--4.請找出交易金額(單價*數量*(1-折扣))達15,000元以上的訂單、承辦人員及客戶。(未完成)
select OD.訂單號碼 , E.姓名 [承辦人員],C.公司名稱 [客戶],sum(OD.單價*OD.數量*(1-OD.折扣)) [交易金額]
from 訂貨明細 OD join 訂貨主檔 OC
on OD.訂單號碼 = OC.訂單號碼
join 員工 E
on OC.員工編號 = E.員工編號
join 客戶 C
on OC.客戶編號 = C.客戶編號
group by OD.訂單號碼,E.姓名,C.公司名稱
having sum(OD.單價*OD.數量*(1-OD.折扣)) >=15000
order by OD.訂單號碼
go

--5.請統計員工1996,1997,1998年業績，業績取至小數位第2位，第3位四捨五入，
--  並以年度為欄位顯示統計資料，當年度沒有業績者以無交易顯示。