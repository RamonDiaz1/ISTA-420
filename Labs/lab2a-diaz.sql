.echo on 
.headers on

--Name: Ramon Diaz
--Date: January 19, 2021
--Lab2a

--1. What are the regions?
select * from region ;

--2. What are the cities?
select * from territories;

--3. What are the cities in the Southern region?
select * from territories where RegionID=4;

--4. How do you run this query with the fully qualified column name?
select territories.TerritoryID, territories.TerritoryDescription, territories.RegionID
from territories where RegionID=4;

--5. How do you run this query with a table alias?
select T.TerritoryID, T.TerritoryDescription, T.RegionID
from territories T where RegionID=4;

--6. What is the contact name, telephone number, and city for each customer?
select c.ContactName, c.Phone, c.City from customers c;

--7. What are the products currently out of stock?
select p.productid, p.productname, p.unitsinstock from products p where unitsinstock=0;

--8. What are the ten products currently in stock with the least amount on hand?
select p.productid, p.productname, p.unitsinstock from products p where unitsinstock>0 order by unitsinstock limit 10;

--9. What are the five most expensive products in stock?
select productid, unitprice, productname from products where unitsinstock > 0 order by unitprice desc limit 5;

--10. How many products does Northwind have? How many customers? How many suppliers?
select count(customerid) from customers;
select count(supplierid) from suppliers;
select count(productid) from products;