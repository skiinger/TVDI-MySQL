--掛載資料表
create database data0606 
ON (FileName='D:\DB\NorthwindC.mdf')
FOR ATTACH
go

use data0606

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
select top 3 with ties E.姓名,round(sum(單價*數量*(1-折扣)),2)'年度業績'
from 訂貨主檔 OC join 員工 E
on OC.員工編號 = E.員工編號
join 訂貨明細 OD
on OC.訂單號碼 =OD.訂單號碼
where year(OC.訂單日期) = 1997
group by  E.姓名
order by 年度業績 desc
go


--3.請提供1996年飲料類產品銷售數量低於該類產品當年度銷售平均數量的訂單號碼及客戶

select PD.產品編號,PD.產品,OC.訂單號碼,OD.數量 '訂購數量',C.公司名稱
from 訂貨主檔 OC join 客戶 C
on OC.客戶編號 = C.客戶編號
join 訂貨明細 OD
on OC.訂單號碼 = OD.訂單號碼
join 產品資料 PD
on OD.產品編號 = PD.產品編號
where year(OC.訂單日期) = 1996 and PD.類別編號 = 1
group by OC.訂單號碼,PD.產品編號,PD.產品,OD.數量,C.公司名稱
having OD.數量 < (select sum(訂貨明細.數量)/count ( 訂貨明細.訂單號碼)
from 訂貨明細 join 產品資料
on 訂貨明細.產品編號 = 產品資料.產品編號
where 產品資料.類別編號 = 1)
order by 1
go

--4.請找出交易金額(單價*數量*(1-折扣))達15,000元以上的訂單、承辦人員及客戶。
select OD.訂單號碼 , E.姓名 [承辦人員],C.公司名稱 [客戶],sum(OD.單價*OD.數量*(1-OD.折扣)) [交易金額]
from 訂貨明細 OD join 訂貨主檔 OC
on OD.訂單號碼 = OC.訂單號碼
join 員工 E
on OC.員工編號 = E.員工編號
join 客戶 C
on OC.客戶編號 = C.客戶編號
group by OD.訂單號碼,E.姓名,C.公司名稱
having sum(OD.單價*OD.數量*(1-OD.折扣)) >= 15000
order by 1
go

--5.請統計員工1996,1997,1998年業績，業績取至小數位第2位，第3位四捨五入，
--  並以年度為欄位顯示統計資料，當年度沒有業績者以無交易顯示。

select 員工姓名, isnull(cast([1996] as varchar),'無交易')'1996年業績',isnull(cast([1997] as varchar),'無交易')'1997年業績',isnull(cast([1998] as varchar),'無交易')'1998年業績'
from (select 姓名 as 員工姓名,round(sum(OD.單價*OD.數量*(1-OD.折扣)),2) as 業績,year(訂單日期) as 年度
FROM 員工 E full JOIN 訂貨主檔 OC
on E.員工編號 = OC.員工編號
full JOIN 訂貨明細 OD
on OC.訂單號碼 = OD.訂單號碼
group by 姓名,year(訂單日期)) as ONY
pivot (sum(業績) for ONY.年度 in ([1996],[1997],[1998])) as P
go