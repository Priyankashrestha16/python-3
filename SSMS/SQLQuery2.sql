

/* 
  Group By and Having
  --------------------------------------
  Aggregate Function -> avg, min, max, sum



  1. Aggregate Columns
  2. Non- aggregate columns

*/


select * from sales.customers

-- Find total customers from each state

select
  state,city, count(customer_id) as total_customer_count    -- state being the non aggregate column and total_customer_count being aggregate columns with agggreagte function
from sales.customers
group by state, city
having count(customer_id) >2;           -- rule in SQL that when there is non aggregate column with aggregate column then it must be group by with non aggrregate column


/* 
  DIfference Between where and having

  1. Having only filters columns mentioned in Group by  whereas Where filters all columns
  2. Having filters aggregate columns but where does not filter agggregate columns

*/


-- find total orders in order status Pending, Processing, Rejected and COmpleted

select
   case
     when order_status=1 then 'Pending'
     when order_status=2 then ' Processing'
     when order_status=3 then 'Rejected'
     when order_status=4 then 'Completed'
  End as order_status_label,
  count(order_id) as total_orders

from sales.orders
group by order_status;          -- order_status being non aggregate column attached with aggregate column



-- SUM case
select
   SUM(case when order_status = 1 then 1 else 0 end) as Pending,
   SUM(case when order_status = 2 then 1 else 0 end) as Processing,
   SUM(case when order_status = 3 then 1 else 0 end) as Rejected,
   SUM(case when order_status = 4 then 1 else 0 end) as Completed

from sales.orders;


-- Count case
select
   count(case when order_status = 1 then 1  end) as Pending,
   count(case when order_status = 2 then 1 end) as Processing,
   count(case when order_status = 3 then 1 end) as Rejected,
   count(case when order_status = 4 then 1 end) as Completed

from sales.orders;



/*

2. Product Category Stock Evaluation. Write a query using the products table to group items by 
their category ID. Use a CASE expression to count how many products in each category are 
'Expensive' (price over $2,000). Filter your final results using a HAVING clause to only show 
category IDs that have more than 5 expensive products.

*/

select 
  category_id,
 count( case
    when list_price > 2000 then 'Expensive'
   end) as expensive_products
from production.products
group by category_id
having count( case
    when list_price > 2000 then 'Expensive'
   end) > 5;




   /*
3. Order Volume by Seasonal Quarters Write a query using the orders table to analyze order 
volumes based on when they were placed. Use a CASE expression to group the order_date values 
into 'First Half' (months January through June) and 'Second Half' (months July through December). 
Use a WHERE clause to only look at orders from the year 2018, and use a HAVING clause to 
only show halves that processed more than 30 orders.

*/

select 
  FORMAT(order_date,'MMMM') as month_name,
  case
     when MONTH(order_date) between 1 and 6 then 'First Half'
     when MONTH(order_date) between 7 and 12 then 'Seconf Half'
 end as month_label,
 count(order_id) as total_orders
from sales.orders
where YEAR(order_date)= 2018
group by FORMAT(order_date,'MMMM'), MONTH(order_date)
having count(order_id)> 30;

