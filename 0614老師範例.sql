--請提供1,3,5類別單價在10~20之間仍持續銷售的產品
select * from 產品資料 where  單價 between 10 AND 20  AND  類別編號 in (1,3,5) AND 不再銷售=0 
GO


select * from 產品資料 where 產品='蘋果汁'
go


--Like 練習
--1.請找出銀行客戶
SELECT * FROM 客戶 WHERE 公司名稱  LIKE '%銀行'
GO

--2.查詢在中正路上的供應商
select * from 供應商 where 地址 like '%中正路%'
GO

--3.查詢客戶名稱第1個字是大或山或東的資料
select * from 客戶 where 公司名稱 like '[大山東]%'
GO

--4.找出客戶編號最後以 AS 或 AR 或 OS 或 OR 結尾的資料
select * from 客戶 where 客戶編號 like '%[AO][SR]'
go

--5.找出客戶編號第二個字為NAO及最後一個字為GHIJK的客戶資料
select * from 客戶 where 客戶編號 like '_[NAO]%[G-K]'
go


select count(*) from 員工



select distinct 職稱 from 員工

--請計算員工職稱有多少種
select count(distinct 職稱) 職稱種類 from 員工
go

--請統計性別數量
select 稱呼,count(員工編號) 數量 from 員工 group by 稱呼
GO

--請計算10590訂單的總價(單價*數量*(1-折扣))
select sum(單價*數量*(1-折扣)) 總價 from 訂貨明細 where  訂單號碼=10590
GO

--請計算10590與10591訂單的總價(單價*數量*(1-折扣))
select 訂單號碼,sum(單價*數量*(1-折扣)) 總價 from 訂貨明細 where  訂單號碼 in (10590,10591) group by 訂單號碼
GO


--請計算10590到10670訂單的總價(單價*數量*(1-折扣))低於100
select 訂單號碼,sum(單價*數量*(1-折扣)) 總價 
from 訂貨明細 
where  訂單號碼 between 10590 and 10670
group by 訂單號碼
having sum(單價*數量*(1-折扣))<=100
GO










--with rollup
SELECT 產品編號, 單價 , SUM(數量) [總數量]
FROM dbo.[訂貨明細]
WHERE 產品編號 IN (50,51)
Group By 產品編號,單價
WITH rollup

--with cube
SELECT 產品編號, 單價 , SUM(數量) [總數量]
FROM dbo.[訂貨明細]
WHERE 產品編號 IN (50,51)
Group By 產品編號,單價
WITH cube


--grouping sets
SELECT 產品編號, 單價 , SUM(數量) [總數量]
FROM dbo.[訂貨明細]
WHERE 產品編號 IN (50,51)
Group By grouping sets((產品編號,單價),產品編號,())

--ORDER BY 排序
SELECT 產品編號, 單價, SUM(數量) [總數量]
FROM dbo.[訂貨明細]
WHERE 產品編號 IN (50,51,52,53,54,55)
Group By 產品編號,單價
order by 產品編號 desc,單價

--購買次數最多的3項產品
select top  3 with ties 產品編號,count(產品編號) 購買次數
FROM   訂貨明細
group by 產品編號
order by 購買次數 DESC


--分頁
select * from 訂貨主檔
ORDER BY 訂單號碼 OFFSET 5 row
go

select * from 訂貨主檔
ORDER BY 訂單號碼 OFFSET 0 row FETCH NEXT 10 ROWS ONLY






--請列出訂單10590和10621所購買的產品
select 訂貨明細.訂單號碼,產品資料.產品 
from 訂貨明細  join  產品資料  on  訂貨明細.產品編號=產品資料.產品編號
where 訂貨明細.訂單號碼 in (10590,10621)
go



--請列出訂單10590至10621的客戶名稱、聯絡人及負責的訂單人員
SELECT   O.訂單號碼 [訂單編號], C.公司名稱 [客戶名稱], C.連絡人 [客戶連絡人], E.姓名 [負責員工]
FROM    員工  E  JOIN  訂貨主檔 O  ON  E.員工編號=O.員工編號
				 JOIN  客戶 C      ON  O.客戶編號=C.客戶編號
WHERE    訂單號碼 between 10590 AND 10621
ORDER BY  訂單號碼
GO

--SQL-89
SELECT   O.訂單號碼 [訂單編號], C.公司名稱 [客戶名稱], C.連絡人 [客戶連絡人], E.姓名 [負責員工]
FROM    員工  E  , 訂貨主檔 O ,  客戶 C  
WHERE    O.客戶編號=C.客戶編號  AND  E.員工編號=O.員工編號   AND  訂單號碼 between 10590 AND 10621
ORDER BY  訂單號碼


--請找出沒有訂單的客戶
SELECT  C.客戶編號 , C.公司名稱 , O.訂單號碼
FROM    客戶 C  LEFT  JOIN  訂貨主檔 O  ON C.客戶編號=O.客戶編號
WHERE  O.客戶編號 IS NULL
GO

GO


--UNION查詢(以第1個查詢的欄位名稱做為執行結果的欄位名稱)
SELECT 城市 A, 行政區
FROM dbo.員工
UNION
SELECT 城市 B, 行政區
FROM dbo.客戶
GO


--UNION 自帶distinct效果，union all可列出重覆資料
SELECT 城市 , 行政區
FROM dbo.員工
UNION all
SELECT 城市 , 行政區
FROM dbo.客戶
GO

--UNION中的Group by與Having需放在各別的查詢指令中，而ORDER BY則放在最後
SELECT 城市 , count(*) 數量 FROM 員工 group by 城市 
UNION 
SELECT 城市 , count(*) FROM 客戶 group by 城市
order by 2
go


--UNION中的INTO只能放在第1個查詢指令
SELECT 城市 , count(*) 數量 into 員工3 FROM dbo.員工 group by 城市 
UNION 
SELECT 城市 , count(*) FROM 客戶 group by 城市
order by 2
go

--UNION可以加入臨時資料
SELECT 城市, 行政區, 區域號碼
FROM 員工
UNION
SELECT 城市, 行政區, 郵遞區號
FROM 客戶
UNION
SELECT '臺灣','台北','882'
go

--intersect 取出兩個查詢結果都有的資料
SELECT 城市, 行政區+'區' 行政區
FROM dbo.員工
INTERSECT
SELECT 城市, 行政區
FROM dbo.客戶

--Except 取出第1個查詢結果有的資料，而第2個查詣結果沒有
SELECT 城市, 行政區
FROM dbo.客戶
EXCEPT
SELECT 城市, 行政區+'區' 行政區
FROM dbo.員工


--建立VIEW(檢視)
create view 訂單客戶
AS
select A.訂單號碼,A.訂單日期,C.客戶編號,C.公司名稱,C.連絡人
from  訂貨主檔 A join 客戶 C ON A.客戶編號=C.客戶編號
GO

--修改VIEW(檢視)
alter view 訂單客戶
AS
select A.訂單號碼,A.訂單日期,A.客戶編號 訂單客編,C.客戶編號 客戶客編,C.公司名稱,C.連絡人,c.電話,a.員工編號
from  訂貨主檔 A join 客戶 C ON A.客戶編號=C.客戶編號
GO

--查詢VIEW(檢視)
select * from 訂單客戶
GO

--資料表 JOIN  view(檢視表)
select oc.訂單號碼,E.姓名 from 訂單客戶 OC join 員工 E ON oc.員工編號=E.員工編號 where 訂單號碼=10260
GO

--子查詢
SELECT 訂單號碼,總數量=(SELECT SUM(數量) FROM dbo.訂貨明細 WHERE dbo.訂貨主檔.訂單號碼=訂單號碼)
FROM dbo.訂貨主檔


--找出沒下過訂單的客戶(子查詢-比對清單)
select * from 客戶 where 客戶編號 not in (select 客戶編號 from 訂貨主檔)
GO

--找出沒下過訂單的客戶(子查詢-測試存在)
select * from 客戶 where not EXISTS (select 客戶編號 from 訂貨主檔 where 客戶.客戶編號=訂貨主檔.客戶編號)
GO

