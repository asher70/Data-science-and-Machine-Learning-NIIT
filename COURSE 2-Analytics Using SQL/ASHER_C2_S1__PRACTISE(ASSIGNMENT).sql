-- TASK 1
CREATE DATABASE techmac_db;-- CREATE DATABASE
use techmac_db;// -- USE  CREATED DATABASE 

-- task 2 
-- CREATING THREE TABLES techyve_employees,techcloud_employees,techsoft_employees WITH APPLYING PRIMARY KEY CONSTRAINT TO PRIMARY KEY AND APPLYING APPROPRIATE DATA TYPE AND NON-NULL VALUES
CREATE TABLE techyve_employees(employeeID Varchar(100) PRIMARY KEY,firstname Varchar(100) not null,lastname Varchar(100) not null ,gender Varchar(100) not null,age int not null);
CREATE TABLE techcloud_employees(employeeID Varchar(100) PRIMARY KEY,firstname VARCHAR(100) not NULL,lastname Varchar(100) not null ,gender Varchar(100) not null,age int not null);
CREATE TABLE techsoft_employees(employeeID Varchar(100) PRIMARY KEY,firstname Varchar(100) not null,lastname varchar(100) not null,gender varchar(100) not null,age int not null);

-- task 3
-- INSERTING VALUES AND PASSING THEM AND DISPLAYING THEM
insert into techyve_employees(employeeID,firstname,lastname,gender,age )
values('TH0001','Eli','Evans','Male',26),('TH0002','Carlos','Simmons','Male',32),('TH0003','Kathie','Bryant','Female',25),('TH0004','Joey','Hughes','Male',41),('TH0005','Alice','Matthews','Female',52);
select*from techyve_employees;
insert into techcloud_employees(employeeID,firstname,lastname,gender,age)
values('TC0001', 'Teresa', 'Bryant', 'Female', 39),('TC0002', 'Alexis', 'Patterson', 'Male', 48),('TC0003', 'Rose', 'Bell',' Female', 42),('TC0004', 'Gemma', 'Watkins', 'Female', 44),('TC0005', 'Kingston', 'Martinez', 'Male', 29);
select * from  techcloud_employees;
insert into techsoft_employees(employeeID,firstname,lastname,gender,age)
values('TS0001', 'Peter', 'Burtler', 'Male', 44),('TS0002', 'Harold', 'Simmons', 'Male', 54),('TS0003', 'Juliana', 'Sanders', 'Female', 36),('TS0004', 'Paul', 'Ward', 'Male', 29),('TS0005', 'Nicole', 'Bryant', 'Female', 30);
select * from techsoft_employees;

-- task 4 
-- WE HAVE CREATED BACKUP TABLES AND SAVED IT ALSO IN A BACKUP DATABASE

-- techyve_employees_bkp
create table techyve_employees_bkp like techyve_employees;
insert into techyve_employees_bkp
select* from techyve_employees;
select* from techyve_employees_bkp

-- techcloud_employees_bkp
create table techcloud_employees_bkp like techcloud_employees;
insert into techcloud_employees_bkp
select* from techcloud_employees;
select *from techcloud_employees_bkp;

-- techsoft_employees_bkp
create table techsoft_employees_bkp like techsoft_employees;
insert into techsoft_employees_bkp
select* from techsoft_employees;
select* from techsoft_employees_bkp;
-- saving in backup database
-- techyve_employees_bkp
create database backup_techmac_db;
use  backup_techmac_db;
create table techyve_employees_bkp like techmac_db.techyve_employees_bkp;
insert techyve_employees_bkp 
select * from techmac_db.techyve_employees_bkp;
-- techcloud_employees_bkp;
create table techcloud_employees_bkp like techmac_db.techcloud_employees_bkp;
insert techcloud_employees_bkp
select * from techmac_db.techcloud_employees_bkp;

-- techsoft_employees_bkp
create table techsoft_employees_bkp like techmac_db.techsoft_employees_bkp;
techsoft_employees_bkptechsoft_employees_bkpinsert techsoft_employees_bkp
select * from techmac_db.techsoft_employees_bkp;

-- task 5
-- DELETED TWO  VALUES FROM techyve_employees AND techcloud_employees
use techmac_db;
select* from techyve_employees
delete from techyve_employees where employeeID='TH0003';
DELETE FROM techyve_employees where employeeID='TH0005';
select* from techyve_employees;

select* from techcloud_employees;
delete from techcloud_employees where employeeID='TC0001';
DELETE FROM techcloud_employees WHERE employeeID='TC0004';
SELECT *FROM techcloud_employees;

-- techyve_employees CONTAINED 'TH0003' AND 'TH0005'
-- techcloud_employees COMTAINES 'TC0001' AND 'TC0004'