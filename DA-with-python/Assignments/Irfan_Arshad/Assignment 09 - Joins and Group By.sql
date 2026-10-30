-- ============================================================
-- Before start Assignment first I check following
-- Database : BikeStores
-- How many schemas in database: 2 (production, sales)
-- How many tables in every schema: production = 4, sales = 5
-- ============================================================
-- Before starting the assignment, I check the following:
-- Database : BikeStores
-- 1. How many schemas are in the database
-- 2. How many tables are in every schema
-- ============================================================

USE BikeStores;

SELECT
    s.name AS schema_name,
    COUNT(t.name) AS total_tables
FROM sys.schemas s
INNER JOIN sys.tables t
    ON s.schema_id = t.schema_id
GROUP BY s.name
ORDER BY s.name;

SELECT
    s.name AS schema_name,
    t.name AS table_name
FROM sys.tables t
INNER JOIN sys.schemas s
    ON t.schema_id = s.schema_id
ORDER BY s.name, t.name;

-- ============================================================
--  ASSIGNMENT 09 — Joins & Group By
--  Database : BikeStores
--  Topics   : INNER / LEFT / RIGHT / FULL OUTER JOIN,
--             multi-table joins, aggregate functions,
--             GROUP BY, HAVING
-- ============================================================
USE BikeStores;

-- ============================================================
--  Question 1 — INNER JOIN
--  Return the product_name, brand_name, and list_price of all
--  products by joining production.products with
--  production.brands.
--  Sort the results by brand_name ascending, then list_price
--  descending.
-- ============================================================

-- Write your query below:
select * from production.products;
select * from production.brands;

select
    p.product_name,
    b.brand_name,
    p.list_price
from 
    production.products p
inner join production.brands b
on p.brand_id = b.brand_id
order by b.brand_name asc,p.list_price desc;


-- ============================================================
--  Question 2 — Joining Three Tables
--  Return the product_name, brand_name, category_name, and
--  model_year of every product by joining products, brands and
--  categories.
--  Only include products with a list_price above 1000.
-- ============================================================

-- Write your query below:
select * from production.products;
select * from production.brands;
select * from production.categories;

select
    p.product_name,
    b.brand_name,
    c.category_name,
    p.model_year
from production.products p
inner join production.brands b
on p.brand_id = b.brand_id
inner join production.categories c
on p.category_id = c.category_id
where p.list_price >1000;

-- ============================================================
--  Question 3 — LEFT JOIN
--  a) List every customer (first_name, last_name, city) along
--     with the order_id and order_date of their orders.
--     Customers who never placed an order must still appear.
--  b) Modify the query to return ONLY the customers who have
--     never placed an order.
--     Hint: filter on a NULL value from the right-hand table.
-- ============================================================
select * from sales.customers;
select * from sales.orders;
-- Part a:
select
    c.first_name,
    c.last_name,
    c.city,
    o.order_id,
    o.order_date
from
    sales.customers c
left join sales.orders o
on c.customer_id = o.customer_id;

-- Part b:

select
    c.first_name,
    c.last_name,
    c.city,
    o.order_id,
    o.order_date
from
    sales.customers c
left join sales.orders o
on c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- ============================================================
--  Question 4 — RIGHT JOIN & FULL OUTER JOIN
--  a) Using a RIGHT JOIN, list every store (store_name) with
--     the staff members (first_name, last_name) working there.
--     Join sales.staffs and sales.stores.
--  b) Using a FULL OUTER JOIN between production.products and
--     production.stocks, find the products that have no stock
--     record at all. Return product_name and quantity.
-- ============================================================
select * from sales.staffs;
select * from sales.stores;
select * from production.products;
select * from production.stocks;

-- Part a

SELECT 
    sto.store_name,
    sta.first_name,
    sta.last_name
FROM
sales.staffs sta
RIGHT JOIN sales.stores sto
ON sta.store_id = sto.store_id;

-- Part b:

SELECT 
    p.product_name, 
    s.quantity
FROM 
production.products p
FULL OUTER JOIN production.stocks s
ON p.product_id = s.product_id
WHERE s.product_id IS NULL;


-- ============================================================
--  Question 5 — Multi-Table Join (Order Details)
--  Build an order-detail report with the following columns:
--    order_id, order_date, customer full name
--    (first_name + last_name), product_name, quantity,
--    and line_total = quantity * order_items.list_price
--                     * (1 - discount)
--  Join sales.orders, sales.customers, sales.order_items and
--  production.products.
--  Sort by order_id, then product_name.
-- ============================================================
select * from sales.customers;
select * from sales.orders;
select * from sales.order_items;
select * from production.products;

-- Write your query below:

SELECT
    o.order_id,
    o.order_date,
    c.first_name + ' ' + c.last_name AS customer_name,
    p.product_name,
    oi.quantity,
    oi.quantity * oi.list_price * (1 - oi.discount) AS line_total
FROM sales.orders o
INNER JOIN sales.customers c
    ON o.customer_id = c.customer_id
INNER JOIN sales.order_items oi
    ON o.order_id = oi.order_id
INNER JOIN production.products p
    ON oi.product_id = p.product_id
ORDER BY o.order_id, p.product_name;

-- ============================================================
--  Question 6 — Aggregate Functions
--  From production.products, write a single query that returns:
--    • total number of products
--    • lowest, highest and average list_price
--      (round the average to 2 decimals)
--  Give every column a meaningful alias.
-- ============================================================
select * from production.products;

-- Write your query below:

SELECT
    COUNT(*) AS total_products,
    MIN(list_price) AS lowest_price,
    MAX(list_price) AS highest_price,
    ROUND(AVG(list_price), 1) AS average_price
FROM production.products;

-- ============================================================
--  Question 7 — GROUP BY
--  a) Count the number of products in each category. Show
--     category_name and product_count (join with categories),
--     sorted by product_count descending.
--  b) For each brand_name and model_year combination, find the
--     average list_price. Sort by brand_name, then model_year.
-- ============================================================

select * from production.categories;
select * from production.products;
select * from production.brands;

-- Part a:
SELECT 
    c.category_name, 
    COUNT(p.product_id) AS product_count
FROM 
production.categories c
INNER JOIN production.products p
ON c.category_id = p.category_id
GROUP BY c.category_name
ORDER BY product_count DESC;

-- Part b:

SELECT 
    b.brand_name, 
    p.model_year, 
    AVG(p.list_price) AS average_price
FROM 
production.products p
INNER JOIN production.brands b
    ON p.brand_id = b.brand_id
GROUP BY b.brand_name, p.model_year
ORDER BY b.brand_name, p.model_year;

-- ============================================================
--  Question 8 — GROUP BY with Joins
--  a) Find the total number of orders placed by each customer.
--     Show customer_id, full name and total_orders, sorted by
--     total_orders descending.
--  b) Find the total revenue per store.
--     revenue = SUM(quantity * list_price * (1 - discount))
--     Show store_name and total_revenue, highest first.
--     Join orders, order_items and stores.
-- ============================================================

select * from sales.customers;
select * from sales.orders;
select * from sales.order_items;
select * from sales.stores;

-- Part a:

select
    c.customer_id,
    c.first_name + ' ' + c.last_name AS full_name,
    COUNT(o.order_id) AS total_orders
from 
sales.customers c
INNER JOIN sales.orders o
on c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_orders DESC;

-- Part b

select
    s.store_name,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_revenue
from 
sales.orders o
INNER JOIN sales.order_items oi
on o.order_id = oi.order_id
INNER JOIN sales.stores s
on o.store_id = s.store_id
GROUP BY s.store_name
order by total_revenue DESC;

-- ============================================================
--  Question 9 — HAVING
--  a) List the brands (brand_name) that have more than 20
--     products.
--  b) List the customers (full name) who have placed 3 or more
--     orders.
--  c) Explain in a comment: what is the difference between
--     WHERE and HAVING?
-- ============================================================

select * from production.brands;
select * from production.products;
select * from sales.customers;
select * from sales.orders;

-- Part a:

select
    b.brand_name, 
    COUNT(p.product_id) AS total_products
from 
production.brands b
INNER JOIN production.products p
on b.brand_id = p.brand_id
GROUP BY b.brand_name
HAVING COUNT(p.product_id) > 20;

-- Part b:

select
    c.first_name + ' ' + c.last_name AS full_name,
    COUNT(o.order_id) AS total_orders
from
sales.customers c
INNER JOIN sales.orders o
on c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(o.order_id) >= 3;

-- Part c (answer as a comment):

-- WHERE filters the rows before grouping.
-- HAVING filters the groups after GROUP BY is done.

-- ============================================================
--  Question 10 — Combined Challenge
--  Find the top 5 best-selling products by total quantity sold.
--  Show product_name, category_name, total_quantity_sold and
--  total_revenue.
--  Only count orders that are completed (order_status = 4).
--  Hint: join order_items, orders, products and categories,
--  then use WHERE, GROUP BY, ORDER BY and TOP.
-- ============================================================

select * from production.brands;
select * from production.products;
select * from sales.customers;
select * from sales.orders;

-- Write your query below:

SELECT TOP 5
    p.product_name,
    c.category_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_revenue
FROM 
sales.order_items oi
INNER JOIN sales.orders o
on oi.order_id = o.order_id
INNER JOIN production.products p
on oi.product_id = p.product_id
INNER JOIN production.categories c
on p.category_id = c.category_id
WHERE o.order_status = 4
GROUP BY p.product_name, c.category_name
ORDER BY total_quantity_sold DESC;