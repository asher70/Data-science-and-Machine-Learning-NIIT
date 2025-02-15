-- SPRINT 9   (ASSIGNMENT(PRACTISCE))
-- PROJECT-PART 1
-- DATA DRIVEN ANALYTICS PROJECT-PART 1?
USE `modelcarsdb`;


-- Task 1: Customer Data Analysis

-- 1. Find the top 10 customers by credit limit.
SELECT customerName,creditLimit 
FROM CUSTOMERS ORDER BY creditLimit
 DESC LIMIT 10  ;
-- WE IDENTIFIED the top 10 customers by credit limit 
-- WE FIRST  SELECTED customerName,creditLimit  TO
-- DISPLAY FROM CUSTOMERS TABLE WE LATER ARRANGED BY creditLimit
-- IN DESCENDING ORDER WITH SELECTING TOP 10 OF IT.

-- 2. Find the average credit limit for customers in each country
SELECT country,AVG(creditLimit) as "average credit limit" 
FROM CUSTOMERS GROUP BY (country);
-- WE SELECTED  COUNTRY,AVG(creditLimit)[AVERRAGING CREDIT LIMIT COLUMN] FROM CUSTOMERS
--  TABLE AND SUMMARIZED BY COUNTRY USING GROUP BY FN.


--  3. Find the number of customers in each state.
SELECT STATE, COUNT(customerNumber) AS "number_of_customers"
 FROM CUSTOMERS GROUP BY STATE order by number_of_customers ;
-- WE USED COUNT FUNCTION ON customerNumber COLUMN AND
-- NAMED IT "number of customers"  AND SELECTED STATE
-- COLUMN FROM CUSTOMERS TABLE. SUMMARIZING BY STATE COLUMN.

-- 4. Find the customers who haven't placed any orders.
SELECT customerNumber,customerName FROM 
CUSTOMERS WHERE customerNumber NOT 
IN (SELECT customerNumber FROM ORDERS) ;
-- WE USED SUBQUERY WHERE WE CALCULATED THAT customerNumber
--  NOT IN ORDERS TABLE USING NOT IN KEYWORD.

-- 5. Calculate total sales for each customer.
SELECT O.customerNumber,C.customerName, SUM(OD.priceEach*OD.quantityOrdered) AS "total sales"  
 FROM ORDERS AS O JOIN -- OD.priceEach*OD.quantityOrdered AS "total sales" 
 CUSTOMERS AS C ON O.customerNumber=C.customerNumber
 JOIN ORDERDETAILS AS OD ON O.orderNumber=OD.orderNumber GROUP BY(O.customerNumber) ;
-- WE SELECTED DETAILS SUCH AS O.customerNumber,C.customerName AND USED SUM FUNCTION
-- TO CALCULATE total sales AND JOINED BOTH ORDERS AND CUSTOMERS TABLE BASED ON 
-- customerNumber COLUMN AND SUMMARIZED BY customerNumber COLUMN OF ORDERS
-- TABLE(REP AS O).

-- 6. List customers with their assigned sales representatives.
-- ASSUMING 5 Q 
SELECT O.customerNumber,C.customerName,C.salesRepEmployeeNumber, SUM(OD.priceEach*OD.quantityOrdered) AS "total sales"  
 FROM ORDERS AS O JOIN -- OD.priceEach*OD.quantityOrdered AS "total sales" 
 CUSTOMERS AS C ON O.customerNumber=C.customerNumber
 JOIN ORDERDETAILS AS OD ON O.orderNumber=OD.orderNumber GROUP BY(O.customerNumber) ;
 -- DISPLAYED O.customerNumber,C.customerName,C.salesRepEmployeeNumber AND USED SUM FN FOR  CALCULATING
 -- "total sales" AND REPRESENTING IT USING ALIAS AND JOINING TABLE BASED ON COMMON COLUMN
 -- IN ALL TABLES THEN APPLYING  GROUP BY FN ON CUSTOMERNUMBER COLUMN.
 
 -- GENERAL IF IT IS NOT 5 Q  THIS IS THE ANSWER
SELECT customerNumber,customerName,salesRepEmployeeNumber  FROM CUSTOMERS;
-- SELECTED COLUMNS FROM CUSTOMERS  TABLE.

-- 7. Retrieve customer information with their most recent payment details.
SELECT  P.customerNumber,MAX(paymentDate) AS "most recent payment " 
,C.customerName ,C.phone,C.country FROM PAYMENTS  AS P
  JOIN CUSTOMERS AS C ON P.customerNumber=C.customerNumber 
  GROUP BY P.customerNumber,C.customerName ,C.phone,C.country;
  -- SELECTED P.customerNumber,C.customerName ,C.phone
  -- ,C.country FROM TABLES WHERE WE JOINED TABLE BASED
  -- ON COMMON COLUMN AND USED MAX FN TO CALCULATE MOST RECENT PAYMENT
  -- AND SUMMARIZED  BY THE FOLLOWING COLUMNS
  -- P.customerNumber,C.customerName ,C.phone,C.country
 
-- 8. Identify the customers who have exceeded their credit limit. 
-- (SELECT AVG(creditLimit) FROM CUSTOMERS);--  AVG '67659.016393' credit limit  SO KEEPING IS CRITERIA FOR CHECKING EXCEDING CREDIT LEVEL
SELECT customerNumber,customerName,creditLimit
FROM CUSTOMERS WHERE creditLimit>
(SELECT AVG(creditLimit) FROM CUSTOMERS);
-- WE SOLVED USING SUBQUERY WHERE WE SELECTED COLUMNS FROM
-- CUSTOMER TABLE WHERE CREDIT LIMIT WAS GREATER THAN 
-- AVERAGE CREDIT LIMIT INDICATING the customers who have
-- exceeded their credit limit

-- 9. Find the names of all customers who have placed an order for a product from a specific product line.
SELECT * FROM PRODUCTS;-- productCode,productLine
SELECT * FROM ORDERDETAILS;-- orderNumber,productCode
SELECT * FROM CUSTOMERS;-- customerNumber
SELECT * FROM ORDERS;-- orderNumber,customerNumber
-- MAIN 
DELIMITER $$
CREATE PROCEDURE SP1(productLineSS VARCHAR(100)) 
BEGIN
SELECT P.productLine,O.orderNumber,C.customerName,
C.contactFirstName,C.contactLastName
FROM PRODUCTS AS P JOIN ORDERDETAILS AS O 
 ON P.productCode=O.productCode JOIN ORDERS AS
 OD ON O.orderNumber=OD.orderNumber JOIN CUSTOMERS 
 AS C ON OD.customerNumber=C.customerNumber 
 WHERE P.productLine= productLineSS ;
END;$$

-- CALLING for a product from a specific product line.
CALL SP1('Classic Cars');
CALL SP1('Motorcycles');
CALL SP1('Planes');
CALL SP1('Ships');
CALL SP1('Trains');
CALL SP1('Trucks and Buses');
CALL SP1('Vintage Cars');
-- WE USED STORED PROCEDURE TO  ACCES a specific product line
-- WE JOINED 4 TABLES TO ARRIVE AT THIS OURCOME
-- WE JOINED TABLES WITH  COMMON COLUMN.

-- 10. Find the names of all customers who have placed an order for the most expensive product.

-- ASSUMING 'buyPrice' AS PRICE FROM PRODUCTS

-- FINDING most expensive product
 SELECT P.productName ,MAX(P.buyPrice) FROM 
 PRODUCTS AS P GROUP BY P.productName ORDER 
 BY MAX(P.buyPrice) DESC LIMIT 1;
 -- IT IS '1962 LanciaA Delta 16V'
 
-- MAIN QUERY TO Find the names of all customers who have 
-- placed an order for the most expensive product '1962 LanciaA Delta 16V'
SELECT P.productName,P.buyPrice,O.orderNumber,C.customerName,
C.contactFirstName,C.contactLastName
FROM PRODUCTS AS P JOIN ORDERDETAILS AS O 
 ON P.productCode=O.productCode JOIN ORDERS AS
 OD ON O.orderNumber=OD.orderNumber JOIN CUSTOMERS 
 AS C ON OD.customerNumber=C.customerNumber 
 WHERE P.productName ='1962 LanciaA Delta 16V' ;
 
 
 
 
-- Task 2: Office Data Analysis

-- 1. Count the number of employees working in each office.
-- THE COLUMNS IN COMMENTS WERE SELECTED
SELECT * FROM EMPLOYEES;-- officeCode,employeeNumber
SELECT * FROM offices;-- officeCode,city
-- MAIN QUERY
SELECT COUNT(employeeNumber) AS "number of employees ",O.officeCode,O.city
 FROM EMPLOYEES AS E JOIN offices AS O
 ON E.officeCode=O.officeCode GROUP BY O.officeCode,O.city;
 -- WE SELECTED 3 COLUMNS WITH A COLUMN 
 -- employeeNumber WE USED COUNT FN  AND
 -- JOINED EMPLOYEES AND offices BASED ON
 -- OFFICE CODE AND GROUPED BY O.officeCode,O.city

-- 2. Identify the offices with less than a certain number of
-- employees.

-- SINCE THERE IS NO MENTION OF NUMBER 
-- WE ARE TAKING the offices with less than 3

SELECT * FROM EMPLOYEES;-- officeCode,employeeNumber
SELECT * FROM offices;-- officeCode,city
-- MAIN QUERY
SELECT COUNT(employeeNumber) AS "number of employees ",O.officeCode,O.city
 FROM EMPLOYEES AS E JOIN offices AS O
 ON E.officeCode=O.officeCode GROUP BY O.officeCode,O.city
 HAVING  COUNT(employeeNumber)<3  ;
 -- WE SELECTED 3 COLUMN AND USED COUNT FN IN THAT AND JOINED BOTH TABLES 
 -- USING OFFICECODE COLUMN WHICH IS COMMON IN BOTH TABLE AND WE GROUPED BY 2 COLUMNS 
 -- AND USED HAVING TO CALCULATE number of employees LESS THAN 3
 -- WE FOUND 4 ENTRY'S IN IT OFFICE OF BOSTON,NYC,TOKYO,LONDAN CAME
 -- UNDER LESS THAN 3 EMPLOYEES WITH 2 EMPLOYEES IN 4 OFFICES.
 
-- 3. List offices along with their assigned territories.
SELECT officeCode,city,territory FROM offices;
-- SELECTED COLUMNS FROM OFFICES TABLE 
-- WE FOUND 3 EMPTY ROWS 
-- THE ENTRY DID'T HAVE ENTRY
--  ON  assigned territories

-- 4. Find the offices that have no employees assigned to them.

SELECT E.officeCode,COUNT(E.employeeNumber) 
AS "no OF employees" FROM offices
 AS O JOIN EMPLOYEES AS E ON
 O.officeCode=E.officeCode
 GROUP BY E.officeCode;
 -- EVERY OFFICE HAS EMPLOYES THERE IS 
 -- NO OFFICE WHICH HAS  no employees assigned to them

-- 5. Retrieve the most profitable office based on total sales.

SELECT OC.officeCode,OC.city, SUM(OD.priceEach*OD.quantityOrdered) AS "total sales"  
 FROM ORDERS AS O JOIN -- OD.priceEach*OD.quantityOrdered AS "total sales" 
 CUSTOMERS AS C ON O.customerNumber=C.customerNumber
 JOIN ORDERDETAILS AS OD ON O.orderNumber=OD.orderNumber 
 JOIN offices AS OC ON C.CITY=OC.CITY GROUP BY(OC.officeCode) ORDER BY(SUM(OD.priceEach*OD.quantityOrdered)) DESC LIMIT 1;
-- NYC IS THE MOST PROFITABLE OFFICE WITH A TOTAL SALES OF 497941.50

-- 6. Find the office with the highest number of employees. 
SELECT E.officeCode,O.CITY,COUNT(E.employeeNumber) AS "no OF employees" FROM offices
 AS O JOIN EMPLOYEES AS E ON
 O.officeCode=E.officeCode
 GROUP BY E.officeCode,O.CITY ORDER BY COUNT(E.employeeNumber) DESC LIMIT 1 ;
 
 -- SAN FRANSICO OFFICE HAS THE HIGHEST NO OF EMPLOYEES 6.
 
-- 7. Find the average credit limit for customers in each office. 
DESC EMPLOYEES;
DESC offices;
DESC CUSTOMERS;
-- THERE IS NO PK OR FK MATCHING CUSTOMER,offices SO ASSUMING ALL CUSTOMERS 
-- HAVE BOUGHT OUT OF THEIR RESPECTIVE CITY  OFFICES

-- MAIN QUERY
SELECT AVG(creditLimit) AS "average credit limit",O.officeCode,O.city
  FROM offices  AS O JOIN CUSTOMERS  AS C 
  ON O.city=C.city GROUP BY (O.officeCode) ORDER BY (AVG(creditLimit)) DESC ;
  -- NYC  HAS HIGHEST AVERAGE CREDIT LIMIT,LONDON  HAS LOWEST  AVERAGE CREDIT LIMIT

 -- 8. Find the number of offices in each country.

SELECT country,COUNT(officeCode) AS
 "number of offices " FROM offices
 GROUP BY (country);
 -- USA HAS THE HIGHEST OFFICE 3 AMONG OTHER COUNTRIES.
 -- REST ALL COUNTRIES HAS AN OFFICE
 
/* 
 DESC EMPLOYEES;
DESC offices;
DESC CUSTOMERS;
DESC PRODUCTS;
SELECT * FROM CUSTOMERS;-- CITY,CUSTOMERNUMBER
SELECT * FROM ORDERS;
SELECT * FROM ORDERDETAILS;-- orderNumber,productCode
SELECT * FROM PAYMENTS;
SELECT * FROM PRODUCTS;
SELECT * FROM EMPLOYEES;-- officeCode,employeeNumber
SELECT * FROM offices;-- officeCode,city
 */
 
 
 
 
 
 -- Task 3: Product Data Analysis
 
-- 1. Count the number of products in each product line.

DESC PRODUCTS;
SELECT * FROM PRODUCTS;
-- MAIN QUERY
SELECT productLine,COUNT(productLine) AS "number of products" FROM PRODUCTS
GROUP BY (productLine) order by COUNT(productLine) desc ;
-- CODE TO DISPLAY THE COUNT OF PRODUCTS IN EACH PRODUCT LINE
-- WE SELECTED PRODUCT LINE,COUNTED FN WITH PRODUCT LINE WE ALIASED NAMED IT number of products
-- WE SELECTED THE COLUM PRODUCT LINE FROM PRODUCTS TABLE AND LATER GROUPED BY OR SUMMARIZED BY productLine.
-- classic cars  had most no of products 38 and trains had least 3.
-- 2. Find the product line with the highest average product pricE.
 DESC PRODUCTS;
SELECT * FROM PRODUCTS;


SELECT productLine,AVG(buyPrice) AS "average product pricE" FROM PRODUCTS
 GROUP BY (productLine) ORDER BY AVG(buyPrice) DESC LIMIT 1;
 
-- WE SELECTED COLUMNS productLine WITH APPLYING AVG FN IN BUY
-- PRICE COLUMN TO GET AVG OF BUY PRICE BASED ON  BASED ON PRODUCTLINE 
-- WE LATER SUMMARIZED BY PRODUCTLINE  AND ARRANGED AVG FN ON buyPrice
-- IN DESCENDING ORDER  AND SELECTED MOST BY LIMITING IT 1
-- 'Classic Cars' HAD HIGHEST average product pricE WITH A PRICE OF '64.446316'

 -- 3. Find all products with a price above or below a certain amount (MSRP should be between 50 and 100).
SELECT productName,productLine,MSRP FROM PRODUCTS
WHERE MSRP BETWEEN 50 and 100;

-- we selected productName, productline,msrp columns from products table 
-- and applied where keyword on msrp betwwen 50 and 100 to 
-- fiilter msrp price between it .

-- 4. Find the total sales amount for each product line.

SELECT productLine,sum(MSRP) as "total sales"
 FROM PRODUCTS
group by productLine  order by sum(MSRP) desc ;

 -- we selected productLine and applied sum fn on msrp and named it total sales
 -- we selected from products table 
 -- and summarized by productLine and arranged by sum(MSRP) in descending order
-- 'Classic Cars' had most  total sales of '4484.80' and 'Trains' had least total sales with '221.56'

-- 5. Identify products with low inventory levels (less than a specific threshold value of 10 for quantityInStock).

select productcode,productName,quantityInStock
  FROM PRODUCTS where quantityInStock<10 ;
  -- there is no product in product line below this threshold
  -- we testeed less than 100
  select productName,productLine,quantityInStock
  FROM PRODUCTS where quantityInStock<100 ;
  -- we got 2 entries
-- 6. Retrieve the most expensive product based on MSRP.

select productName,productLine,max(MSRP)as "price" from PRODUCTS
group by productName,productLine order by max(MSRP) desc  limit 1 ;
-- '1952 Alpine Renault 1300' of 'Classic Cars' is the  most expensive product

-- 7. Calculate total sales for each product.

select productName,
sum(MSRP)as "total sales" FROM PRODUCTS 
group by productName  order by sum(MSRP) desc;
-- we calculated "total sales" for each productName
-- '1952 Alpine Renault 1300' had highest total sales of '214.30',
-- '1939 Chevrolet Deluxe Coupe' had the least sales of '33.19'.

-- 8. Identify the top selling products based on total quantity ordered using a stored procedure. 
-- The procedure should accept an input parameter to specify
-- the number of top-selling products to retrieve.
SELECT * FROM PRODUCTS;-- productCode
SELECT * FROM ORDERDETAILS;-- productCode

delimiter $$
create procedure sp_idproducts(in i_p int)
begin
select od.orderNumber,p.productLine,p.productName,
od.quantityOrdered from PRODUCTS as p
join ORDERDETAILS as od on p.productCode=od.productCode 
order by od.quantityOrdered desc limit i_p ;
end;$$
-- tested
call sp_idproducts(1);
call sp_idproducts(5);
-- created procedure sp_idproducts with input variable i_p passing with data type
-- joined both table orderdetails and products using join based on   common column productcode
-- we arranged by quantity ordered in desc to limit top selling products we passed i_p in limit
-- and tested it after running stored procedure.

-- 9. Retrieve products with low inventory levels (less than a threshold value of 10
-- for quantityInStock) within specific product lines ('Classic Cars', 'Motorcycles').

SELECT * FROM PRODUCTS;
-- since there is no value less than a threshold value of 10
-- as checked in 5q in task 3
-- we took 100
delimiter $$
create procedure lil(in aproductLine varchar(50))
begin
SELECT productName,productLine,quantityInStock
 FROM PRODUCTS where productLine=aproductLine
 and quantityInStock<100;
end;$$
--  testing  on ('Classic Cars', 'Motorcycles')
call lil('Classic Cars');
call lil('Motorcycles');

-- we approached this problem by creatimg stored procedure named lil 
-- where we passed a var of varchar data type
-- we selected columns productName,productLine,quantityInStock from products
-- table where product line was checked based on aproductline var which we created
-- and we applied the threshold value of quantityInStock less than 100
-- we later tested in both and got 68 for 'Classic Cars' and for 'Motorcycles' we got 15.

-- 10. Find the names of all products that have been ordered by more than 10 customers.


SELECT p.productName ,count(o.customerNumber) as "number of customers" FROM PRODUCTS as
 p join ORDERDETAILS as od on p.productCode=od.productCode join ORDERS as o on
 o.orderNumber= od.orderNumber  group by (p.productName)
 having count(o.customerNumber)>10;

-- we joined 3 tables orders ,orderdetails and products based on common condition
-- we selected product name and counted customernumber and summarized by names of products 
-- and applied having keyword to filter more than 10

-- 11. Find the names of all products that have been
-- ordered more than the average number of orders for their product line.

SELECT * FROM ORDERS;-- orderNumber,customerNumber
SELECT * FROM ORDERDETAILS;-- orderNumber,productCode
SELECT * FROM PRODUCTS;-- productName,productLine,productCode

select  p.productName,p.productLine,count(od.orderNumber) as totalOrdered
 from PRODUCTS as p join ORDERDETAILS
 as od on p.productCode=od.productCode 
 group by productName,productLine;
having count(od.orderNumber)> select avg(product_order_count) from 
(select count(od.orderNumber)as product_order_count 
 from PRODUCTS as p join ORDERDETAILS
 as od on p.productCode=od.productCode
 group by(p.productName)as avg_orders);
 -- we have selected productName,p.productLine,count(od.orderNumber)
-- we then joined  table  products and orderdetails based on productCode on both table
-- and summarized by columns productName,productLine we used having clause to see whether
--  count of od.orderNumber  greater than avg which was select count(od.orderNumber)
-- where both codes were equal 
-- summarized by p.productName



