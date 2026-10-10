/*

Sub Query
--------------
1. Single Row SubQuery
    - If inner query provides with single row and single columns data
    - Comparison Operator ->,=, !=, <,>,<=,>=

2. Multi Row SubQuery
      -if inner query procides with multiple row and single column data
      - In, (Any, All -> Comparison Operator)

select * from table_name where col_name < (select col_name from table_name)
                ^ outer query                        ^ inner query

*/

-- FInd all products whose price is less than its average price.

select * from production.products

select 
 avg(list_price) as average_list_price     --1520.591401
from production.products

select *
from production.products where list_price < 1520.591401

-- subquery

select
    *                        -- inner query should have the same column name as used with 'where' clause in outer query
from production.products where list_price < (select 
                                                 avg(list_price)
                                            from production.products);


--Find Second highest list price from product details
select * from production.products order by list_price desc;

select * from production.products where list_price=(
            select 
            max(list_price)
            from production.products where list_price <(select
                                                            max(list_price)
                                                            from production.products))



-- Find customer details whose order has been rejected

select
   CONCAT(first_name,' ',last_name) as customer_name, email,street,city,zip_code
from sales.customers where customer_id in (
   select customer_id from sales.orders where order_status=3)


-- FInd top 5 customers details whose order status id completed and who has spent more than 8000 in total

select 
    CONCAT(sc.first_name,' ',sc.last_name) as customer_name, sc.email,sc.street,sc.city,sc.zip_code
from sales.customers sc where customer_id in(
        select top 5
           so.customer_id
        from sales.order_items soi 
        join sales.orders so                             
        on soi.order_id=so.order_id
        where ((list_price * quantity) * (1-discount)) >8000      -- for calculated results like this we need to do join in inner query
        and order_status=4
        order by ((list_price * quantity) * (1-discount)) desc
);



  

  /*
   
   ANY -> OR
   ALL -> AND

  */

  -- FInd all products whose last price is less hten 209.99 / 250.99

 select 
    *
from production.products
where list_price < any (
    select list_price from production.products where list_price in (209.99,250.99)
)order by list_price;


  -- FInd all products whose last price is less hten 209.99 and 250.99

 select 
    *
from production.products
where list_price < all (
    select list_price from production.products where list_price in (209.99,250.99)
)order by list_price;


-- FInd customer details who bought products whose price is less than 209.00 and 250.99

select first_name, last_name, email, state, city, street, zip_code from sales.customers where
customer_id in(
   select customer_id from sales.orders where order_id in(
       select order_id from sales.order_items where product_id in (
            select product_id from production.products where list_price < all (
                  select list_price from production.products where list_price in (209.99, 250.99)
                  ))));
            

--FInd staff details who have managed orders which was rejected 
--and sold products whose price is more than 1000 whose model year is 2017

select 
    *
from sales.staffs where staff_id in (
          select staff_id from sales.orders where order_id in(
              select order_id from sales.order_items where product_id in(
                 select product_id from production.products where list_price >1000  and model_year= 2017
                 ) ) and order_status =3
);



  select * from sales.orders
  select * from sales.order_items
  select * from sales.staffs
  select * from production.products