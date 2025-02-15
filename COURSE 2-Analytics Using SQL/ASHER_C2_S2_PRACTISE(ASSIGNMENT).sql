-- 02-12-2024
-- ANALYTICS USING SQL
-- SPRINT 2 -PRACTISE
-- TASK 1

-- 1)
USE TECHMAC_DB;-- USING DATABASE TECHMAC_DB
DESC techcloud_employees; -- DESCRIBING TABLE "techcloud_employees"
-- DESC techcloud_employees_bkp;
DESC techsoft_employees; -- DESCRIBING TABLE "techsoft_employees"
-- DESC techsoft_employees_bkp;
DESC techyve_employees;-- DESCRIBING TABLE "techyve_employees"
-- DESC techyve_employees_bkp;

-- WE VERIFIED THERE WAS NO NULL VALUE IN FIRST NAME AND LAST NAME IN ALL TABLES OF  THE DATABASES

--  2)
-- example syntax :alter table employeedbs.employee_details MODIFY   DOB VARCHAR(100) not null default '01-01-1996';
-- q)set the default value of 'age' column as 21 using the default constraint.
alter table techcloud_employees modify age int not null default 21; -- altering the table and modifying age default value as 21
desc techcloud_employees;
alter table techsoft_employees modify  age int not null default 21;-- altering the table and modifying age default value as 21
desc techsoft_employees;
alter table techyve_employees modify age int not null default 21;-- altering the table and modifying age default value as 21
desc techyve_employees;

-- 3)
-- q) the age of the employess should be between 21 and 55.So ,alter the Age column structure with the check constraint.
-- name of startup :techcloud_employees,techsoft_employees,techyve_employees
/*example syntax for : alter table school.new_students add constraint age_chk
check(age>10);-- (AGE BETWEEN 3 AND 10)*/
alter table techcloud_employees add constraint tce_age
check(age between 21 AND 55);-- altering  the table and adding check constraints of age between 21 and 55
alter table techsoft_employees add constraint tse_age
check(age between 21 and 55);-- altering  the table and adding check constraints of age between 21 and 55
alter table techyve_employees add constraint tye_age
check(age between 21 and 55);-- altering  the table and adding check constraints of age between 21 and 55
select *from techyve_employees;

-- 4)
-- q)add two new columns:Username and Password.Both the columns should allow only  unique values.

-- name of startup :techcloud_employees,techsoft_employees,techyve_employees

alter table techcloud_employees  add (Username  varchar(50) unique , Passwort varchar(50) unique);-- adding two columns with unique data type
alter table techsoft_employees add (Username varchar(50) unique ,Passwort varchar(50) unique);-- adding two columns with unique data type
alter table techyve_employees add(Username varchar(50) unique,Passwort varchar(50) unique);-- adding two columns with unique data type
desc techyve_employees;

-- 5)
/* q)THE GENDER OF THE EMPLOYEES SHOULD BE EITHER 'Male' or 'Female'.So ,alter the
Gender column structure with the check constraint*/       
                        
-- name of startup :techcloud_employees,techsoft_employees,techyve_employees
/*alter table school.new_students add constraint age_chk
check(age>10);-- (AGE BETWEEN 3 AND 10)
select * from school.new_students;*/

alter table techcloud_employees add constraint gen_err
check(gender  in('Male',' Female'));-- kept constraint for male  or female
alter table techsoft_employees add constraint gen_errr
check(gender in('Male','Female'));-- kept constraint for male  or female

alter table  techyve_employees  add constraint gen_er
check(gender in ('Male','Female'));-- kept constraint for male  or female
select * from techyve_employees;

-- Task 2
-- 1) 
-- q) alter the three tables and add a new column called Communication_Proficiency.

-- name of startup :techcloud_employees,techsoft_employees,techyve_employees
-- syntax :alter table techcloud_employees  add (Username  varchar(50) unique , Passwort varchar(50) unique);

alter table techcloud_employees add (Communication_Proficiency int  );-- adding a new column with int data type
alter table techsoft_employees add (Communication_Proficiency int );-- adding a new column with int data type
alter table techyve_employees add(Communication_Proficiency int);-- adding a new column with int data type
-- select *from techyve_employees;

-- 2)
-- q) Apply a check constraint to make sure the values are withinn the specified range (1 to 5).
-- syntax:
/*example syntax for : alter table school.new_students add constraint age_chk
check(age>10);-- (AGE BETWEEN 3 AND 10)*/

alter table techcloud_employees add constraint cp_chk
check(Communication_Proficiency BETWEEN 1 AND 5);-- adding constraint to Communication_Proficiency for keeping it betwwen 1 and 5
ALTER TABLE techsoft_employees ADD CONSTRAINT CP_CH
CHECK(Communication_Proficiency BETWEEN 1 AND 5);-- adding constraint to Communication_Proficiency for keeping it betwwen 1 and 5
ALTER TABLE techyve_employees ADD CONSTRAINT CP_CC
CHECK(Communication_Proficiency BETWEEN 1 AND 5);-- adding constraint to Communication_Proficiency for keeping it betwwen 1 and 5

-- 3) 
-- Q) SET THE DEFAULT VALUE OF THIS COLUMN AS 1
-- SYNTAX : alter table techyve_employees modify age int not null default 21;
ALTER TABLE techcloud_employees MODIFY Communication_Proficiency INT DEFAULT 1;-- altering the table by keeping Communication_Proficiency column default 1.
ALTER TABLE techsoft_employees MODIFY Communication_Proficiency INT DEFAULT 1;-- altering the table by keeping Communication_Proficiency column default 1.
ALTER TABLE techyve_employees MODIFY Communication_Proficiency  INT DEFAULT 1; -- altering the table by keeping Communication_Proficiency column default 1.


-- TASK 3
-- 1)
-- Q) merge techcloud_employees,techyve_employees MERGE THE DATA OF THESE TWO STARTUPS IN A NEW TABLE CALLED techyvecloud_employees.
create table techyvecloud_employees like techyve_employees;-- creating table structure like existing table
insert into techyvecloud_employees
select* from techyve_employees;-- insering techyve_employees to techyvecloud_employees
insert into techyvecloud_employees(employeeID,firstname,lastname,gender,age)
values('TC0002','Alexis','Patterson','Male',48),('TC0003','Rose','Bell', 'Female',42),('TC0005','Kingston','Martinez','Male',29);-- inserting techcloud_employees manually 

select* from techyvecloud_employees;-- displaying column 
-- 2)
-- q) create a backup database of techcloud_employees and techyve_employees
-- backup database of techcloud_employees
create table techcloud_employees_bk like techcloud_employees;
insert into techcloud_employees_bk 
select* from techcloud_employees;
-- backup database of techyve_employees
create table techyve_employees_bk like techyve_employees;
insert into techyve_employees_bk
select * from techyve_employees;

-- 3) delete the records from the tables techcloud_employees and techyve_employees
truncate table techcloud_employees;-- deleting record from table but keeping structure
truncate table techyve_employees;-- deleting record from table but keeping structure
truncate table techyve_employees;


