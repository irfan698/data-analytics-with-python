-- ============================================================
--  ASSIGNMENT 10 — Group By & Subqueries
--  Database : BikeStores
--  Topics   : Aggregate functions, GROUP BY, HAVING,
--             subqueries in WHERE (IN / NOT IN / scalar),
--             subqueries in FROM (derived tables),
--             subqueries in SELECT
-- ============================================================


-- ============================================================
--  Question 1 — Aggregate Functions
--  From sales.order_items, write ONE query that returns:
--    • total number of order lines
--    • total units sold (SUM of quantity)
--    • average, minimum and maximum list_price
--  Give every column a meaningful alias.
-- ============================================================
use BikeStores;
-- Write your query below:
Select * from sales.order_items;
Select 
	count(*)  AS total_order_lines,
	SUM(quantity) AS total_unit_sold,
	AVG(list_price) AS Average_Pirce,
	MIN(list_price) AS Minimum_Pirce,
	MAX(list_price) AS Maximum_Pirce
FROM
	sales.order_items;

-- ============================================================
--  Question 2 — COUNT(*) vs COUNT(column)
--  a) How many rows are there in sales.customers?
--  b) How many customers have an email on record, and how many
--     have a phone number on record?
--  c) Using the results above, how many customers have NO phone
--     number? Confirm it with a separate query using IS NULL.
--  Add the numbers you get as comments.
-- ============================================================
select * from sales.customers;

-- Part a:
Select COUNT(*) AS total_customers
FROM sales.customers;

-- Part b:
SELECT
    COUNT(email) as customers_email,
    COUNT(phone) as customers_phone
from  sales.customers;

-- Part c:

SELECT COUNT(*) AS customers_No_phone
FROM sales.customers
WHERE phone IS NULL;       -- total row 1445 recorded, so with phone is 178 row and without phone (null) is 1267 

-- ============================================================
--  Question 3 — GROUP BY
--  a) Find the total units sold (SUM of quantity) for each
--     product_id in sales.order_items, highest first.
--  b) Count the number of customers in each state, highest
--     first.
--  c) Count the number of orders handled by each staff_id and
--     each order_status combination.
-- ============================================================
Select * from sales.order_items;
select * FROM sales.customers;
select * FROM sales.orders;
-- Part a:
SELECT product_id, SUM(quantity) AS total_units_sold
FROM sales.order_items
GROUP BY product_id
ORDER BY total_units_sold DESC;

---SELECT product_id, quantity
---FROM sales.order_items
--where product_id = 151;


-- Part b:
SELECT state, COUNT(*) AS total_customers
FROM sales.customers
GROUP BY state
ORDER BY total_customers DESC;

--SELECT state
--FROM sales.customers
--where state = 'TX';
-- Part c:
SELECT staff_id, order_status, COUNT(*) AS total_orders
FROM sales.orders
GROUP BY staff_id, order_status
ORDER BY staff_id, order_status;

--SELECT staff_id, order_status
--FROM sales.orders                137
--where staff_id = 2 and order_status = 4;
-- ============================================================
--  Question 4 — GROUP BY with Joins
--  a) Show category_name and the average list_price of its
--     products (rounded to 2 decimals). Join products and
--     categories.
--  b) Show brand_name and the number of products in each brand,
--     sorted by the product count descending.
--  c) For every customer, show customer_id, first_name,
--     last_name, order_count and total_spent.
--     total_spent = SUM(quantity * list_price * (1 - discount))
--     Hint: use COUNT(DISTINCT order_id) so orders are not
--     counted once per item.
-- ============================================================
select * FROM production.products;
select * FROM production.categories;
select * FROM production.brands;
-- Part a:

SELECT 
    c.category_name, 
    ROUND(AVG(p.list_price), 2) AS average_price
FROM production.products p
INNER JOIN production.categories c
ON p.category_id = c.category_id
GROUP BY c.category_name;

-- Part b:

SELECT 
    b.brand_name, 
    COUNT(p.product_id) AS product_count
FROM 
    production.products p
INNER JOIN production.brands b
 ON p.brand_id = b.brand_id
GROUP BY b.brand_name
ORDER BY product_count DESC;

--SELECT  b.brand_name
--FROM 
--    production.products p
--INNER JOIN production.brands b
-- ON p.brand_id = b.brand_id
--where brand_name in ('Haro', 'Heller');

-- Part c:

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT o.order_id) AS order_count,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_spent
FROM 
sales.customers c
INNER JOIN sales.orders o
ON c.customer_id = o.customer_id 
INNER JOIN sales.order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name;

--select * from sales.orders;
--select * from sales.order_items;
--select * from sales.customers;
-- ============================================================
--  Question 5 — HAVING
--  a) List the model_year values that have more than 50
--     products, with the product count.
--  b) List the customers who have placed 2 or more orders
--     (customer_id and order_count).
--  c) List the product_ids that have sold more than 100 units
--     in total.
--  d) In a comment, explain why part (a) cannot be written
--     with WHERE alone.
-- ============================================================

-- Part a: 
select
    model_year, 
    COUNT(*) AS product_count
FROM
production.products
GROUP BY model_year
HAVING COUNT(*) > 50;

-- Part b: Customers who placed 2 or more orders.
SELECT 
    customer_id, 
    COUNT(*) AS order_count
FROM 
   sales.orders
GROUP BY customer_id
HAVING COUNT(*) >= 2;

-- Part c: Products that sold more than 100 units in total.
SELECT 
    product_id, 
    SUM(quantity) AS total_units_sold
FROM 
    sales.order_items
GROUP BY product_id
HAVING SUM(quantity) > 100;

-- ============================================================
--  Question 6 — WHERE + GROUP BY + HAVING Together
--  Using only orders placed in the year 2017, find the stores
--  (store_id) whose total revenue is above 100000.
--  Show store_id and total_revenue, highest first.
--  Hint: WHERE filters rows before grouping, HAVING filters
--  groups after grouping.
-- ============================================================

-- Write your query below:

SELECT
    o.store_id,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_revenue
FROM sales.orders o
INNER JOIN sales.order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_date >= '2017-01-01' AND o.order_date <= '2017-12-31'
GROUP BY o.store_id
HAVING SUM(oi.quantity * oi.list_price * (1 - oi.discount)) > 100000
ORDER BY total_revenue DESC;

-- ============================================================
--  Question 7 — Subquery in WHERE (IN)
--  a) Return all orders placed by customers who live in
--     'New York'. Use a subquery on sales.customers.
--  b) Return the product_id and product_name of all products
--     that belong to the categories 'Electric Bikes' or
--     'Cruisers Bicycles'. Use a subquery on categories.
--  c) Return the customers (first_name, last_name, city) who
--     have placed at least one order. Use IN with a subquery.
-- ============================================================
select * from sales.orders;
select * from sales.customers;
select * from production.products;
select * from production.categories;

-- Part a: 
SELECT * FROM sales.orders
WHERE customer_id IN (
    SELECT customer_id
    FROM sales.customers
    WHERE city = 'New York'
);

-- Part b: 
select 
    product_id, 
    product_name
from  production.products
WHERE category_id IN (
    SELECT category_id
    FROM production.categories
    WHERE category_name IN ('Electric Bikes', 'Cruisers Bicycles')
);

-- Part c:
select
    first_name, 
    last_name, city
from sales.customers
WHERE customer_id IN (
    SELECT customer_id
    FROM sales.orders
);

-- ============================================================
--  Question 8 — Subquery in WHERE (Scalar & NOT IN)
--  a) Return all products priced ABOVE the overall average
--     list_price. Do not hardcode the average.
--  b) Return all products priced BELOW the overall average
--     list_price, and write a second query that counts how
--     many such products there are.
--  c) Return the customers who have NEVER placed an order,
--     using NOT IN.
--  d) Return the products that have never been ordered
--     (not present in sales.order_items).
--  Hint for c and d: filter out NULLs inside the subquery so
--  NOT IN works correctly.
-- ============================================================
select * from production.products; 
select * from sales.customers;
select * from sales.orders;
select * from sales.order_items;

-- Part a: 
select
    product_name, 
    list_price
from 
    production.products
WHERE list_price > (SELECT AVG(list_price) FROM production.products);

-- Part b:
SELECT 
    product_name, 
    list_price
FROM 
    production.products
WHERE list_price < (SELECT AVG(list_price) FROM production.products);

-- Count of those products
select COUNT(*) AS products_below_average
FROM 
    production.products
WHERE list_price < (SELECT AVG(list_price) FROM production.products);

-- Part c: Customers who have NEVER placed an order (NOT IN).
select 
    customer_id, 
    first_name, 
    last_name
FROM sales.customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM sales.orders
    WHERE customer_id IS NOT NULL
);

-- Part d:
select 
    product_id, 
    product_name
from 
    production.products
WHERE product_id NOT IN (
    SELECT product_id
    FROM sales.order_items
    WHERE product_id IS NOT NULL
);

-- ============================================================
--  Question 9 — Subquery in FROM (Derived Table)
--  a) First find the number of orders handled by each staff
--     member. Then, using that result as a derived table,
--     calculate the average, minimum and maximum order count
--     per staff member.
--  b) Using a derived table of total_spent per customer,
--     return the average total_spent across all customers.
--  Remember: a derived table needs an alias.
-- ============================================================

-- Part a: 
SELECT
    AVG(order_count) AS average_orders,
    MIN(order_count) AS minimum_orders,
    MAX(order_count) AS maximum_orders
FROM (
    SELECT staff_id, COUNT(*) AS order_count
    FROM sales.orders
    GROUP BY staff_id
) AS staff_orders;

-- Part b:
SELECT AVG(total_spent) AS average_total_spent
FROM (
    SELECT
        o.customer_id,
        SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_spent
    FROM 
        sales.orders o
    INNER JOIN sales.order_items oi
        ON o.order_id = oi.order_id
    GROUP BY o.customer_id
) AS customer_spending;


-- ============================================================
--  Question 10 — Subquery in SELECT
--  a) For each product (product_id, product_name, list_price),
--     show the total quantity sold as a column named
--     units_sold, using a correlated subquery on
--     sales.order_items.
--  b) For each order (order_id, order_date), show the number of
--     items in that order as item_count and the highest
--     list_price in that order as max_item_price.
--  c) Show the difference between each product's list_price and
--     the overall average list_price as price_difference.
-- ============================================================

-- Part a:
select
    p.product_id,
    p.product_name,
    p.list_price,
    (SELECT ISNULL(SUM(oi.quantity), 0)
     from 
        sales.order_items oi
     WHERE oi.product_id = p.product_id) AS units_sold
FROM production.products p;

-- Part b:
select
    o.order_id,
    o.order_date,
    (SELECT COUNT(*)
     FROM sales.order_items oi
     WHERE oi.order_id = o.order_id) AS item_count,
    (SELECT MAX(oi.list_price)
     FROM sales.order_items oi
     WHERE oi.order_id = o.order_id) AS max_item_price
FROM sales.orders o;

-- Part c: 
SELECT
    product_name,
    list_price,
    list_price - (SELECT AVG(list_price) FROM production.products) AS price_difference
FROM production.products;



-- ============================================================
--  Question 11 — Challenge
--  Find the customers whose total_spent is higher than the
--  average total_spent of all customers.
--  Show customer_id, first_name, last_name and total_spent,
--  highest first.
--  Hint: combine GROUP BY + HAVING with a scalar subquery
--  (or a derived table) that calculates the average.
-- ============================================================

-- Write your query below:

select
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_spent
from
    sales.customers c
INNER JOIN sales.orders o
    ON c.customer_id = o.customer_id
INNER JOIN sales.order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(oi.quantity * oi.list_price * (1 - oi.discount)) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT
            o2.customer_id,
            SUM(oi2.quantity * oi2.list_price * (1 - oi2.discount)) AS total_spent
        FROM sales.orders o2
        INNER JOIN sales.order_items oi2
            ON o2.order_id = oi2.order_id
        GROUP BY o2.customer_id
    ) AS customer_spending
)
ORDER BY total_spent DESC;