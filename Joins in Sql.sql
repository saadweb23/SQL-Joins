--------------------------------------------------------------------------------------------------
--2.1. Write a query that lists every product with its brand name,
-- using production.products and production.brands.
--------------------------------------------------------------------------------------------------

select p.product_name , b.brand_name from production.products as p
inner join production.brands as b 
on p.brand_id = b.brand_id;

--------------------------------------------------------------------------------------------------
--2.2. Using a LEFT JOIN, write a query that finds every store with zero staff
-- currently assigned to it.
--------------------------------------------------------------------------------------------------

select s.store_id , s.store_name , stf.first_name + ' ' + stf.last_name as Staff_name from sales.stores as s
left join sales.staffs as stf
on s.store_id = stf.store_id
where stf.staff_id is null;

--------------------------------------------------------------------------------------------------
--2.3. Explain, in your own words, why the following query returns every product regardless
-- of stock level, and rewrite it so that it only returns products with fewer than 5 units in stock
-- at store 1:
--------------------------------------------------------------------------------------------------

-- Given 
SELECT p.product_name, s.quantity
FROM production.products AS p
LEFT JOIN production.stocks AS s
   ON p.product_id = s.product_id AND s.quantity < 5 AND s.store_id = 1;

-- Correct Approach

SELECT p.product_name, s.quantity, s.store_id
FROM production.products AS p
LEFT JOIN production.stocks AS s
   ON p.product_id = s.product_id where s.quantity < 5 AND s.store_id = 1;


--------------------------------------------------------------------------------------------------
--2.4. Write a self join on sales.staffs that lists every manager along with a count placeholder
-- column showing 1 for each employee they manage
-- (you will replace this with a real COUNT in Chapter 3); for now,
-- just produce one row per employee-manager pa
--------------------------------------------------------------------------------------------------

select employee.first_name + ' ' + employee.last_name as employee_name ,
manager.first_name + ' ' + manager.last_name as manager_name ,
1 as count_placeholder
from sales.staffs as employee
inner join sales.staffs as manager
on employee.manager_id = manager.staff_id;

--------------------------------------------------------------------------------------------------
--2.5. Write a three-table join across sales.orders, sales.order_items,
-- and production.products that lists
-- every item in order #1, including product name and quantity.
--------------------------------------------------------------------------------------------------

select p.product_name , oi.quantity , oi.item_id , o.order_id from sales.orders as o
left join sales.order_items as oi
on o.order_id = oi.order_id left join production.products as p
on p.product_id = oi.product_id where o.order_id = 1;

--------------------------------------------------------------------------------------------------
--2.6. A colleague joins orders to order_items and reports "we received 4,658 orders last year." 
-- Explain what actually went wrong with that number and how you would
-- find the true order count instead.
--------------------------------------------------------------------------------------------------

select count(o.order_id)  from sales.orders as o
inner join sales.order_items as oi
on o.order_id = oi.order_id;

-- Correct Way

select  count( distinct o.order_id) from sales.orders as o
inner join sales.order_items as oi
on o.order_id = oi.order_id;


--------------------------------------------------------------------------------------------------
--2.7.
--------------------------------------------------------------------------------------------------
select * from production.products as p
cross join sales.order_items as o;


--A CROSS JOIN is useful when we need all possible combinations, such as every 
--product with every staff member. To avoid accidental CROSS JOINs, use
--the correct JOIN type, write the required ON condition, and check the number of rows returned.


