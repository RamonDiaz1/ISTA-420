.echo on
.headers on

--Name:Ramon Diaz Sena
--File:Lab2b-diaz.sql
--Date:January 20, 2021

--1. Who are our customers in North America?
select customerid, companyname, country from customers where country in('Canada', 'USA', 'Mexico');

--2. What orders were placed in April, 1998?
select orderdate, orderid from orders where orderdate like '1998-04%';

--3. What sauces do we sell?
select productid, productName from products where productname like '%sauce%';

--4. You sell some kind of dried fruit that I liked very much. What is its name?
select productid, productName from products where productname like '%dried%';

--5. What employees ship products to Germany in December?
select distinct employeeid from orders where orderdate like '%-12-%' and shipcountry like 'Germany';

--6. We have an issue with product 19. I need to know the total amount and the net amount of all orders
--for product 19 where the customer took a discount.
select orderid, productid, unitprice * quantity as totalamount, (unitprice * quantity) * (1-discount) as netamount, discount from order_details where productid = 19 and discount > 0 ;