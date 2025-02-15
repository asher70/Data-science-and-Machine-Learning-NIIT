-- sprint 5 practisce(assignment)
-- Practice:1:Employee Data anlysis using the HR Schema
USE HR;

-- task1 
-- q)display the employee id,first names,last  names
--  and department names of all employees using subquery.
-- hint:the employee and department details are in two seperate tables.
select e.employee_id,e.first_name,e.last_name ,(select d.department_name  from departments as d 
where d.department_id= e.department_id)as"department names" from 
employees  as e where e.department_id  in
 (select d.department_id from departments as d );
-- intepretation: we selected e.employee_id,e.first_name,e.last_name and passed an inner 
-- query selecting department names where id from both tables matched and named it "department names"
-- and we completed outer query by selectinganother inner query equalling both ids to connect.

-- task 2
-- display the first ,last names,and salaries of the
-- employees whose salaries are greater than the average
-- salary of all employees.grouped by the department id's.
-- hint:this query involves only one table.Try to use
-- aggregate functions.

select *from employees;-- first_name,last_name,salary
select e.first_name,e.last_name,e.salary from employees as e where salary > 
(select avg(sub.salary)from employees as sub) order by(department_id)  ;
-- we selected e.first_name,e.last_name,e.salary from employees
--  table where salary was greater than avg subb table aka employee coppie 
--  salary  we arranged based on  department_)id column

-- task 3
-- display the first names and last names of those 
-- employees of the sales department who have a salary
-- less than the  average salary of all employees of the 
-- sales department.
-- hints:
-- 1) the data for the above task resides in two separate
-- tables,which you should not join.
-- 2) There would be different types of Sales  department.
-- Do consider all of them for the above task.

-- select department_id from departments where department_name ="Sales";
select * from departments;-- department_id,department_name="sales"
select *from employees;
 select first_name,last_name,salary from employees where salary<8955.882353   and -- 8955.882353  is  avg of sales dep 
 employees.department_id in( (select department_id from departments 
 where department_name in("Sales","Government Sales","Retail Sales")))  ;

 -- we first calculated avg salary separaetedly of sales we selected 
 -- the first_name,last_name,salary  columns and applied salary lesss than the avg salary of sales
 -- annd connected by checking whether yhe id was in other tabkle

 /*select avg(salary)  from employees where
 employees.department_id in( (select department_id from departments 
 where department_name in("Sales","Government Sales","Retail Sales")))
 ;-- department_id*/
-- 80 :sales,240:goverment sales,250 retail sales


-- TASK 4
-- DISPLAY THE FIRST NAMES,LAST NAMES, AND SALARIES OF THE 
-- EMPLOYEES WHO HAVE A SALARY HIGHER THAN THE SALARIES OF
-- ALL IT PROGRAMMERS.DISPLAY THE DETAILS OF THE EMPLOYEES
-- IN THE ASCENDING ORDER OF SALARY ,USING SUBQUERIES.
-- HINT :(JOB_ID='IT_PROG')

select * from departments;-- department_id,department_name="sales"
select *from employees;

select e.first_name,e.last_name,e.salary from employees as e  where e.salary>
all(select p.salary from employees  as p where p.job_id='IT_PROG')  order by (e.salary)  ;

-- WE SELECTED DETAILS LIKE FIRST NAMES,LAST NAMES, AND SALARIES WHERE SALARY
--  WAS GREATER THAN ALL  'IT_PROG' WE ARRANGED BY SALARY IN ASCENDING ORDER.

-- TASK 5
-- DISPLAY THE RECORDS OF THE EMPLOYEE(S) WITH THE 
-- MINIMUM SALARY IN THE EMPLOYEES TABLE,GROUPED BY THE 
-- job_id column and arranged in ascending order of salaries.
-- hint :The data for the above task is present in a single table.

select * from departments;-- department_id,department_name="sales"
select *from employees;

 SELECT * FROM employees AS T WHERE T.salary  =
( SELECT  MIN(salary) FROM employees AS P
 WHERE P.job_id=T.job_id )order BY t.job_id,t.salary;
 
--  WE SELECTED ALL DETAILS  FROM employees TABLE WHERE SALARY MIN
 -- WHEN THE JOB ID IS OF ANY DEPARTMENT WE ARRANGED BJOB_ID,SALARY COLUMN 
--  IN  ASCENDING ORDER


-- Task 6
-- Display the first names ,last names ,and department ID'S
-- of the employees whose salary is greater than 60% of
-- the sum of the salaries of all employees of their 
-- respective departments.
-- Hints:
-- 1)The data for the above task is present in a single table.
-- 2)Try to use comparision operator.
select * from departments;-- department_id,department_name="sales"
select *from employees;
select first_name,last_name,department_id ,salary from employees
where salary>any(select sum(salary)*0.6 AS "60% of Total Salaries"
 from employees group by (job_id));
 -- WE SELECTED THE NECESSARY DEAILS WHERE 
 -- SALARY GREATER THAN ANY 60% SUM OF 
 -- EMPLOYEES SUMMARISED BY JOB_ID COLUMN.


-- Task 7
-- Display the first names and last names of 
-- all those employees who have their managers based out of
-- UK.using subquery.
-- Hint: the data for the above task is present in three different tables.
select * from locations;-- country_id,location_id
select *from employees;-- employee_id, department_id
select * from departments;-- department_id,location_id,manager_id

-- SELECT location_id from locations WHERE country_id = 'UK';
-- select manager_id from departments WHERE location_id IN(SELECT location_id from locations WHERE country_id = 'UK');
SELECT first_name,last_name from employees WHERE manager_id IN
(select manager_id from departments WHERE location_id IN
(SELECT location_id from locations WHERE country_id = 'UK')) ;

-- Task 8 
-- Display the first  names,last names ,and salaries of the
-- top 5 highest - paid employees and export the output as a
-- csv file.Use data export technique.
select *from employees;
SELECT first_name,last_name,salary from employees
ORDER BY salary DESC LIMIT 5;
































