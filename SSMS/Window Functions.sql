select * from [Fraud Detection Dataset]

/*

Window Function
-------------------------------

-- doesnot accpets arguments
Row Number  -> find and remove duplicate value
Rank         -> data ranking   -- skip value
Dense Rank    -> data ranking -- doesnot skip value

--accepts arguments
NTile  -> divides data
Lead  -> Next value
Lag    -> Previous Value

SYNTAX
------------
select
   col1,col2, col3,window_function() Over( partition by com_name order_by col_name asc/desc)
from table_name;

   */


-- Row Number

-- finding duplicate data
select 
     Transaction_ID,User_ID, Transaction_Amount, Transaction_Type, Time_of_Transaction,
     Device_Used, Location, Previous_Fraudulent_Transactions, Account_Age, Number_of_Transactions_Last_24H,
     Payment_Method, Fraudulent,
     ROW_NUMBER() Over( partition by Transaction_ID order by transaction_amount) as rn

from [Fraud Detection Dataset]


-- removing duplicate data

with fraud_duplicate_data as (
        select 
             Transaction_ID,User_ID, Transaction_Amount, Transaction_Type, Time_of_Transaction,
             Device_Used, Location, Previous_Fraudulent_Transactions, Account_Age, Number_of_Transactions_Last_24H,
             Payment_Method, Fraudulent,
             ROW_NUMBER() Over( partition by Transaction_ID order by transaction_amount) as rn

        from [Fraud Detection Dataset]

        )
delete from fraud_duplicate_data where rn>1;          -- permanent removal





-- Rank

select
   product_id, product_name, brand_id, category_id, model_year, list_price,
   Rank() over(order by list_price)
from production.products;


 --Dense  Rank

select
   product_id, product_name, brand_id, category_id, model_year, list_price,
   DENSE_Rank() over(order by list_price)
from production.products;


-- finding second highest price product details

select product_id, product_name, brand_id, category_id, model_year, list_price from(
    select
   product_id, product_name, brand_id, category_id, model_year, list_price,
   DENSE_Rank() over(order by list_price desc) as rn
from production.products
) as data 
where rn =2;


-- finding second highest price product details for each brand

select product_id, product_name, brand_id, category_id, model_year, list_price from(
    select
   product_id, product_name, brand_id, category_id, model_year, list_price,
   DENSE_Rank() over(partition by brand_id order by list_price desc) as rn
from production.products
) as data 
where rn =2;




-- NTile

 select 
        Transaction_ID,User_ID, Transaction_Amount, Transaction_Type, Time_of_Transaction,
        Device_Used, Location, Previous_Fraudulent_Transactions, Account_Age, Number_of_Transactions_Last_24H,
        Payment_Method, Fraudulent,
        NTILE(3) Over( partition by Time_of_Transaction order by Transaction_Amount)     -- Transaction_ID is grouped  first then transaction_amount is place in descending order 
                                                                                           -- and on that basis transaction_id is divided into 3 parts 
from [Fraud Detection Dataset]

 select 
        Transaction_ID,User_ID, Transaction_Amount, Transaction_Type, Time_of_Transaction,
        Device_Used, Location, Previous_Fraudulent_Transactions, Account_Age, Number_of_Transactions_Last_24H,
        Payment_Method, Fraudulent,
        NTILE(3) Over(order by Transaction_Amount)     -- here only transaction_id is divided into 3 parts 
from [Fraud Detection Dataset]


--Lead


 select 
        Transaction_ID,User_ID, Transaction_Amount, Transaction_Type, Time_of_Transaction,
        Device_Used, Location, Previous_Fraudulent_Transactions, Account_Age, Number_of_Transactions_Last_24H,
        Payment_Method, Fraudulent,
        LEAD(Transaction_Type) Over(order by Transaction_Amount)    -- this column shows what is the next Transaction_Type 
from [Fraud Detection Dataset]


--Lag function


 select 
        Transaction_ID,User_ID, Transaction_Amount, Transaction_Type, Time_of_Transaction,
        Device_Used, Location, Previous_Fraudulent_Transactions, Account_Age, Number_of_Transactions_Last_24H,
        Payment_Method, Fraudulent,
        LAG(Transaction_Type) Over(order by Transaction_Amount)    -- this column shows what was the previous Transaction_Type 
from [Fraud Detection Dataset]



-- index
----------------
-- syntax  -> create index idx_name on table (column_name)

create index idx_store_name on sales.stores (store_name)


-- view

create view customer_rejected_orders as 
  select 
     sc.customer_id, sc.first_name, sc.last_name, sc.phone, sc.email, sc.street,sc.city,sc.state,sc.zip_code

from sales.customers sc
join sales.orders so
on sc.customer_id= so.customer_id
where so.order_status= 3;


select * from customer_rejected_orders;


--synonym

create synonym cro for customer_rejected_orders    -- just creating another name for customer_rejected_orders

select * from cro;      -- gives exact same data as customer_rejected_orders table



-- Stored Procedure
create procedure customer_orders
as
 Begin
    select 
     sc.customer_id, sc.first_name, sc.last_name, sc.phone, sc.email, sc.street,sc.city,sc.state,sc.zip_code

from sales.customers sc
join sales.orders so
on sc.customer_id= so.customer_id
where so.order_status= 3;
End;

exec customer_orders;