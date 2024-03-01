
CREATE DATABASE IF NOT EXISTS pizza_runner;

USE pizza_runner;

--  CREATION OF REQUIRED TABLES AND EXPORTING THE DATASETS

CREATE TABLE runners (
  runner_id INTEGER,
  registration_date DATE
);

INSERT INTO runners
VALUES
  (1, '2021-01-01'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');



CREATE TABLE customer_orders (
  order_id INTEGER,
  customer_id INTEGER,
  pizza_id INTEGER,
  exclusions VARCHAR(10),
  extras VARCHAR(10),
  order_time TIMESTAMP
);

INSERT INTO customer_orders
VALUES
  ('1', '101', '1', '', '', '2020-01-01 18:05:02'),
  ('2', '101', '1', '', '', '2020-01-01 19:00:52'),
  ('3', '102', '1', '', '', '2020-01-02 23:51:23'),
  ('3', '102', '2', '', NULL, '2020-01-02 23:51:23'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '2', '4', '', '2020-01-04 13:23:46'),
  ('5', '104', '1', 'null', '1', '2020-01-08 21:00:29'),
  ('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13'),
  ('7', '105', '2', 'null', '1', '2020-01-08 21:20:29'),
  ('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33'),
  ('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59'),
  ('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49'),
  ('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');



CREATE TABLE runner_orders (
  order_id INTEGER,
  runner_id INTEGER,
  pickup_time VARCHAR(20),
  distance VARCHAR(10),
  duration VARCHAR(20),
  cancellation VARCHAR(30)
);

INSERT INTO runner_orders
VALUES
  ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');



CREATE TABLE pizza_names (
  pizza_id INTEGER,
  pizza_name TEXT
);

INSERT INTO pizza_names
VALUES
  (1, 'Meatlovers'),
  (2, 'Vegetarian');



CREATE TABLE pizza_recipes (
  pizza_id INTEGER,
  toppings TEXT
);


INSERT INTO pizza_recipes
VALUES
  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
  (2, '4, 6, 7, 9, 11, 12');



CREATE TABLE pizza_toppings (
  topping_id INTEGER,
  topping_name TEXT
);

INSERT INTO pizza_toppings
VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');
  

-- Data cleaning of null values

-- for customer_orders

# conversion of null string values of exclusions and extras to NaN

update customer_orders
set exclusions=null
where exclusions='null' or exclusions='';


update customer_orders
set extras=null
where extras='null' or extras='';


-- for runner_orders table

update runner_orders
set pickup_time=null
where  pickup_time='null' or  pickup_time='';

update runner_orders
set distance=null
where  distance='null' or  distance='';

update runner_orders
set duration=null
where  duration='null' or  duration='';

update runner_orders
set cancellation=null
where  cancellation='null' or  cancellation='';



-- updating duration column in runner_orders

select substring(duration,1,2)
from runner_orders;


update runner_orders
set duration=(
select substring(duration,1,2)
);

-- updating distance column in runner_orders

SELECT REGEXP_REPLACE(distance, '[^0-9.]+', '') 
FROM runner_orders;

update runner_orders
set distance=(
REGEXP_REPLACE(distance, '[^0-9.]+', '') 
);








-- A. Pizza Metrics


-- How many pizzas were ordered?

select count(order_id) as num_of_pizzas_ordered
from customer_orders;

-- How many unique customer orders were made?

select count(distinct(customer_id)) as num_of_unique_customer_orders
from customer_orders;

-- How many successful orders were delivered by each runner?

select runner_id,count(*) as sucessfull_orders_delivered
from runner_orders
where cancellation is null
group by runner_id;


-- How many of each type of pizza was delivered?


select p.pizza_name,count(*) as number_sold
from(
select c.pizza_id
from customer_orders as c
inner join runner_orders as r
on c.order_id=r.order_id
where r.cancellation is null) as t
inner join pizza_names as p
on p.pizza_id=t.pizza_id
group by p.pizza_name;




-- How many Vegetarian and Meatlovers were ordered by each customer?

select c.customer_id,p.pizza_name,count(*) as number_of_ordered_pizzas
from customer_orders as c
inner join pizza_names as p
on c.pizza_id=p.pizza_id
group by c.customer_id,p.pizza_name
order by c.customer_id;

-- What was the maximum number of pizzas delivered in a single order?


select t.count as max_num_of_pizza_delivered_in_single_order
from(
select c.order_id,count(*) as count
from customer_orders as c
inner join runner_orders as r
on c.order_id=r.order_id
where r.cancellation is null
group by c.order_id
order by count(*) desc
limit 1) as t;



-- For each customer, how many delivered pizzas had at least 1 change and
-- how many had no changes?

select t1.count1 as atleast_1_change, t2.count2 as no_changes
from(
select count(*) as count1
from customer_orders as c
inner join runner_orders as r
on c.order_id=r.order_id
where r.cancellation is null and (c.extras is not null or c.exclusions is not null)) as t1
join (
select count(*) as count2
from customer_orders as c
inner join runner_orders as r
on c.order_id=r.order_id
where r.cancellation is null and c.extras is null and c.exclusions is null) as t2
on t1.count1=t2.count2;

-- How many pizzas were delivered that had both exclusions and extras?

select count(*) as pizza_delivered_w_both_es
from customer_orders as c
inner join runner_orders as r
on c.order_id=r.order_id
where r.cancellation is null and c.exclusions is not null and c.extras is not null;


-- What was the total volume of pizzas ordered for each hour of the day?

select 
case
	when hour(order_time)=10 then 10
    when hour(order_time)=11 then 11
    when hour(order_time)=12 then 12
    when hour(order_time)=13 then 13
    when hour(order_time)=14 then 14
    when hour(order_time)=15 then 15
    when hour(order_time)=16 then 16
    when hour(order_time)=17 then 17
    when hour(order_time)=18 then 18
    when hour(order_time)=19 then 19
    when hour(order_time)=20 then 20
    when hour(order_time)=21 then 21
    when hour(order_time)=22 then 22
    when hour(order_time)=23 then 23
    when hour(order_time)=24 then 24
    else 0
end as hour_of_the_day,
count(*) as num_of_pizza
from customer_orders
group by hour_of_the_day
order by hour_of_the_day;


-- What was the volume of orders for each day of the week?

select dayname(order_time) as weekday, count(*) as num_of_orders
from customer_orders
group by weekday;


-- Runner and Customer Experience


-- How many runners signed up for each 1 week period? 
-- (i.e. week starts 2021-01-01)
select 
case
	
	when  registration_date between '2021-01-01' and '2021-01-07' then "Week 1"
    when  registration_date between '2021-01-08' and '2021-01-14' then "Week 2"
    when  registration_date between '2021-01-15' and '2021-01-21' then "Week 3"    
end as week_joined,
count(*) as num_of_runners
from runners
group by week_joined;


-- What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

select runner_id,avg( TIMESTAMPDIFF(MINUTE, c.order_time, r.pickup_time)) avg_for_each_runner
from customer_orders as c
inner join runner_orders as r
on c.order_id=r.order_id
group by runner_id;


-- Is there any relationship between the number of pizzas and how long the order takes to prepare?

select t.order_id,t.num_of_pizza,t2.time
from 
(
select order_id,count(*) as num_of_pizza
from customer_orders
group by order_id) as t
join(
select c.order_id,avg(timestampdiff(minute,c.order_time,r.pickup_time)+r.duration) as time
from customer_orders as c
inner join runner_orders as r
on c.order_id=r.order_id
where r.cancellation is null
group by c.order_id) as t2
on t.order_id=t2.order_id;




-- What was the average distance travelled for each customer?

select c.customer_id,round(avg(r.distance),2) as average_distance_travelled
from customer_orders as c
inner join runner_orders as r
on c.order_id=r.order_id
group by c.customer_id;



-- What was the difference between the longest and shortest delivery times for all orders?


select max(timestampdiff(minute,c.order_time,r.pickup_time)+r.duration)-min(timestampdiff(minute,c.order_time,r.pickup_time)+r.duration) as delta
from customer_orders as c
inner join runner_orders as r
on c.order_id=r.order_id
where r.cancellation is null;


-- What was the average speed for each runner for each delivery and do you notice any trend for these values?


select r.runner_id,round(avg(r.distance/(timestampdiff(hour,c.order_time,r.pickup_time)+r.duration/60)),2) as avg_speed_km_per_hr
from customer_orders as c
inner join runner_orders as r
on c.order_id=r.order_id
group by r.runner_id;


-- What is the successful delivery percentage for each runner?





select t1.runner_id,(t1.count1/sum(t1.count1+t2.count2))*100 as percentage
from(

select runner_id,count(*) count1
from runner_orders
where cancellation is null
group by runner_id) as t1
left join
(

select runner_id,count(*) count2
from runner_orders
where cancellation is not null
group by runner_id) as t2
on t1.runner_id=t2.runner_id
group by t1.runner_id;


-- note: the percentage is 100 if the percentage column shows null



-- Normalization of tables pizza_recipes:

CREATE TABLE pizza_recipes_temp(pizza_id int, topping int);


DELIMITER $$
CREATE PROCEDURE GetToppings()
BEGIN
	DECLARE i INT DEFAULT 0;
    DECLARE j INT DEFAULT 0;
	DECLARE n INT DEFAULT 0;
    DECLARE x INT DEFAULT 0;
    DECLARE id  INT;
	DECLARE topping_in TEXT;
    DECLARE topping_out TEXT;

 	SET i = 0;
    SELECT COUNT(*) FROM pizza_recipes INTO n;

	WHILE i < n DO  -- Iterate per row
		SELECT pizza_id, toppings INTO id, topping_in FROM pizza_recipes LIMIT i,1 ; -- Select each row and store values in id, topping_in variables
		SET x = (CHAR_LENGTH(topping_in) - CHAR_LENGTH( REPLACE ( topping_in, ' ', '') ))+1; -- Find the number of toppings in the row

        SET j = 1;
		WHILE j <= x DO -- Iterate over each element in topping
			SET topping_out = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(topping_in, ',', j), ',', -1));
            -- SUBSTRING_INDEX(topping_in, ',', j -> Returns a substring from a string before j occurences of comma
            -- (SUBSTRING_INDEX(SUBSTRING_INDEX(topping_in, ',', j), ',', -1)) -> Returns the last topping from the substring found above, element at -1 index
			INSERT INTO pizza_recipes_temp VALUES(id, topping_out);  -- Insert pizza_id and the topping into table pizza_info
			SET j = j + 1; -- Increment the counter to find the next pizza topping in the row
        END WHILE;
        SET i = i + 1;-- Increment the counter to fetch the next row
	END WHILE;
END$$
DELIMITER ;

CALL GetToppings();





-- normalizaing customer_orders


create table customer_orders_temp(
order_id int,
customer_id int,
pizza_id int,
exclusions varchar(50),
extras varchar(50),
order_time datetime
);


insert into customer_orders_temp
select * from customer_orders;


-- now the result given by the following query was imported to mysql 
SELECT 
    t.order_id,
    t.customer_id,
    t.pizza_id,
    TRIM(j1.exclusions) AS exclusions,
    TRIM(j2.extras) AS extras,
    t.order_time
FROM 
    customer_orders_temp t
INNER JOIN 
    json_table(TRIM(REPLACE(json_array(t.exclusions), ',', '","')), '$[*]' COLUMNS (exclusions VARCHAR(50) PATH '$')) j1
INNER JOIN 
    json_table(TRIM(REPLACE(json_array(t.extras), ',', '","')), '$[*]' COLUMNS (extras VARCHAR(50) PATH '$')) j2;



-- C) Ingredient Optimisation


-- What are the standard ingredients for each pizza?


SELECT
CASE
	WHEN T.PIZZA_ID=1 THEN "Meatlovers"
    ELSE "Vegetarian"
END Pizza_Name,
group_concat(T.TOPPING_NAME," ") AS Standard_Ingrediants
FROM
(SELECT PRT.PIZZA_ID,PT.TOPPING_NAME
FROM PIZZA_TOPPINGS AS PT
JOIN PIZZA_RECIPES_TEMP AS PRT
ON PT.TOPPING_ID=PRT.TOPPING) AS T
GROUP BY Pizza_Name;

-- What was the most commonly added extra?


SELECT PT.TOPPING_NAME AS EXTRAS_USED,T.EXTRAS_COUNT
FROM
(
SELECT EXTRAS,COUNT(EXTRAS) AS EXTRAS_COUNT
FROM CUSTOMER_ORDERS_TEMP
WHERE EXTRAS IS NOT NULL
GROUP BY EXTRAS
ORDER BY EXTRAS_COUNT DESC) AS T
JOIN PIZZA_TOPPINGS AS PT
ON PT.TOPPING_ID=T.EXTRAS;


-- What was the most common exclusion?

SELECT PT.TOPPING_NAME AS EXCLUSIONS_USED,T.EXCLUSIONS_COUNT
FROM
(
SELECT EXCLUSIONS,COUNT(EXCLUSIONS) AS EXCLUSIONS_COUNT
FROM CUSTOMER_ORDERS_TEMP
WHERE EXCLUSIONS IS NOT NULL
GROUP BY EXCLUSIONS
ORDER BY EXCLUSIONS_COUNT DESC) AS T
JOIN PIZZA_TOPPINGS AS PT
ON PT.TOPPING_ID=T.EXCLUSIONS;

-- Generate an order item for each record in the customers_orders table
 -- in the format of one of the following:
 
 
-- Meat Lovers

SELECT *
FROM CUSTOMER_ORDERS
WHERE PIZZA_ID=1;

# AS WE KNOW PIZZA_ID OF MEATLOVERS IS 1


-- Meat Lovers - Exclude Beef

SELECT *
FROM CUSTOMER_ORDERS
WHERE PIZZA_ID=1 AND EXCLUSIONS=3;

-- Meat Lovers - Extra Bacon

SELECT *
FROM CUSTOMER_ORDERS_TEMP
WHERE PIZZA_ID=1 AND EXTRAS=1;

-- Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers

SELECT *
FROM CUSTOMER_ORDERS_TEMP
WHERE PIZZA_ID=1 AND EXTRAS=6 AND EXTRAS=9 AND EXCLUSIONS=1 AND EXCLUSIONS=4;



-- What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?

SELECT PT.TOPPING_NAME,COUNT(COT.EXTRAS) AS COUNT
FROM PIZZA_TOPPINGS AS PT
JOIN CUSTOMER_ORDERS_TEMP AS COT
ON PT.TOPPING_ID=COT.EXTRAS
WHERE COT.EXTRAS IS NOT NULL
GROUP BY PT.TOPPING_NAME
ORDER BY COUNT DESC;





-- D. Pricing and Ratings

-- If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there 
-- were no charges for changes - how much money has Pizza Runner made so far 
-- if there are no delivery fees?


SELECT SUM(T.TOTAL_PRICE) AS TOTAL_EARNINGS
FROM 
(SELECT
C.PIZZA_ID, 
CASE
	WHEN C.PIZZA_ID=1 THEN SUM(12)
    WHEN C.PIZZA_ID=2 THEN SUM(10)
END AS TOTAL_PRICE
FROM CUSTOMER_ORDERS AS C
JOIN RUNNER_ORDERS AS R
ON C.ORDER_ID=R.ORDER_ID
WHERE R.CANCELLATION IS NULL
GROUP BY C.PIZZA_ID) AS T;





-- What if there was an additional $1 charge for any pizza extras?

SELECT 
    SUM(CASE 
            WHEN C.PIZZA_ID = 1 AND C.EXTRAS IS NOT NULL THEN 13 
            WHEN C.PIZZA_ID = 1 THEN 12 
            WHEN C.PIZZA_ID = 2 AND C.EXTRAS IS NOT NULL THEN 11 
            WHEN C.PIZZA_ID = 2 THEN 10 
            ELSE 0 
        END) AS TOTAL_EARNINGS
FROM 
    CUSTOMER_ORDERS_TEMP AS C
JOIN 
    RUNNER_ORDERS AS R ON C.ORDER_ID = R.ORDER_ID
WHERE 
    R.CANCELLATION IS NULL;


-- Add cheese is $1 extra


SELECT 
    SUM(CASE 
            WHEN C.PIZZA_ID = 1 AND C.EXTRAS = 4 THEN 13 
            WHEN C.PIZZA_ID = 1 THEN 12 
            WHEN C.PIZZA_ID = 2 AND C.EXTRAS = 4 THEN 11 
            WHEN C.PIZZA_ID = 2 THEN 10 
            ELSE 0 
        END) AS TOTAL_EARNINGS
FROM 
    CUSTOMER_ORDERS_TEMP AS C
JOIN 
    RUNNER_ORDERS AS R ON C.ORDER_ID = R.ORDER_ID
WHERE 
    R.CANCELLATION IS NULL;


-- The Pizza Runner team now wants to add an additional ratings system
--  that allows customers to rate their runner, how would you design an
--  additional table for this new dataset - generate a schema for this 
-- new table and insert your own data for ratings for each successful
--  customer order between 1 to 5.

CREATE TABLE IF NOT EXISTS ratings(

runner_id int,
order_id int,
ratings int 
check(ratings>=1 and ratings<=5)    -- checks ratings are between 1 to 5
);


insert into ratings 
values
(1,1,4),
(1,2,3),
(1,3,2),
(1,10,5),
(2,4,3),
(2,7,3),
(2,8,4),
(3,5,1);


select * from ratings;






-- Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?

-- customer_id
-- order_id
-- runner_id
-- rating
-- order_time
-- pickup_time
-- Time between order and pickup
-- Delivery duration
-- Average speed
-- Total number of pizzas

SELECT C.CUSTOMER_ID,C.ORDER_ID,R.RUNNER_ID,RA.RATINGS,C.ORDER_TIME,
R.PICKUP_TIME,TIMESTAMPDIFF(MINUTE,C.ORDER_TIME,PICKUP_TIME) AS ORDER_PICKUP_DELTA,
R.DURATION,ROUND(R.DISTANCE/(R.DURATION/60),2) AS AVERAGE_SPEED,
SUM(C.PIZZA_ID) OVER(PARTITION BY C.ORDER_ID) AS TOTAL_PIZZA
FROM CUSTOMER_ORDERS AS C
JOIN RUNNER_ORDERS AS R
ON C.ORDER_ID=R.ORDER_ID
JOIN RATINGS AS RA
ON R.RUNNER_ID=RA.RUNNER_ID AND R.ORDER_ID=RA.ORDER_ID
WHERE R.CANCELLATION IS NULL;


-- If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices
-- with no cost for extras and each runner is paid $0.30 per
-- kilometre traveled - how much money does Pizza Runner have 
-- left over after these deliveries?





SELECT T.RUNNER_ID,ROUND(SUM(T.PIZZA_PRICE)+SUM(T.RUNNER_FEE),2) AS RUNNER_EARNINGS
FROM
(
SELECT R.RUNNER_ID,C.ORDER_ID,C.CUSTOMER_ID,C.PIZZA_ID,
CASE
WHEN C.PIZZA_ID=1 THEN 12
WHEN C.PIZZA_ID=2 THEN 10
END AS PIZZA_PRICE,
R.DISTANCE,
R.DISTANCE*0.3 AS RUNNER_FEE
FROM CUSTOMER_ORDERS AS C
JOIN RUNNER_ORDERS AS R
ON C.ORDER_ID=R.ORDER_ID
WHERE R.CANCELLATION IS NULL) AS T
GROUP BY T.RUNNER_ID;





-- E. Bonus Questions
-- If Danny wants to expand his range of pizzas - 
-- how would this impact the existing data design? 
-- Write an INSERT statement to demonstrate what would happen if 
-- a new Supreme pizza with all the toppings was added to the Pizza Runner menu?


insert into pizza_recipes
values(3,"1,2,3,4,5,6,7,8,9,10,11,12");
select * from pizza_recipes;

insert into pizza_names
values(3,"Supreme Pizza");
select * from pizza_names;
