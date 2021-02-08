##TSQL EX 02 — Simple Queries

.echo on
.headers on

--Name:Ramon Diaz Sena
--File:TSQLEX2.sql
--Date:January 24, 2021

--1. List the company name, the contact name and the country of all customers in Poland.
select companyname, contactname, country from customers where country in('Poland');

--2. List the order Id, the order date, and the destination city of all orders shipped to Berlin.
select orderid, orderdate, shipcity from orders where shipcity = 'Berlin';

--3. How many boxes of Filo Mix do we have in stock?
select productname, unitsinstock from products where productname = 'Filo Mix';

--4. List the telephone numbers of all of our shippers.
select * from shippers;

--5. Who is our oldest employee? Who is our youngest employee?
select firstname, lastname, birthdate from employees order by birthdate desc;

--6. List the suppliers where the owner of the supplier is also the sales contact.
select contactname, contacttitle from suppliers where contacttitle like '%owner%';

--7. Mailing Labels
select title, firstname, lastname from employees;
select address from employees;
select city, region, postalcode, country from employees;
select homephone from employees;

--8. Telephone Book
select lastname, firstname, homephone from employees;