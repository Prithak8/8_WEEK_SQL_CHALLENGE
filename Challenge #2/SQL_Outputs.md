

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/361c8067-ae17-44db-b220-e7cdf98914bb)

## Table 1: runners


The runners table shows the registration_date for each new runner

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/d312d1e8-cf36-40c7-b7a3-1c2cfdeaf25d)


## Table 2: customer_orders


Customer pizza orders are captured in the customer_orders table with 1 row for each individual pizza that is part of the order.

The pizza_id relates to the type of pizza which was ordered whilst the exclusions are the ingredient_id values which should be removed from the pizza and the extras are the ingredient_id values which need to be added to the pizza.

Note that customers can order multiple pizzas in a single order with varying exclusions and extras values even if the pizza is the same type!

The exclusions and extras columns will need to be cleaned up before using them in your queries.


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/0c239d03-9a37-465a-b1a1-868036b3a43e)

## Table 3: runner_orders


After each orders are received through the system - they are assigned to a runner - however not all orders are fully completed and can be cancelled by the restaurant or the customer.

The pickup_time is the timestamp at which the runner arrives at the Pizza Runner headquarters to pick up the freshly cooked pizzas. The distance and duration fields are related to how far and long the runner had to travel to deliver the order to the respective customer.

There are some known data issues with this table so be careful when using this in your queries - make sure to check the data types for each column in the schema SQL!

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/ad8f1281-8bc7-4f1b-ac23-0e8e5687e92b)


## Table 4: pizza_names


At the moment - Pizza Runner only has 2 pizzas available the Meat Lovers or Vegetarian!


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/58bbc637-0afc-461b-a372-e8a9eba8b336)


## Table 5: pizza_recipes

Each pizza_id has a standard set of toppings which are used as part of the pizza recipe.

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/16e230ed-5b8b-4179-92c8-acf45725d6a4)


## Table 6: pizza_toppings

This table contains all of the topping_name values with their corresponding topping_id value

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/7959f647-ed90-43a8-92d5-88dd356b560b)


# Case Study Questions

This case study has LOTS of questions - they are broken up by area of focus including:

Pizza Metrics

- Runner and Customer Experience
  
- Ingredient Optimisation

- Pricing and Ratings
  
- Bonus DML Challenges (DML = Data Manipulation Language)
  
- Each of the following case study questions can be answered using a single SQL statement.
  


## A. Pizza Metrics

How many pizzas were ordered?

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/1d07e3c6-cc6c-42cd-be62-fb558b816921)


How many unique customer orders were made?

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/d8f94abe-d015-47cf-af78-260479381d41)


How many successful orders were delivered by each runner?

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/a3d98539-1c4b-4958-afaa-a921963c26a5)


How many of each type of pizza was delivered?

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/e21eaaee-cea5-43fe-af58-f97bf6a7244d)


How many Vegetarian and Meatlovers were ordered by each customer?

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/0d48fe72-aca8-49ca-8a0c-9cb081efc6db)


What was the maximum number of pizzas delivered in a single order?

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/b55e1bfa-2bdb-4c3e-98dd-acb3cb55f520)


For each customer, how many delivered pizzas had at least 1 change and how many had no changes?


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/5ba96edb-10ee-441f-aa74-0967fc39fa9f)



How many pizzas were delivered that had both exclusions and extras?


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/4efc0fd4-0907-4bd3-a742-00da9a2c7e34)


What was the total volume of pizzas ordered for each hour of the day?


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/86479cde-9498-4e29-b2d6-ed302fdc4968)


What was the volume of orders for each day of the week?


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/7691cd36-95e8-4a95-b0c1-acdb84cd94d4)


## B. Runner and Customer Experience

How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/24d05707-0805-4ce2-a155-266729ecc644)


What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/6a7e86ba-17c3-4731-8d67-bccce1efdc68)


Is there any relationship between the number of pizzas and how long the order takes to prepare?


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/476e9fea-6ef2-4ca1-ad35-1b2ce3d5ed94)


What was the average distance travelled for each customer?



![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/b571885d-c2e0-4824-9814-fe7e573a96ca)


What was the difference between the longest and shortest delivery times for all orders?


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/84154f67-97a4-40be-adc7-550b79715fb6)



What was the average speed for each runner for each delivery and do you notice any trend for these values?


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/a16d713a-1610-47cc-b3a8-e29977a32060)


What is the successful delivery percentage for each runner?


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/b8bf5db8-40d6-486b-ad42-95ca6d58dbfc)




## C. Ingredient Optimisation

What are the standard ingredients for each pizza?



![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/bfef8ec7-91fa-4073-8a62-1d522bd8e43c)


What was the most commonly added extra?



![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/b5c79962-a050-4f95-b4f9-cb406c7462a5)



What was the most common exclusion?


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/4831b5b7-c9c7-4bb6-a73c-9c1b2f955899)


Generate an order item for each record in the customers_orders table in the format of one of the following:

Meat Lovers


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/dc521e9c-92cf-4125-8a43-dfd5a0f19717)


Meat Lovers - Exclude Beef


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/ff6e22de-2a8e-47d3-978b-64bd8e79dc3e)


Meat Lovers - Extra Bacon


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/dfcd1ded-c698-4b54-93c7-148e59e9fff6)


Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/23eef2f7-94f2-4650-9429-43a79b16cbd1)



What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/9dba4833-30b0-4343-9b16-dcfd23871ae2)


## D. Pricing and Ratings

If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/b9231cae-7639-4582-af12-3eb6570fdb62)


What if there was an additional $1 charge for any pizza extras?


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/fe9daeb1-b585-4183-afe8-55aa37ad2eab)


Add cheese is $1 extra


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/f6b03437-4f87-4f75-9e8d-a190455237b1)


The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an additional table for this new dataset - generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.



![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/96c7a6e3-fa6e-4f86-ad25-af65b4c652bb)


Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?

customer_id

order_id

runner_id

rating

order_time

pickup_time

Time between order and pickup

Delivery duration
Average speed

Total number of pizzas


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/f67ed42c-53fb-4258-9107-2765fe2f2940)
![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/3e7f1c16-92d8-43fb-a753-d1ff55c5f3c9)


If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have left over after these deliveries?


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/8101e29d-1503-4971-baa0-4068cf3c8dd5)


## E. Bonus Questions

If Danny wants to expand his range of pizzas - how would this impact the existing data design? Write an INSERT statement to demonstrate what would happen 

if a new Supreme pizza with all the toppings was added to the Pizza Runner menu?


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/dc42f066-0092-4d8f-acd4-0e388815cc97)


![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/16205a3a-7ad7-4cfe-90a3-e93cddc085b4)



# Thank You
