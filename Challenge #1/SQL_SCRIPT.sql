CREATE DATABASE 8weeksqlchallenge;

USE 8weeksqlchallenge;


-- Case Study #1 - Danny's Diner


-- TABLE CREATION AND DATA INSERTION

CREATE TABLE sales (
  customer_id VARCHAR(1),
  order_date DATE,
  product_id INT
);

INSERT INTO sales
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 
 


CREATE TABLE menu (
  product_id INTEGER,
  product_name VARCHAR(5),
  price INTEGER
);

INSERT INTO menu
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members (
  customer_id VARCHAR(1),
  join_date DATE
);

INSERT INTO members
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');

-- Case Study Questions
-- Each of the following case study questions can be answered 
-- using a single SQL statement:


-- 1) What is the total amount each customer spent at the restaurant?

SELECT S.CUSTOMER_ID,SUM(M.PRICE) AS TOTAL_SPENT
FROM SALES AS S
INNER JOIN MENU AS M
ON S.PRODUCT_ID=M.PRODUCT_ID
GROUP BY S.CUSTOMER_ID;


-- 2) How many days has each customer visited the restaurant?

SELECT CUSTOMER_ID,COUNT(DISTINCT(ORDER_DATE)) AS NUM_OF_DAYS
FROM SALES 
GROUP BY CUSTOMER_ID;



-- 3) What was the first item from the menu purchased by each customer?

SELECT S.CUSTOMER_ID,M.PRODUCT_NAME
FROM(
	SELECT CUSTOMER_ID,MIN(ORDER_DATE) AS MIN_DATE
    FROM SALES
    GROUP BY CUSTOMER_ID
) AS MIN_TABLE
JOIN SALES AS S
ON MIN_TABLE.CUSTOMER_ID=S.CUSTOMER_ID AND MIN_TABLE.MIN_DATE=S.ORDER_DATE
JOIN MENU AS M
ON M.PRODUCT_ID=S.PRODUCT_ID;

-- 4) What is the most purchased item on the menu and
--  how many times was it purchased by all customers?

SELECT M.PRODUCT_NAME, COUNT(*) AS NUM_OF_TIMES_PURCHASED
FROM SALES AS S
INNER JOIN MENU AS M
ON S.PRODUCT_ID=M.PRODUCT_ID
GROUP BY M.PRODUCT_NAME
ORDER BY COUNT(*) DESC
LIMIT 1;


-- 5) Which item was the most popular for each customer?

SELECT T4.CUSTOMER_ID,M.PRODUCT_NAME
FROM
(SELECT T2.CUSTOMER_ID,T3.PRODUCT_ID
FROM
(
SELECT T.CUSTOMER_ID,MAX(COUNT1) AS MAX_COUNT
FROM
(SELECT CUSTOMER_ID,PRODUCT_ID,COUNT(*) AS COUNT1
FROM SALES 
GROUP BY CUSTOMER_ID,PRODUCT_ID) AS T
GROUP BY T.CUSTOMER_ID
) AS T2
JOIN 
(
SELECT CUSTOMER_ID,PRODUCT_ID,COUNT(*) AS COUNT2
FROM SALES 
GROUP BY CUSTOMER_ID,PRODUCT_ID
)AS T3
ON T2.CUSTOMER_ID=T3.CUSTOMER_ID AND T2.MAX_COUNT=T3.COUNT2) AS T4
INNER JOIN MENU AS M
ON T4.PRODUCT_ID=M.PRODUCT_ID
ORDER BY T4.CUSTOMER_ID;


-- 6 Which item was purchased first by the customer after they became a member?


SELECT S.CUSTOMER_ID,M.PRODUCT_NAME
FROM(
SELECT T.CUSTOMER_ID,MIN(T.ORDER_DATE) AS MIN_DATE
FROM(
SELECT S.CUSTOMER_ID,S.ORDER_DATE,S.PRODUCT_ID
FROM SALES AS S
JOIN MEMBERS AS MEM
ON S.CUSTOMER_ID=MEM.CUSTOMER_ID
WHERE S.ORDER_DATE>=MEM.JOIN_DATE
) AS T
GROUP BY T.CUSTOMER_ID) AS FIN
JOIN SALES AS S
ON S.CUSTOMER_ID=FIN.CUSTOMER_ID AND S.ORDER_DATE=FIN.MIN_DATE
JOIN MENU AS M
ON S.PRODUCT_ID=M.PRODUCT_ID;



-- 7. Which item was purchased just before the customer became a member?
SELECT T.CUSTOMER_ID,M.PRODUCT_NAME
FROM(

SELECT T.CUSTOMER_ID,T.PRODUCT_ID
FROM(
SELECT S.CUSTOMER_ID,S.ORDER_DATE,S.PRODUCT_ID
FROM SALES AS S
INNER JOIN MEMBERS AS MEM
ON S.CUSTOMER_ID=MEM.CUSTOMER_ID
WHERE S.ORDER_DATE<MEM.JOIN_DATE) AS T
INNER JOIN(
	SELECT CUSTOMER_ID,MAX(ORDER_DATE) AS MAX_DATE
    FROM (SELECT S.CUSTOMER_ID,S.ORDER_DATE,S.PRODUCT_ID
FROM SALES AS S
INNER JOIN MEMBERS AS MEM
ON S.CUSTOMER_ID=MEM.CUSTOMER_ID
WHERE S.ORDER_DATE<MEM.JOIN_DATE) AS T
    GROUP BY CUSTOMER_ID
) AS T2
ON T.CUSTOMER_ID=T2.CUSTOMER_ID AND T.ORDER_DATE=T2.MAX_DATE) AS T
INNER JOIN MENU AS M
ON M.PRODUCT_ID=T.PRODUCT_ID;


-- 8. What is the total items and amount spent
--  for each member before they became a member?

SELECT S.CUSTOMER_ID,COUNT(*) AS TOTAL_ITEM,SUM(M.PRICE) AS AMT_SPENT
FROM SALES AS S
INNER JOIN MENU AS M
ON S.PRODUCT_ID=M.PRODUCT_ID
GROUP BY S.CUSTOMER_ID;


-- 9) If each $1 spent equates to 10 points and sushi has a 2x points multiplier 
-- how many points would each customer have?


SELECT T.CUSTOMER_ID,SUM(T.POINTS)
FROM (
SELECT S.CUSTOMER_ID,S.PRODUCT_ID,M.PRODUCT_NAME,
CASE
	WHEN S.PRODUCT_ID=1 THEN M.PRICE*2*10
    ELSE M.PRICE*10
END AS POINTS
FROM SALES AS S
INNER JOIN MENU AS M
ON S.PRODUCT_ID=M.PRODUCT_ID
) AS T
GROUP BY CUSTOMER_ID;


-- 10 In the first week after a customer joins the program 
-- (including their join date) they earn 2x points on all items,
-- not just sushi - how many points do 
-- customer A and B have at the end of January?

SELECT WEEK.CUSTOMER_ID,SUM(WEEK.POINTS+MONTH.POINTS) AS TOTAL_POINTS
FROM (

SELECT S.CUSTOMER_ID,(2*M.PRICE*10) AS POINTS
FROM SALES AS S
INNER JOIN MENU AS M
ON S.PRODUCT_ID=M.PRODUCT_ID
INNER JOIN MEMBERS AS MEM
ON S.CUSTOMER_ID=MEM.CUSTOMER_ID
WHERE DAY(S.ORDER_DATE) BETWEEN DAY(MEM.JOIN_DATE) AND DAY(MEM.JOIN_DATE)+7) AS WEEK,

(
SELECT S.CUSTOMER_ID,
CASE
	WHEN S.PRODUCT_ID=1 THEN M.PRICE*2*10
    ELSE M.PRICE*10
END AS POINTS
FROM SALES AS S
INNER JOIN MENU AS M
ON S.PRODUCT_ID=M.PRODUCT_ID
INNER JOIN MEMBERS AS MEM
ON S.CUSTOMER_ID=MEM.CUSTOMER_ID
WHERE DAY(S.ORDER_DATE) BETWEEN DAY(MEM.JOIN_DATE)+7 AND '2021-02-02') AS MONTH
GROUP BY S.CUSTOMER_ID;


-- BONUS QUESTIONS

-- Join All The Things
-- The following questions are related creating basic
-- data tables that Danny and his team can use to quickly
--  derive insights without needing to join the underlying tables using SQL.

-- Recreate the following table output using the available data:


-- TABLE IS GIVEN


-- QUERY
SELECT S.CUSTOMER_ID AS customer_id,S.ORDER_DATE as order_date,
M.PRODUCT_NAME AS product_name, M.PRICE as price,
CASE
WHEN S.ORDER_DATE<MEM.JOIN_DATE OR MEM.JOIN_DATE IS NULL THEN 'N'
ELSE 'Y'

END AS member
FROM SALES AS S
INNER JOIN MENU AS M
ON S.PRODUCT_ID=M.PRODUCT_ID
LEFT JOIN MEMBERS AS MEM
ON MEM.CUSTOMER_ID=S.CUSTOMER_ID
ORDER BY S.CUSTOMER_ID,S.ORDER_DATE;


-- Rank All The Things

-- Danny also requires further information about the 
-- ranking of customer products, but he purposely does 
-- not need the ranking for non-member purchases so he expects
-- null ranking values for the records when customers 
-- are not yet part of the loyalty program.


-- TABLE TO GENERATE IS GIVEN

SELECT 
    S.customer_id,
    S.order_date,
    M.product_name,
    M.price,
    CASE
        WHEN S.order_date < MEM.join_date OR MEM.join_date IS NULL THEN 'N'
        ELSE 'Y'
    END AS member,
    CASE
        WHEN S.order_date < MEM.join_date OR MEM.join_date IS NULL THEN NULL
        ELSE ROW_NUMBER() OVER (PARTITION BY S.customer_id ORDER BY S.order_date)
    END AS ranking
FROM 
    sales AS S
INNER JOIN 
    menu AS M ON S.product_id = M.product_id
LEFT JOIN 
    members AS MEM ON S.customer_id = MEM.customer_id
ORDER BY 
    S.customer_id, S.order_date;
