# Case Study 1 - Danny's Diner

## Introduction
Danny seriously loves Japanese food so in the beginning of 2021, he decides to embark upon a risky venture and opens up a cute little restaurant that sells his 3 favourite foods: sushi, curry and ramen.
Danny’s Diner is in need of your assistance to help the restaurant stay afloat - the restaurant has captured some very basic data from their few months of operation but have no idea how to use their data to help them run the business.

## Problem Statement

Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him deliver a better and more personalised experience for his loyal customers.
He plans on using these insights to help him decide whether he should expand the existing customer loyalty program - additionally he needs help to generate some basic datasets so his team can easily inspect the data without needing to use SQL.
Danny has provided you with a sample of his overall customer data due to privacy issues - but he hopes that these examples are enough for you to write fully functioning SQL queries to help him answer his questions!


Danny has shared with you 3 key datasets for this case study:
sales
menu
members

You can inspect the entity relationship diagram and example data below.

## Entity Relationship Diagram

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/9bc40c12-5a39-4816-9002-99e86b0908fc)


## Example Datasets
All datasets exist within the dannys_diner database schema - be sure to include this reference within your SQL scripts as you start exploring the data and answering the case study questions.

## Table 1: sales
The sales table captures all customer_id level purchases with an corresponding order_date and product_id information for when and what menu items were ordered.

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/a760b42c-9c91-4031-a257-fe86b1bac21f)

## Table 2: menu
The menu table maps the product_id to the actual product_name and price of each menu item.

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/91dbedb9-c189-4b37-8914-cd5bbf5db04b)

## Table 3: members
The final members table captures the join_date when a customer_id joined the beta version of the Danny’s Diner loyalty program.

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/fcabf68c-d601-4cd6-b119-faff06988f38)

## Case Study Questions   (Outputs)

Each of the following case study questions can be answered using a single SQL statement:

1) What is the total amount each customer spent at the restaurant?

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/4654bc1b-c9cc-4e70-9cd0-3f46f86b5d34)

2) How many days has each customer visited the restaurant?

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/3ab64aa1-ccf4-4e58-9710-201540ae467b)

3) What was the first item from the menu purchased by each customer?

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/700e6de2-699b-466a-94eb-31d6ddacc320)

4) What is the most purchased item on the menu and how many times was it purchased by all customers?

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/24e3a753-7fc1-4ece-bb1d-7eb5364c4e28)

5) Which item was the most popular for each customer?

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/4b3dad0f-3030-4e24-97c1-8c5a7e077ac2)

6) Which item was purchased first by the customer after they became a member?

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/4b08bc21-08f3-4454-b940-dc2532847d9d)

7) Which item was purchased just before the customer became a member?

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/2916f5b5-eb4f-4e76-8ee0-b6416be04be3)

8) What is the total items and amount spent for each member before they became a member?

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/98348564-399c-4bbd-95bf-a16f77d2c10f)

9) If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/ec0116fc-b2fb-47d9-ac54-c37c3ae347d5)

10) In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/484c6c87-b510-4e7e-acc4-668ac21c2e18)


# Bonus Questions
Join All The Things
The following questions are related creating basic data tables that Danny and his team can use to quickly derive insights without needing to join the underlying tables using SQL.

## Recreate the following table output using the available data:

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/fab7a38f-22fe-4750-a303-ebe778fbe270)

My Output:

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/7c609ab1-3c90-4308-8671-d4d897778b68)

## Rank All The Things
Danny also requires further information about the ranking of customer products, but he purposely does not need the ranking for non-member purchases so he expects null ranking values for the records when customers are not yet part of the loyalty program.

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/c1f69655-31c6-4127-a963-81f9ae656eff)

My Output:

![image](https://github.com/Prithak8/8_WEEK_SQL_CHALLENGE/assets/109690999/71fddcf1-4813-4823-8011-40105d007dc1)
