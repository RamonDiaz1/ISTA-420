--Name: Ramon Diaz Sena
--File: TSQLEX4
--Date: February 5, 2021

use tsqlv4;

--1. Use a derived table to build a query that returns the number of distinct products per year that each
--customer ordered. Use internal aliasing. Use a variable to set the customer number. For example, if
--the customer ID is 1234, the query should report the number of distinct products ordered by customer
--1234 for the years 2014, 2015, and 2016.
declare @custnumber as int = 10;


select t1.custid, t1.orderyear, count(distinct productid) countproduct 
from (select o.custid, year(o.orderdate) orderyear, od.productid 
      from sales.orderdetails od join Sales.Orders o on od.orderid = o.orderid) t1
where t1.custid = @custnumber
group by custid, orderyear
order by custid, orderyear



--2. Use multiple common table expressions to build a query that returns the number of distinct products
--per year that each country's customers ordered. Use external aliasing. Use a variable to set the country
--name. For example, if the country name is France, the query should report the number of distinct
--products ordered by French customers for the years 2014, 2015, and 2016.


declare @country nvarchar(15) = N'France';
with T1(Country, OrderYear, ProductId)
as
(select c.country, year(o.orderdate), od.productid 
from Sales.OrderDetails od join Sales.Orders o on od.orderid = o.orderid
		join Sales.Customers c on c.custid = o.custid
),

T2(Country, OrderYear, NumberOfProducts)
as
( select T1.Country, T1.OrderYear, count(distinct T1.ProductId) 
from T1
group by Country, OrderYear
)

select Country, OrderYear, NumberOfProducts
from T2 
Where Country = @country
order by Country, OrderYear


--3. Create a view that shows, for each year, the total dollar amount spent by customers in each country
--for all the years in the database.


drop view if exists Sales.VOrderTotalsByCountry;
go
create view Sales.VOrderTotalsByCountry
as
select c.country, year(o.orderdate) as orderyear, sum(od.unitprice*od.qty) as total_amount
from sales.customers as c
	join sales.orders as o on c.custid = o.custid
	join sales.OrderDetails as od on od.orderid = o.orderid
group by c.country, year(o.orderdate)

go

--4. Create an inline table valued function that accepts as a parameter a country name and returns a table
--with the distinct products ordered by customers from that country. Products are to be identied by
--both product ID and product name.
drop function if exists Sales.getcustomerproducts;
go
create function Sales.getcustomerproducts(@countryname nvarchar(15))
returns table
as
return

select distinct p.productid, p.productname, c.country
from Sales.Customers c
join Sales.Orders o on c.custid = o.custid
join sales.OrderDetails od on o.orderid = od.orderid
join Production.Products p on od.productid = p.productid
where c.country = @countryname
go
select * from Sales.getcustomerproducts('USA')
order by productid;

--5. Use the CROSS APPLY operator to create a query showing the top three products shipped to customers
--in each country. Your report should contain the name of the country, the product id, the product name,
--and the number of products shipped to customers in that country.select country, productname, productid, qty1 from(select ROW_NUMBER() over(partition by country order by country) as row#,c.country, b.productname, b.productid, sum(a.qty) as qty1 from sales.Orders o cross apply(select * from Sales.OrderDetails odwhere o.orderid = od.orderid) across apply(select * from Production.Products pwhere p.productid = a.productid) bcross apply(select * from sales.customers cwhere c.custid = o.custid) cgroup by c.country, b.productname, b.productid) SQ1where row# <= 3order by country, qty1 desc--sales.orders, sales.customers, sales.orderdetails, production.products