# This readme file gives the screenshot outputs for the written SQL codes in this repository.


## Data Defination


### Subscriptions


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/968b1d95-e660-48ae-ae9e-b648450b0603)


### Plans


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/7b13e4d7-db59-4731-a592-52e54f33300b)




## Case Study Questions


This case study is split into an initial data understanding question before diving straight into data analysis questions before finishing with 1 single extension challenge.


## A. Customer Journey

Based off the 8 sample customers provided in the sample from the subscriptions table, write a brief description about each customer’s onboarding journey.

Try to keep it as short as possible - you may also want to run some sort of join to make your explanations a bit easier!


-- selecting 8 sample customer:

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/eeaaa291-6e9b-49a0-b25c-8c0ca41a90c9)


-- CUSTOMERS WHO HAVE TRIED "TRAIL" PLAN BEFORE COMMITING TO PAID SUBSCRIPTIONS

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/2a7b90c9-919b-4373-88a6-e2ec42e211c6)


      # FROM THIS QUERY IT IS CLEARLY VISIBLE TO US THAT ALL THE CUSTOMERS
        # HAVE SUBSCRIBED FOR TRIAL VERSION BEFORE DOING ANYTHING ELSE


-- CUSTOMERS WHO HAVE CHURNED

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/fa0dfd37-7fac-460e-b9a9-cfe0980bcaca)

          ** OUT OF EIGHT CUSTOMERS, 2 OF THEM HAVE ENDED UP CHURNING AFTER SOMETIME
        ## IT IS 25% OF OUR TOTAL SAMPLE CUSTOMERS


-- TOTAL SPENDING OF EACH CUSTOMERS


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/5a17fd53-2b56-4ca5-bca8-ccaca2f04702)


* FROM THIS TABLE IT IS CLEARLY VISIBLE THAT PEOPLE SPENDITURE RANGES
        # FROM 9.90 TO 199.00


-- AVERAGE SPENDING OF OUR EIGHT CUSTOMERS:


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/35c95b7f-bd29-4e79-ae5f-440c67113200)

    #	FROM THIS QUERY, WE FIND OUT THAT THE AVERAGE SPENDING OF CUSTOMER IS 38.51 


-- MOST COMMONLY USED PLAN 

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/871940c8-9c3a-4718-ab91-f7c81c5fa762)

* FROM THIS QUERY IT IS VISIBLE THAT TRIAL IS THE MOST USED PACKAGE
		## WIITH BASIC MONTHLY BEING A CLOSE SECOND


  
## B. Data Analysis Questions


How many customers has Foodie-Fi ever had?

What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value

What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name

What is the customer count and percentage of customers who have churned rounded to 1 decimal place?

How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?

What is the number and percentage of customer plans after their initial free trial?

What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?

How many customers have upgraded to an annual plan in 2020?

How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?

Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)

How many customers downgraded from a pro monthly to a basic monthly plan in 2020?



## C. Challenge Payment Question


The Foodie-Fi team wants you to create a new payments table for the year 2020 that includes amounts paid by each customer in the subscriptions table with the following requirements:

monthly payments always occur on the same day of month as the original start_date of any monthly paid plan

upgrades from basic to monthly or pro plans are reduced by the current paid amount in that month and start immediately

upgrades from pro monthly to pro annual are paid at the end of the current billing period and also starts at the end of the month period

once a customer churns they will no longer make payments
Example outputs for this table might look like the following:



![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/087cc141-7915-46b7-a719-6f32fbfce5b2)



## D. Outside The Box Questions


The following are open ended questions which might be asked during a technical interview for this case study - there are no right or wrong answers, but answers that make sense from both a technical and a business perspective make an amazing impression!


How would you calculate the rate of growth for Foodie-Fi?

What key metrics would you recommend Foodie-Fi management to track over time to assess performance of their overall business?

What are some key customer journeys or experiences that you would analyse further to improve customer retention?

If the Foodie-Fi team were to create an exit survey shown to customers who wish to cancel their subscription, what questions would you include in the survey?

What business levers could the Foodie-Fi team use to reduce the customer churn rate? How would you validate the effectiveness of your ideas?
