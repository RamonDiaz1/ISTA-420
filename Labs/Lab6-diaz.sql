-- Name: Ramon Diaz Sena
-- File: Lab06-diaz.sql
-- Date: February 8, 2021
use tsqlv4;

--1. Find employees IDs who had orders in both January 2016 AND February 2016.

select o.empid from Sales.Orders o where o.orderdate 
like '2016-01-%' --Jan empid
intersect
select o1.empid from Sales.Orders o1 where 
o1.orderdate >= '2016-02-01' and o1.orderdate < '2016-03-01'; --Feb empids

--2. Find employees IDs who had orders in both January 2016 OR February 2016.

select o.empid from Sales.Orders o where o.orderdate 
like '2016-01-%' --Jan empid
union
select o1.empid from Sales.Orders o1 where 
o1.orderdate >= '2016-02-01' and o1.orderdate < '2016-03-01'

--3. Find employees IDs who had orders in both January 2016 but NOT February 2016.

select o.empid from Sales.Orders o where year(o.orderdate) = 2016
except
select o1.empid from Sales.Orders o1 where year(o1.orderdate) = 2014;

-- 4. Citys and countries where we have both customers and employees

select e.city, e.country from hr.Employees e
intersect
select c.city, c.country from Sales.Customers c;

-- 5. Citys and countries where we have ether customers or employees

select e.city, e.country from hr.Employees e
union
select c.city, c.country from Sales.Customers c;

-- 6. Citys and countries where we have ether customers but not employees

select c.city, c.country from Sales.Customers c
except
select e.city, e.country from hr.Employees e;

--7. Citys and countries where we have ether employees but not customers

select e.city, e.country from hr.Employees e
except
select c.city, c.country from Sales.Customers c;

--8. Citys and countries where we have employees but not customers and
-- Citys and countries where we have customers but not employees

(select e.city, e.country from hr.Employees e
union
select c.city, c.country from Sales.Customers c)
except
(select e.city, e.country from hr.Employees e
intersect
select c.city, c.country from Sales.Customers c)