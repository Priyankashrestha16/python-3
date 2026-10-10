/*

Common Table Expressions (CTE)
------------------------------------------
- Temprorary data table

with cte_name as(
   query....
   )
   select * from cte_name;

*/


 -- FInd all products whose last price is less hten 209.99 and 250.99

 with product_price as (
   select product_id, list_price from production.products where list_price < all(
      select list_price from production.products where list_price in (209.99,250.99)
    )
    )
select distinct sc.first_name, sc.last_name, pp.product_id from product_price pp
join sales.order_items soi
on pp.product_id = soi.product_id
join sales.orders so
on soi.order_id= so.order_id
join sales.customers sc
on so.customer_id = sc.customer_id;



-- FInd total amout spent by customers from each state whose order is completed . Display State and Total amount

with customer_detail as (
     select 
            CONCAT(sc.first_name, ' ', sc.last_name) as customer_name,sc.state,
            ((soi.list_price * soi.quantity) * (1- soi.discount)) as total_amount
        from sales.customers sc
        join sales.orders so
        on sc.customer_id =so.customer_id
        join sales.order_items soi
        on so.order_id = soi.order_id
)
select state, SUm(total_amount) from customer_detail
group by state;
