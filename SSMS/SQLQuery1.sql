select 
   customer_id, first_name, last_name, phone,email,street,city, state, zip_code 
from sales.customers

   /*
   SQL execution FLow
   ---------------------
   1. From
   2. Join
   3. Where
   4. Group By
   5. Having
   6. Select
   7. Order By
   8. Limit (mySQL/ PgSQL) / Top (SQL Server) / Offset Fetch (SQL server/ Oracle)


 */ 

 -- Top 

select top 5
   customer_id, first_name, last_name, phone,email,street,city, state, zip_code 
from sales.customers
order by city;

-- offset -> number of rows to skip
-- fetch -> extract number of rows after skipping

-- we can do offset alone only but cannot do fetch without offset

select
   customer_id, first_name, last_name, phone,email,street,city, state, zip_code 
from sales.customers
order by city
offset 0 rows fetch next 5 rows only;


--- Where ( for filtering)
-- AND ( range/ continuous value) , OR ( categorical) , Between ( range/ continuous), IN (categorical), Like ( filters pattern)

-- Find order details of 2016 january
 select 
   * 
 from sales.orders 
 where order_date between '2016-01-01' and '2016-12-31';

 -- Find product details whose list price is in range of 200 to 800
 select * from production.products where list_price > 200 and list_price < 800;        -- exclusive

 select * from production.products where list_price between 200 and 800;               -- inclusive

 -- Find product details of brand 2 and 6
 select * from production.products where brand_id = 2 or brand_id= 6;

 select * from production.products where brand_id in(2,6);

-- Like
-- wildcards (% ( match pattern), _ (single letter))

select * from production.products

-- Find product details whose name starts with letter 'T'
select * from production.products where product_name like 'T%'

-- Find product details whose name starts with letter 'Trek P'
select * from production.products where product_name like 'Trek P%'

-- Find product details whose name ends with '2018'
select * from production.products where product_name like '%2018'

-- Find product details whose name starts with 'S' and ends with '2018'
select * from production.products where product_name like 'S%2018'

-- Find product details whose name has second later l
select * from production.products where product_name like '__l%'


-- Concat Function and Concatenation Operator (+) [in Oracle (||)]

select 
    CONCAT(first_name,' ',last_name) as full_name   -- calculated column doesnot have column name so we use 'as'
from sales.customers

select 
     (first_name + ' ' + last_name) as full_name
from sales.customers

--Find 'Debra Burks' customer details
select 
    CONCAT(first_name,' ',last_name) as full_name   -- calculated column doesnot have column name so we use 'as'
from sales.customers
where CONCAT(first_name,' ',last_name)= 'Debra Burks' 


-- difference between CONCAT() and '+'
select 
    CONCAT(first_name,' ',last_name) as full_name   -- calculated column doesnot have column name so we use 'as'
from sales.customers
order by full_name desc;


select
    CONCAT(first_name,phone) as data1,         -- CONCAT can be used for integer and string
    (first_name + phone) as data2           --  '+" operator shows NULL for concatenaation of integer and string 
from sales.customers


-- SUBSTRING   function

-- substring(column_name, start_length, number_of_letters)
select
   first_name, SUBSTRING(first_name, 2, 3) as mid_letters
from sales.customers;


--LEFT and RIGHT function
select
   first_name, left(first_name, 3) as first_3_letters
from sales.customers;


select
   first_name, right(first_name, 3) as last_3_letters
from sales.customers;


--OUTPUT ->> customer_id - first_name(3,2) - last_name(last 4) - email(5,6) -street (first 2)- city(2,3) -state-zip_code(2,3)
select 

   CONCAT(customer_id,'-',SUBSTRING(first_name,3,2),'-',right(last_name,4),'-',SUBSTRING(email,5,6),'-',left(street,2),'-',SUBSTRING(city,2,3),'-',state,SUBSTRING(zip_code,2,3)) as combined_column

from sales.customers


-- Time Series Analysis / Cohort ANalysis

-- Date Functions

select
    order_date,
    Year(order_date) as o_year,
    MONTH(order_date) as o_month,
    DAY(order_date) as o_day,
    DATENAME(MONTH, order_date) as or_month,    -- DATENAME for string
    DATENAME(WEEKDAY, order_date) as or_day,      -- DATEPART for Integer
    DATEPART(WEEKDAY, order_date) as dp_day,
    DATEPART(QUARTER, order_date) as dp_qt,
    FORMAT(order_date,'MMMM') as order_month,     -- test using MMMM// MMM// MM// M 
    FORMAT(order_date,'dddd') as order_day         -- test using dddd// ddd// dd// d
from sales.orders;

select 
    order_date, shipped_date,
    DATEDIFF(day, order_date, shipped_date) as day_diff,
    DATEDIFF(MONTH, order_date, shipped_date) as month_diff
from sales.orders


-- to temporarily fill NULL values in tables USE
-- ISNULL  ( SQL Server)
--Coalesce ( mySQL, Oracle, SQLserver)

select
 shipped_date,
 ISNULL( shipped_date, GETDATE()),
 Coalesce(shipped_date, GETDATE())
from sales.orders;


select 
    order_date, shipped_date,
    DATEDIFF(day, order_date, ISNULL(shipped_date,GETDATE())) as day_diff,
    DATEDIFF(MONTH, order_date,ISNULL(shipped_date,GETDATE())) as month_diff,
    DATEADD(day , 3, order_date) as addd_day
from sales.orders



-- SQL Case

/*
 select
     case
        when condition then value
        when condition then value
    end
 from table_name;

*/

select 
   product_id, product_name, model_year, list_price,
      case
         when list_price <=1000 then 'Low Price Product'
         when list_price >1000 and list_price <=2500 then 'Average Price Product'
         when list_price >2500 then 'High Prie Product'
         Else 'Invalid Price'
      End as price_label
from production.products
order by price_label asc;


-- 1-> Pending, 2-> Processing, 3-> Rejected, 4-> Completed
/* 

Find order details and show order status label. After labeling filter data showing orders which is
currently in processing and also show how many exact days required to deliver that order.

*/

select 
   order_id, order_status,order_date, required_date,
   DATEDIFF(day, order_date, required_date) as required_days_to_deliver,
   case 
     when order_status =1 then 'Pending'
     when order_status =2 then 'Processing'
     when order_status =3 then 'Rejected'
     when order_status =4 then 'Completed'
  End as order_status_label
from sales.orders
  where order_status = 2 ;


  /*

   Find order item details and its total price. For each item purchased by customer 13% vat must be
   added in total price. after calculating total price show price label as
   1. 0-30000 -> low price purchase
   2. > 3000 -> average price purchase
   3. > 8000 -> high ptice purchase

   */

   select * from sales.order_items

   select 
      order_id,item_id, product_id, quantity,list_price, discount,
      (((list_price*quantity) * (1 - discount)*1.13)) as total_price,
      case
        when (((list_price*quantity) * (1 - discount)*1.13)) between 0 and 3000 then 'Low Price Purchase'
        when (((list_price*quantity) * (1 - discount)*1.13)) > 3000 and (((list_price*quantity) * (1 - discount)*1.13))<=8000 then 'Average Price Purchase'
        when (((list_price*quantity) * (1 - discount)*1.13)) >8000 then 'High Price Purchase'
     end as total_price_label
    from sales.order_items;




