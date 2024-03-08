USE FOODIE_FI;

# SOME DATA CLEANING
-- REPLACE NULL WITH 0.00 IN PRICE OF PLANS

UPDATE PLANS
SET PRICE=0.00
WHERE PRICE IS NULL;



-- A. Customer Journey
-- Based off the 8 sample customers provided in the sample from the 
-- subscriptions table, write a brief description about each customer’s 
-- onboarding journey.

-- Try to keep it as short as possible - you may also want to run some sort
--  of join to make your explanations a bit easier!



-- selecting 8 sample customer:

SELECT S.CUSTOMER_ID,S.PLAN_ID,P.PLAN_NAME,S.START_DATE
FROM SUBSCRIPTIONS AS S
JOIN PLANS AS P
ON S.PLAN_ID=P.PLAN_ID
WHERE CUSTOMER_ID BETWEEN 1 AND 8;


-- CUSTOMERS WHO HAVE TRIED "TRAIL" PLAN BEFORE COMMITING TO PAID SUBSCRIPTIONS

SELECT T.CUSTOMER_ID,T.PLAN_NAME
FROM
(SELECT S.CUSTOMER_ID,S.PLAN_ID,P.PLAN_NAME,S.START_DATE
FROM SUBSCRIPTIONS AS S
JOIN PLANS AS P
ON S.PLAN_ID=P.PLAN_ID
WHERE CUSTOMER_ID BETWEEN 1 AND 8) AS T
WHERE T.PLAN_NAME="TRIAL";


		# FROM THIS QUERY IT IS CLEARLY VISIBLE TO US THAT ALL THE CUSTOMERS
        # HAVE SUBSCRIBED FOR TRIAL VERSION BEFORE DOING ANYTHING ELSE
        
-- CUSTOMERS WHO HAVE CHURNED

SELECT T.CUSTOMER_ID,T.PLAN_NAME
FROM
(SELECT S.CUSTOMER_ID,S.PLAN_ID,P.PLAN_NAME,S.START_DATE
FROM SUBSCRIPTIONS AS S
JOIN PLANS AS P
ON S.PLAN_ID=P.PLAN_ID
WHERE CUSTOMER_ID BETWEEN 1 AND 8) AS T
WHERE T.PLAN_NAME="CHURN";


		## OUT OF EIGHT CUSTOMERS, 2 OF THEM HAVE ENDED UP CHURNING AFTER SOMETIME
        ## IT IS 25% OF OUR TOTAL SAMPLE CUSTOMERS
        
        
        
        
-- TOTAL SPENDING OF EACH CUSTOMERS

SELECT T.CUSTOMER_ID,T.PLAN_NAME,T.PRICE,
SUM(T.PRICE) OVER (PARTITION BY(CUSTOMER_ID)) AS TOTAL_SPENDING
FROM(
SELECT S.CUSTOMER_ID,P.PLAN_NAME,P.PRICE
FROM SUBSCRIPTIONS AS S
JOIN PLANS AS P
ON S.PLAN_ID=P.PLAN_ID
WHERE CUSTOMER_ID BETWEEN 1 AND 8
) AS T;

		# FROM THIS TABLE IT IS CLEARLY VISIBLE THAT PEOPLE SPENDITURE RANGES
        # FROM 9.90 TO 199.00
        

-- AVERAGE SPENDING OF OUR EIGHT CUSTOMERS:



SELECT AVG(T3.TOTAL_SPENDING)
FROM(
SELECT T2.CUSTOMER_ID,T2.TOTAL_SPENDING
FROM
(SELECT T.CUSTOMER_ID,
SUM(T.PRICE) OVER (PARTITION BY(CUSTOMER_ID)) AS TOTAL_SPENDING
FROM(
SELECT S.CUSTOMER_ID,P.PLAN_NAME,P.PRICE
FROM SUBSCRIPTIONS AS S
JOIN PLANS AS P
ON S.PLAN_ID=P.PLAN_ID
WHERE CUSTOMER_ID BETWEEN 1 AND 8
) AS T) AS T2
GROUP BY T2.CUSTOMER_ID,T2.TOTAL_SPENDING) AS T3;

		#	FROM THIS QUERY, WE FIND OUT THAT THE AVERAGE SPENDING OF CUSTOMER IS 38.51 


-- MOST COMMONLY USED PLAN 
        
SELECT T.PLAN_NAME,COUNT(*) AS COUNT
FROM
(
SELECT S.CUSTOMER_ID,P.PLAN_NAME
FROM SUBSCRIPTIONS AS S
JOIN PLANS AS P
ON S.PLAN_ID=P.PLAN_ID
WHERE CUSTOMER_ID BETWEEN 1 AND 8
) AS T
GROUP BY T.PLAN_NAME
ORDER BY COUNT DESC;

		## FROM THIS QUERY IT IS VISIBLE THAT TRIAL IS THE MOST USED PACKAGE
		## WIITH BASIC MONTHLY BEING A CLOSE SECOND
        
        

-- B. Data Analysis Questions

-- How many customers has Foodie-Fi ever had?

SELECT COUNT(DISTINCT(CUSTOMER_ID)) AS CUSTOMER_COUNT
FROM SUBSCRIPTIONS;

-- What is the monthly distribution of trial plan start_date values 
-- for our dataset - use the start of the month as the group by value

SELECT
CASE
WHEN MONTHNAME(START_DATE)="JANUARY" THEN "JANUARY"
WHEN MONTHNAME(START_DATE)="FEBRUARY" THEN "FEBRUARY"
WHEN MONTHNAME(START_DATE)="MARCH" THEN "MARCH"
WHEN MONTHNAME(START_DATE)="APRIL" THEN "APRIL"
WHEN MONTHNAME(START_DATE)="MAY" THEN "MAY"
WHEN MONTHNAME(START_DATE)="JUNE" THEN "JUNE"
WHEN MONTHNAME(START_DATE)="JULY" THEN "JULY"
WHEN MONTHNAME(START_DATE)="AUGUST" THEN "AUGUST"
WHEN MONTHNAME(START_DATE)="SEPTEMBER" THEN "SEPTEMBER"
WHEN MONTHNAME(START_DATE)="OCTOBER" THEN "OCTOBER"
WHEN MONTHNAME(START_DATE)="NOVEMBER" THEN "NOVEMBER"
WHEN MONTHNAME(START_DATE)="DECEMBER" THEN "DECEMBER"
END MONTH,
COUNT(*) AS COUNT
FROM subscriptionS

GROUP BY MONTH
ORDER BY MONTH;


-- What plan start_date values occur after the year 2020 for our dataset?
--  Show the breakdown by count of events for each plan_name


SELECT P.PLAN_NAME,COUNT(*) AS COUNT_AFTER_2020
FROM SUBSCRIPTIONS AS S
JOIN PLANS AS P
ON S.PLAN_ID=P.PLAN_ID
WHERE YEAR(S.START_DATE)>2020
GROUP BY P.PLAN_NAME;




-- What is the customer count and percentage of customers who have churned 
-- rounded to 1 decimal place?


SELECT 
    T.CUSTOMER_COUNT AS CHURNED_CUSTOMERS,
    (T.CUSTOMER_COUNT / (SELECT COUNT(DISTINCT customer_id) FROM subscriptions)) * 100 AS PERCENTAGE
FROM (
    SELECT 
        COUNT(*) AS CUSTOMER_COUNT
    FROM 
        subscriptions AS S
    JOIN 
        plans AS P ON S.plan_id = P.plan_id
    WHERE 
        P.plan_name = 'churn'
) AS T;





-- How many customers have churned straight after their initial free trial 
-- what percentage is this rounded to the nearest whole number?

SELECT COUNT(DISTINCT(CUSTOMER_ID)) AS churned_after_trial
FROM subscriptions
WHERE plan_id = 0
  AND customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM subscriptions
    WHERE plan_id IN(1,2,3) 
  );




# PERCENTAGE

SELECT 
    ROUND((
        SELECT COUNT(DISTINCT(CUSTOMER_ID)) AS churned_after_trial
        FROM subscriptions
        WHERE plan_id = 0
          AND customer_id NOT IN (
            SELECT DISTINCT customer_id
            FROM subscriptions
            WHERE plan_id IN (1, 2, 3) 
          )
    ) / CAST((
        SELECT COUNT(DISTINCT(CUSTOMER_ID)) AS CUSTOMER_COUNT
        FROM subscriptions
    ) AS DECIMAL), 2)*100 AS PERCENTAGE_CHURNED
FROM SUBSCRIPTIONS
LIMIT 1;





-- What is the number and percentage of customer plans after their 
-- initial free trial?


# BASIC MONTHLY

SELECT COUNT(DISTINCT(CUSTOMER_ID)) AS BASIC_MONTHLY_NUMBER
FROM subscriptions
WHERE plan_id = 0
  AND customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM subscriptions
    WHERE plan_id IN(2,3,4) 
  );


SELECT 
ROUND((
SELECT COUNT(DISTINCT(CUSTOMER_ID)) AS BASIC_MONTHLY_NUMBER
FROM subscriptions
WHERE plan_id = 0
  AND customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM subscriptions
    WHERE plan_id IN(2,3,4) 
  )
)/1000*100) AS MONTHLY_PERCENTAGE
FROM SUBSCRIPTIONS
LIMIT 1;


# PRO MONTHLY
SELECT COUNT(DISTINCT(CUSTOMER_ID)) AS PRO_MONTHLY_NUMBER
FROM subscriptions
WHERE plan_id = 0
  AND customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM subscriptions
    WHERE plan_id IN(1,3,4) 
  );

SELECT 
ROUND((
SELECT COUNT(DISTINCT(CUSTOMER_ID)) AS PRO_MONTHLY_NUMBER
FROM subscriptions
WHERE plan_id = 0
  AND customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM subscriptions
    WHERE plan_id IN(1,3,4) 
  )
)/1000*100) AS MONTHLY_PERCENTAGE
FROM SUBSCRIPTIONS
LIMIT 1;

# PRO ANNUAL

SELECT COUNT(DISTINCT(CUSTOMER_ID)) AS PRO_ANNUAL_NUMBER
FROM subscriptions
WHERE plan_id = 0
  AND customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM subscriptions
    WHERE plan_id IN(2,1,4) 
  );

SELECT 
ROUND((
SELECT COUNT(DISTINCT(CUSTOMER_ID)) AS PRO_ANNUAL_NUMBER
FROM subscriptions
WHERE plan_id = 0
  AND customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM subscriptions
    WHERE plan_id IN(2,1,4) 
  )
)/1000*100) AS ANNUAL_PERCENTAGE
FROM SUBSCRIPTIONS
LIMIT 1;



-- What is the customer count and percentage breakdown of all 5 plan_name values 
-- at 2020-12-31?


SELECT P.PLAN_NAME,COUNT(*) AS CUSTOMER_COUNT
FROM SUBSCRIPTIONS AS S
JOIN PLANS AS P
ON S.PLAN_ID=P.PLAN_ID
WHERE S.START_DATE='2020-12-31'
GROUP BY P.PLAN_NAME;



-- How many customers have upgraded to an annual plan in 2020?


SELECT COUNT(*) AS COUNT_FOR_ANNUAL_PLAN_2020
FROM SUBSCRIPTIONS AS S
JOIN PLANS AS P
ON S.PLAN_ID=P.PLAN_ID
WHERE P.PLAN_NAME="PRO ANNUAL" AND YEAR(S.START_DATE)=2020;


-- How many days on average does it take for a customer to an annual plan from 
-- the day they join Foodie-Fi?


SELECT AVG(datediff(S2.START_DATE,S1.START_DATE)) AS AVERAGE_TIME_DIFFERENCE
FROM SUBSCRIPTIONS S1
INNER JOIN SUBSCRIPTIONS S2
ON S1.CUSTOMER_ID=S2.CUSTOMER_ID
WHERE S1.PLAN_ID=0 AND S2.PLAN_ID=3;

		-- THE CONCEPT USED HERE IS SELF JOIN
        







-- How many customers downgraded from a pro monthly to a basic monthly plan in 2020?

SELECT count(DISTINCT CUSTOMER_ID)
FROM subscriptions
WHERE plan_id = 2 -- Basic Monthly Plan
  AND customer_id IN (
    SELECT customer_id
    FROM subscriptions
    WHERE plan_id = 1 -- Pro Monthly Plan
      AND YEAR(start_date) = 2020
  );



-- C. Challenge Payment Question



-- The Foodie-Fi team wants you to create a new payments table for the year 2020
-- that includes amounts paid by each customer in the subscriptions table with 
-- the following requirements:

-- monthly payments always occur on the same day of month as the original 
-- start_date of any monthly paid plan
-- upgrades from basic to monthly or pro plans are reduced by the current paid 
-- amount in that month and start immediately
-- upgrades from pro monthly to pro annual are paid at the end of the current 
-- billing period and also starts at the end of the month period
-- once a customer churns they will no longer make payments
-- Example outputs for this table might look like the following:



CREATE TABLE payments AS
SELECT s.customer_id,
       s.plan_id,
       p.plan_name,
       CASE
           WHEN s.plan_id = 0 THEN DATE_ADD(s.start_date, INTERVAL 1 MONTH)
           WHEN s.plan_id = 1 THEN DATE_ADD(DATE_FORMAT(s.start_date, '%Y-%m-01'), INTERVAL 1 MONTH)
           WHEN s.plan_id = 2 THEN DATE_ADD(DATE_FORMAT(s.start_date, '%Y-%m-01'), INTERVAL 1 MONTH)
           WHEN s.plan_id = 3 THEN LAST_DAY(DATE_ADD(s.start_date, INTERVAL 1 YEAR))
       END AS payment_date,
       CASE
           WHEN s.plan_id = 0 THEN 0
           WHEN s.plan_id = 1 THEN p.price
           WHEN s.plan_id = 2 THEN p.price
           WHEN s.plan_id = 3 THEN p.price / 12
       END AS amount,
       CASE
           WHEN s.plan_id = 0 THEN 0
           WHEN s.plan_id = 1 THEN ROW_NUMBER() OVER (PARTITION BY s.customer_id ORDER BY s.start_date)
           WHEN s.plan_id = 2 THEN ROW_NUMBER() OVER (PARTITION BY s.customer_id ORDER BY s.start_date)
           WHEN s.plan_id = 3 THEN 12
       END AS payment_order
FROM subscriptions s
JOIN plans p ON s.plan_id = p.plan_id
WHERE YEAR(s.start_date) = 2020;




-- D. Outside The Box Questions
-- The following are open ended questions which might be asked during a technical 
-- interview for this case study - there are no right or wrong answers, but answers 
-- that make sense from both a technical and a business perspective make an amazing 
-- impression!

-- How would you calculate the rate of growth for Foodie-Fi?


	## THE RATE OF GROWTH FOR FOODIE-FI CAN BE CALCULATED BY TAKING A LOOK INTO FOLLOWING
    ## HOW MANY NUMBER OF PAID CUSTOMERS ARE THERE IN THE SYSTEM TAKING TIME REFERENCE
    ## ARE THE SET TARGETS OF FOODIE-FI BEING MET?
    ## HOW IS THE COMPANY SEEMS TO BE DOING WITH REFERENCE TO ITS COMPETITORS?
    
    
    

-- What key metrics would you recommend Foodie-Fi management to track over time to 
-- assess performance of their overall business?

# NET REVENUE
# CUSTOMER RETENTION PERCENTAGE
# LOCATION OF THE CUSTOMERS TO KNOW THE LOCALE RANGE OF THE COMPANY


-- What are some key customer journeys or experiences that you would analyse further 
-- to improve customer retention?

# MOST TO LEAST POPULAR SUBSCRIPTION PACKAGES
# CUSTOMER SERVICE RATINGS
# TEXT ANALYSIS FOR CUSTOMER REVIEWS (MOST USED WORDS)

-- If the Foodie-Fi team were to create an exit survey shown to customers who wish to 
-- cancel their subscription, what questions would you include in the survey?

# WHAT IS THE REASON FOR QUITTING (OPTIONS: CUSTOMER SERVICE, PRICING, BETTER OPTIONS IN THE MARKET,ETC)



-- What business levers could the Foodie-Fi team use to reduce the customer churn rate? 
-- How would you validate the effectiveness of your ideas?


# HOLIDAY SCHEMES  
# PARTNERSHIP WITH UPIs, SIM COMPANY TO PUT ADD ONS AS 'FOODIE-FI' IN THEIR SUBSCRIPTION MODEL
		# FOR EXAMPLE AIRTEL SELLS 3 MONTH SUBSCRIPTION OF HOTSTAR IN THEIR RS 766 RECHARGE PACKAGE
# EXIT SURVEY ANALYSIS AND REFINEMENT

# WE CAN VALIDATE EACH EFFECTIVENESS OF THESE IDEAS BY MONITORING THE SUBSCRIPTION SALES DURING THESE SCHEMES


