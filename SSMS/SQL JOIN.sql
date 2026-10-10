/*

SQL Join
--------------------------
1. Inner Join   --> similar to intersection  (common)
2. Left Join    --> join which extracts all data of left column and only extracts
                   common data ( as in similar pk and fk) from right column with NULL in un-common data
3. Right Join   --> join which extracts all data of right column and only extracts
                   common data ( as in similar pk and fk) from left column with NULL in un-common data
4. Outer Join    --> Combination of Inner, Left and Right join in order
5. Self Join     --> similar to inner join but with itself ( join between same table column)
6. Natural Join   --> ((inner join)) using where clause 
7. Cross Join     --> base join (happens first then only other join is done)


Syntax
------------------
select
   t1.col1,t1.col2,t2.col3,t2,col4
   from table1 t1         -> t1,t2 are alias of table1 and table2
   join table2 t2
   on t1.pk = t2.fk;   // on t1.fk=t2.pk     pk->primary key, fk->foreign key
*/

-- joining customer to products through customer-> order -> order_item ->products

-- customer -> order join
select
   CONCAT(sc.first_name,' ',sc.last_name) as customer_name,sc.email,sc.street,sc.city,sc.zip_code,
   so.customer_id,so.order_date,so.order_status,so.required_date,so.shipped_date
from sales.customers sc
join sales.orders so
on sc.customer_id =so.customer_id ;


--  customer -> order -> order_items

-- find total amount spent by each customers. Display customer full name and total price

select
  CONCAT(sc.first_name,' ',sc.last_name) as customer_name,
  SUM((soi.list_price * soi.quantity)*(1-soi.discount)) as total_price

from sales.customers sc
join sales.orders so
on sc.customer_id= so.customer_id
join sales.order_items soi
on so.order_id= soi.order_id
group by CONCAT(sc.first_name,' ',sc.last_name);


 -- CROSS Join   ( just knowing the flow)

 select * from sales.customers;

 select * from sales.orders;

 select
   *
from sales.customers
cross join sales.orders;

-- FInd customer name and product name they have bought and from which store they ordered that product.
-- Only show those orders from 2017 which has been delivered successfully

select
    CONCAT(sc.first_name,' ',sc.last_name) as customer_name,
    pp.product_name,ss.store_name,so.order_date

from sales.customers sc
join sales.orders so
on sc.customer_id = so.customer_id
join sales.stores ss
on ss.store_id= so.store_id
join production.products pp
on pp.product_id=ss.store_id
where YEAR(order_date) = 2017 and order_status=4;


-- Self Join


-- Find Manager name and staff name
select 
   CONCAT(s1.first_name, ' ', s1.last_name) as manager_name,
   CONCAT(s2.first_name,' ',s2.last_name) as staff_name
from sales.staffs s1     
join sales.staffs s2
on s1.staff_id=s2.manager_id;

select 
   CONCAT(s1.first_name, ' ', s1.last_name) as manager_name,
   count(s2.staff_id) as total_staff
from sales.staffs s1     
join sales.staffs s2
on s1.staff_id=s2.manager_id
group by CONCAT(s1.first_name, ' ', s1.last_name);


select
  CONCAT(s1.first_name, ' ', s1.last_name) as manager_name,
  count(distinct so.customer_id) as total_customer,
  count(distinct s2.staff_id) as total_staff
from sales.customers sc
join sales.orders so
on sc.customer_id= so.customer_id
join sales.staffs s1
on s1.staff_id= so.staff_id
join sales.staffs s2
on s1.staff_id=s2.manager_id
group by CONCAT(s1.first_name, ' ', s1.last_name);



-- Left Join
select
  *
from sales.staffs s1
left join sales.staffs s2
on s1.staff_id=s2.manager_id;


--Right Join
select
  *
from sales.staffs s1
right join sales.staffs s2
on s1.staff_id=s2.manager_id;


--Outer Join
select
  *
from sales.staffs s1
full outer join sales.staffs s2
on s1.staff_id=s2.manager_id;


-- Natural Join

select
   *
from sales.customers sc, sales.orders so,sales.order_items soi
where sc.customer_id = so.customer_id
and so.order_id=soi.order_id;


