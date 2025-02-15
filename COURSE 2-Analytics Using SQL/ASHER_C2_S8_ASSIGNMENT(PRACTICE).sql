-- COURSE 2 SPRINT 8 ASSIGNMENT

USE ecommerceinvdb;-- USING THE DATABASE

-- Task 1
-- Write a query to create a trigger that ensures the data integrity of the "order_items" table. This trigger must
-- incorporate the following functionalities:
    -- • It checks for negative quantities or a quantity value of O in the NEW row (representing the attempted
    -- insert).
--  It retrieves the current stock level for the product using a SELECT statement.
--  If the quantity is negative or the stock is insufficient, it throws an error message using SIGNAL, thereby preventing the insert operation.
DELIMITER $$
CREATE TRIGGER DC -- CREATED TRIGGER
BEFORE INSERT ON order_items FOR EACH ROW -- INSERTING  BEFORE ON ORDER_ITEMS FOR EACH ROW 
BEGIN 
DECLARE current_stock_level INT;-- DECLAARING  A VARIABLE CALLED  current_stock_level TO STORE stock_level  FROM PRODUCTS 
-- TABLE WHERE COMMON COLUMN product_id MATCHES TO INPUTING product_id COLUMN
SELECT stock_level  INTO current_stock_level  FROM PRODUCTS WHERE product_id=NEW.product_id;
IF NEW.quantity<=0  THEN -- IF IT IS LESS THAN OR EQUAL TO ZERO DISPLAY  "negative  quantities OR NULL quantities "
SIGNAL SQLSTATE '45000' SET message_text="negative  quantities OR NULL quantities ";
ELSEIF  current_stock_level<NEW.quantity THEN  -- IF NEW.quantity  IS GREATER THAN
--  current_stock_level DISPLAY "stock is insufficient" MESSAGE
SIGNAL SQLSTATE'45000' SET message_text="stock is insufficient";
END IF;
END;$$


-- Task 1 (cont'd)
-- Write a query to insert a new record into the order_items table with order_id=1, product_id=3, and quantity=0.
-- Write a query to insert a new record into the order_items table with order_id=1, product_id=3, and quantity=-1.
INSERT INTO ORDER_ITEMS (order_id,product_id,quantity)
VALUES(1,3,0);-- INPUTED 0 IN NEW.QUANTITY AND GOT  ERROR MESSAGE MESSAGE 
INSERT INTO ORDER_ITEMS(order_id,product_id,quantity)
VALUES(1,3,-1);-- INPUTED -1  IN NEW.QUANTITY AND GOT  THE SAME  ERROR MESSAGE MESSAGE  AS ABOVE

-- Task 2
-- Write a query to add a new column named total_amount to the Orders table with the following structure:
-- total_amount DECIMAL (10,2)
ALTER TABLE ORDERS ADD COLUMN total_amount DECIMAL (10,2);-- adding column total_amount  with decimal(10,2) data type in orders table
-- Write queries to update total_amount value of all orders to 0.
SET SQL_SAFE_UPDATES=0;-- temporarly disabled safe mode
UPDATE ORDERS SET total_amount=0 WHERE order_id=order_id;-- updated new column value as 0 where order id is same as the row's.

-- Create a daily_sales table with the following structure: Id INT PRIMARY KEY AUTO_INCREMENT,
-- sale_date DATE,
-- total_sales DECIMAL (10,2)
CREATE TABLE daily_sales(Id INT PRIMARY KEY AUTO_INCREMENT,sale_date DATE, total_sales DECIMAL (10,2));
-- created table daily_sales with three columns  Id ,sale_date,total_sales with their respective data type and making id as primary key with auto increment so we need not always mention it thus keeping uniqueness

-- Task 2 (cont'd)
-- Write a query to create a trigger which will fire after successful insertions of any new record 
-- to the order_items table. This trigger should follow the following functionalities:
-- • Calculates the new total by adding the inserted
-- item's product price and quantity to the existing total, then updates the orders table accordingly.
-- Stores daily sales summary information by inserting a new row into the daily_sales table with the 
-- current date (CURDATE()) and the total amount from the newly updated order.
DELIMITER $$
CREATE TRIGGER INSERA -- createed trigger "inser " after inserting on order_items for every row
 AFTER INSERT ON order_items
 FOR EACH ROW
 BEGIN
 DECLARE total  DECIMAL(10,2);-- declared total with decimal data type
 SELECT P.price*NEW.quantity INTO total  FROM PRODUCTS as p WHERE P.product_id=NEW.product_id;-- calculated from price and inserted quantity total we inserted into total variable where the product ids of product table and inserting matches
UPDATE  ORDERS SET total_amount=total where  order_id=new.order_id;-- updated table orders where we set total in total_amount  where both order id matched
insert into daily_sales(sale_date,total_sales)-- inserted current date and total to both columns of daily_sales table.
values(CURDATE(),total);
END;$$

-- Task 2 (cont'd)
-- Write a query to insert a new record into the order_items
-- table with order_id=10, product_id=1 and quantity=2.
insert into order_items(order_id,product_id,quantity)
values(10,1,2);-- tested with inserting 
SELECT * FROM daily_sales;
SELECT * FROM ORDER_ITEMS;
SELECT * FROM ORDERS;
