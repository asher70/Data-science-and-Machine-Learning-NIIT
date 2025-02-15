-- course 2  sprint 4

USE employee;
-- TASK 1
-- Q) LIST THE ID'S ,first names,and last names of the employees  working in the IT department.
      -- Note :Use the employees and department tables.
      select *from employees;-- displayed the table to understand what to do
      select *from departments;
      desc employees;-- understanding datatype
	  select e.employee_id,e.first_name,e.last_name,d.department_name
      from departments as d inner join employees  as e on d.department_id=60;
      -- applying inner join to calculate IT department whose department_id=60 we joined employees
      -- and department tables and selected details to be displayed
-- TASK 2
-- Q) EXTRACT THE MINIMUM AND MAXIMUM SALARIES FOR EACH DEPARTMENT
   -- NOTE: USE THE EMPLOYEES AND DEPARTMENTS TABLES.
   select * from EMPLOYEES;
   select *from departments;
   select d.department_name,max(e.salary),min(e.salary) from departments as d inner join EMPLOYEES
   as e on d.department_id=e.department_id  group by d.department_name;
   -- we would have used left join but there are null in other
   -- department so decided to see only dep that have salary so used inner
   
-- TASK 3
-- Q)IDENTIFY THE TOP 10 CITIES THAT HAVE THE HIGHEST NUMBER OF EMPLOYEES.
   -- NOTE:USE THE EMPLOYEES,DEPARTMENTS,AND LOCATIONS TABLE.
   select * from EMPLOYEES;
   select *from departments;
   select * from locations;
   desc EMPLOYEES;-- pk:employee_id
   desc departments;-- pk: department_id
   desc locations;-- pk:location_id
   -- first joinning location_id from departments and locations
   select l.city,count(e.employee_id) as 'no of employees' from locations as l 
   inner join departments as d
   on l.location_id=d.location_id inner join EMPLOYEES as e 
   on e.department_id=d.department_id 
   group by(l.city) 
   order by(count('no of employees' )) desc limit 10 ;
   -- had to apply join twice  connected three tables first two making join 
   -- then joining that to third table and summarized by
   -- city and counted no of employees by applying count on employee_id
   
-- TASK 4
 -- Q) LIST THE EMPLOYEE ID'S,FIRST NAMES,AND LAST NAMES OF ALL THOSE 
 -- EMPLOYEES WHOSE LAST WORKING DAY IN THE ORGANIZATION WAS 1999-12-31.
   -- NOTE:LAST WORKING DAY IS THE END DATE FIELD.USE THE EMPLOYEES AND JOB_HISTORY TABLES.
  select * from EMPLOYEES;
 select * from job_history;
 desc EMPLOYEES;-- pk:employee_id
 desc job_history;-- pk:employee id
 select e.employee_id,e.first_name,e. last_name,j.end_date from EMPLOYEES 
 as e inner  join job_history as j on e.employee_id=j.employee_id where j.end_date='1999-12-31';
 
 -- joined two tables tables and applied where to that particular date

 -- TASK 5
 -- Q) EXTRACT THE EMPLOYEE IDS ,FIRST NAMES,DEPARTMENT NAMES,AND TOTAL EXPERIENCE OF ALL THOSE 
 -- EMPLOYEES WHO HAVE COMPLETED AT LEAST 25 YEARS IN THE ORGANIZATION.
    -- NOTE: Total experience= current date-hiring date
     -- use the employees and departments tables.
select* from departments;
select *from employees;
desc departments;-- department_id
desc employees; -- employee_id
alter table employees add column Total_experience int;-- added a new column with int data type
-- alter table employees drop column Total_experience;
update employees set Total_experience=year(curdate())-year(hire_date) ;-- calculated the column total_experience by using curdate -the column hire_data
set sql_safe_updates=0;-- it showed error so had to switch it off
 select e.employee_id,e.first_name,d.department_name ,e.Total_experience
 from departments as d inner join employees as e on
 d.department_id=e.department_id  where e.Total_experience>= 25 ;