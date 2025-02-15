-- SPRINT 3 :PRACTISE (ASSIGNMENT)

USE SAKILA;
-- TASK 1:EXTRACT THE DATA OF CUSTOMERS WHO ARE INACTIVE.NOTE :ACTIVE=0 IN THE CUSTOMER TABLE INDICATES INACTIVE CUSTOMERS.
SELECT *FROM customer WHERE ACTIVE=0 ;-- WE HAVE SELECTED ALL COLUMNS FROM CUSTOMER TABLE WHERE ACTIVE=0 INDICATING INACTIVE CUSTOMERS.

-- TASK 2:IDENTIFY THE FIRST NAME,LAST NAME,AND EMAILS OF INACTIVE CUSTOMERS NOTE:USE THE CUSTOMER TABLE
SELECT first_name,last_name,email,ACTIVE FROM customer WHERE ACTIVE=0;-- WE HAVE SELECTED THE FOLLOWING COLUMNS FIRST NAME,LAST NAME,AND EMAILS ,ACTIVE FROM customer TABLE WHERE ACTIVE=0.INDICATING INACTIVE CUSTOMERS.

-- TASK 3: IDENTIFY THE STORE_ID HAVING THE HIGHEST NUMBER OF INACTIVE CUSTOMERS. NOTE: USE THE CUSTOMER DATA
SELECT (store_id),ACTIVE,count(store_id) as "number of inactive customers" FROM customer WHERE ACTIVE =0 group by(store_id);
-- intepretation: as seen store_id 1 has THE HIGHEST NUMBER OF INACTIVE CUSTOMERS 8.followed by store_id  2 who have 7 INACTIVE CUSTOMERS.


-- TASK 4:IDENTIFY THE NAMES OF MOVIES THAT ARE RATED AS PG-13. NOTE : USE THE FILM TABLE.
select title,rating as "Name of movie " from film where rating="PG-13";
-- we have identified names of movie whose rating is pg-13. 


-- TASK 5:IDENTIFY THE TOP THREE MOVIES WITH PG-13 RATING THAT HAVE THE LONGEST RUNNING TIME. NOTE:USE THE FILIM TABLE.
select title as "MOVIE NAME",rating,length from film where rating="pg-13" order by (length) desc limit 3;
-- WE HAV IDENTIFIED   TOP THREE MOVIES WITH PG-13 RATING THAT HAVE THE LONGEST RUNNING TIME.GANGS PRIDE,CHICAGO NORTH,POND SEATTLE  HAVE 185 MINUTES DURATION.



-- TASK 6:FIND THE MOST POPULAR PG-13 MOVIES BASED ON RENTAL DURATION. NOTE:USE THE FILM TABLE.     HINT:POPULAR MOVIES DO NOT HAVE A LONGER RENTAL DURATION.YOU MAY USE EITHER ONE OR TWO SEPARATE QUERIES.
select min(rental_duration) FROM FILM WHERE rating='PG-13';-- calculating least rental_duration of pg-13 from table  filis
SELECT title AS "MOVIE NAME",rating,rental_duration FROM FILM WHERE rating='PG-13'and rental_duration=3  ORDER  BY (rental_duration)  ;-- from the last we knew the ,most popular movie rental_duration=3 
-- we selected title,rating,rental_duration column of less rental duration column to find the most popular movies and we filteed the rating pg-13.


-- TASK 7:FIND THE AVERAGE RENTAL COST OF THE MOVIES. NOTE:USE THE FILM TABLE.
select avg(rental_rate) from film;
-- we have used rental_rate to calculate its average and got 2.980000.

-- TASK 8:FIND THE TOTAL REPLACEMENT COST OF ALL MOVIES. NOTE: THE DATA DEPICTS ONLY ONE COPY FOR EACH MOVIEE TITLE .USE THE FILM TABLE.
select sum(replacement_cost) as "TOTAL REPLACEMENT COST"from film;
-- the TOTAL REPLACEMENT COST for  ALL MOVIES is 19984 we applied sum operation on  replacement cost column of  the film table.

-- TASK 9:IDENTIFY THE NUMBER OF FILMS FROM THE FOLLOWING CATEGORIES:.ANIMATION.CHILDREN
-- TASK9:NOTE USE THE FILM_CATEGORY AND CATEGORY TABLES.IDENTIFY THE CATEGORY_ID FOR ANIMATION AND CATEGORY_ID FOR CHILDREN FROM THE CATEGORY TABLE.
-- THEN,EXTRACT THE COUNT OF ANIMATION CATEGORY_ID AND CHILDREN CATEGORY_ID BY USING THE FILM_CATEGORY TABLE.
select *from film_category;-- we displayed the data for clarity
select *from category;
-- category id for animation is 2 ,category id for children is 3
/* syntax:alter table school.new_students add constraint roll_no_fk
foreign key(roll_no) references school.new_table(roll_no); */
alter table sakila.film_category add constraint category_id_fk
foreign key(category_id) references sakila.category(category_id)-- we applied fk  constraint on table  film_category and connected it with category tables pk
select count(category_id)  from film_category where category_id=2;-- we found  id for animation is 2
select count(category_id)  from film_category where category_id=3;-- we found  id for  children is 3
select count(category_id)  from film_category where category_id=2 or category_id=3 ;-- total count of both categories

-- intepretation
-- there are 66 animation filims and 60 children's filims
-- there are 126 filims from animation and children


