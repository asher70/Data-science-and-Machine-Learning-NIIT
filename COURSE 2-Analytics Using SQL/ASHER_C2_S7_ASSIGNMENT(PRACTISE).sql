-- COURSE 2 SPRINT 7 ASSIGNMENT
USE librarydb;-- USING DB 

--  TASK 1

-- WRITE A QUERY TO CREATE A PROCEDURE THAT ACCEPTS AN AGE
-- GROUP AS A PARAMETER AND RETRIEVES THE MOST POPULAR 
-- BOOKS(E.G., TOP 10) BORROWED BY USERS IN THAT AGE
-- GROUP.
delimiter $$
CREATE PROCEDURE SP_AGE_GRP(IN age_groupS VARCHAR(20))-- CREATING PROCEDURE AND VARIABLE FOR RETREIVING
BEGIN
SELECT B.title AS "THE MOST POPULAR BOOKS",COUNT(BR.borrower_id) AS "COUNT OF BOOKS"FROM books AS B JOIN -- WE HAVE SELECTED TITLE OF BOOKS, AND COUNTED BORROWER_ID TO KNOW COUNT OF BOOK'S.
 LOANS AS L ON B.book_id=L.book_id
 JOIN borrowers AS BR ON L.borrower_id-- INCLUDING UPPER WE JOINED TWO TABLES
 =BR.borrower_id WHERE BR.age_group=age_groupS  GROUP BY(B.title )-- WE SUMMARIZED BY NAME OF BOOK
 ORDER BY(COUNT(BR.borrower_id)) DESC LIMIT 10;-- WE COUNTED CUSTOMERS AKA COUNT OF MOST TAKEN BOOKS  IN DESCENDING ORDER AND SHOWCASTED  10 ENNTRIES

END;$$

CALL SP_AGE_GRP('Teens (13-19)');-- WE CALLED THE DATA TO  VERIFY
-- TASK 2 

-- WRITE A QUERY TO CREATE A PROCEDURE THAT ACCEPTS YEAR AS
-- A PARAMETER AND CALCULATES THE NUMBER OF LOANS ISSUED
-- FOR EACH MONTH WITHIN THAT YEAR.
SELECT * FROM books;
SELECT * FROM borrowers;
SELECT * FROM loans;
DESC LOANS;
ALTER TABLE loans ADD COLUMN YEAR INT; -- WE INSERTED A COLUMN YEAR
UPDATE loans SET YEAR=YEAR(loan_date) WHERE loan_id=loan_id;-- WE UPDATED YEAR TABLE BY ADDING ENTRIES VIA CALCULATING WITH ANOTHER TABLE
SET SQL_SAFE_UPDATES=0;-- SWITCHED OF THIS MODE TO RUN ABOVE CODE

DELIMITER $$
CREATE PROCEDURE SP_NOLPERMON(IN  AYEAR INT)
BEGIN
SELECT MONTHNAME(loan_date) AS"MONTH NAME",COUNT(borrower_id) AS "NO OF LOANS ISSUED" -- WE SELECTED MONTHNAME OF DATE
FROM loans WHERE YEAR= AYEAR-- PARAMETER PASSING VALUE
 GROUP BY(MONTHNAME(loan_date)) ORDER BY(COUNT(borrower_id));-- SUMMARIZED BY MONTHNAME OF LOANDATE COLUMN AND COUNTED BORROWER_ID TO KNOW NO OF LOANS ISSUED
END;$$

CALL SP_NOLPERMON(2024);
-- TASK 3

-- WRITE A QUERY TO CREATE A PROCEDURE THAT CREATES a
-- NEW LOAN ENTRY IN THE LOANS TABLE.IT ACCEPTS BOOK 
-- AND BORROWER ID'S AS PARAMETERS AND INSERTS A NEW RECORD
-- WITH THE CURRENT DATE AND A CALCULATED DUE DATE
-- BASED ON THE LIBRARY'S LOAN PERIOD POLICIY.
SELECT * FROM books;
SELECT * FROM borrowers;
SELECT * FROM loans;

DELIMITER $$
CREATE PROCEDURE SP_INS(IN Abook_id INT,IN Bborrower_id INT)
BEGIN
INSERT INTO  loans (loan_id,book_id,borrower_id,loan_date,return_date,YEAR )
VALUES(loan_id,Abook_id, Bborrower_id,curdate(),DATE_ADD(curdate(), INTERVAL 13 DAY),YEAR=YEAR) ; -- CALCULATED LOAN_DATE USING CURDATE FN AS PER THE QUESTION CALCULATED RETURN DATE AFTER 13 DAY
END;$$

CALL  SP_INS(1,2);
SELECT * FROM loans;

-- TASK 4 

-- WRITE A QUERY TO CREATE A PROCEDURE THAT UPDATES THE
-- RETURN DATE FOR A SPECIFIC LOAN IDENTIFIED BY THE LOAN_ID PARAMETER.IT
-- ESSENTIALLY PERFORMS AN UPDATE OPERATION
-- ON THE LOANS TABLE ,SETTING THE RETURN_DATE TO THE CURRENT
-- DATE.
SELECT * FROM loans;

DELIMITER $$
CREATE PROCEDURE SP_IDDD( IN Aloan_id INT )
BEGIN
SET SQL_SAFE_UPDATES=0;
UPDATE loans SET return_date=curdate() WHERE loan_id=ALOAN_ID;
END;$$
CALL SP_IDDD(1)

-- TASK 5

DELIMITER $$
CREATE PROCEDURE SP_UP2(IN Aborrower_id INT ,IN Bname VARCHAR(50),IN Cemail VARCHAR(50))
BEGIN
UPDATE BORROWERS SET borrower_id=Aborrower_id ,name=Bname,email=Cemail WHERE borrower_id=Aborrower_id;
END ;$$
CALL SP_UP2(1,'ADAM','adam.smith@example.com');
SELECT * FROM BORROWERS;

-- task 6
-- Task 6(part 1)
-- Write a query to create a procedure that accepts a borrower ID as a parameter. 
-- It retrieves the borrower's record from the loans table and checks for any outstanding 
-- overdue books. Based on the presence of overdue books, the procedure returns the status
--  of the borrower, indicating whether the borrower is eligible for borrowing
-- (if the borrow count is not greater than 0) or not.
-- Hint: Utilize IF-THEN-ELSE (refer to Additional Material) to check the eligibility status of borrowers.
SELECT * FROM BORROWERS;
SELECT * FROM BOOKS;
SELECT * FROM LOANS;
DELIMITER $$
create procedure SP_CHECK(
in Aborrower_ID INT, out out_overdue_count int, out out_is_eligible varchar(100))
Begin
select COUNT(*) INTO out_overdue_count FROM LOANS 
where borrower_id=Aborrower_ID  and return_date IS NULL;

IF out_overdue_count > 0 Then
 set  out_is_eligible = 'not eligible';
Else 
 set out_is_eligible = 'eligible';
END IF;

END;$$


-- Task 6(part 2)

-- Write another query to create a procedure that calls the above procedure 
-- and customizes the output by accepting a borrower ID as a single parameter.
DELIMITER $$
create procedure SP_CHECK2(In in_borrwer_id int)
Begin
Declare out_overdue_count int;
Declare out_is_eligible varchar(20);

call  SP_CHECK( in_borrwer_id, @out_overdue_count, @out_is_eligible);

select Concat('Total count of overdue is', @out_overdue_count, 
' ',' so the borrower is', @out_is_eligible )as 'status';

End;$$

CALL SP_CHECK2(1);

