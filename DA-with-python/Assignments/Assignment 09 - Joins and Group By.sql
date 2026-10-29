-- ============================================================
--  ASSIGNMENT 09 — Joins & Group By
--  Database : BikeStores
--  Topics   : INNER / LEFT / RIGHT / FULL OUTER JOIN,
--             multi-table joins, aggregate functions,
--             GROUP BY, HAVING
-- ============================================================


-- ============================================================
--  Question 1 — INNER JOIN
--  Return the product_name, brand_name, and list_price of all
--  products by joining production.products with
--  production.brands.
--  Sort the results by brand_name ascending, then list_price
--  descending.
-- ============================================================

-- Write your query below:




-- ============================================================
--  Question 2 — Joining Three Tables
--  Return the product_name, brand_name, category_name, and
--  model_year of every product by joining products, brands and
--  categories.
--  Only include products with a list_price above 1000.
-- ============================================================

-- Write your query below:




-- ============================================================
--  Question 3 — LEFT JOIN
--  a) List every customer (first_name, last_name, city) along
--     with the order_id and order_date of their orders.
--     Customers who never placed an order must still appear.
--  b) Modify the query to return ONLY the customers who have
--     never placed an order.
--     Hint: filter on a NULL value from the right-hand table.
-- ============================================================

-- Part a:


-- Part b:




-- ============================================================
--  Question 4 — RIGHT JOIN & FULL OUTER JOIN
--  a) Using a RIGHT JOIN, list every store (store_name) with
--     the staff members (first_name, last_name) working there.
--     Join sales.staffs and sales.stores.
--  b) Using a FULL OUTER JOIN between production.products and
--     production.stocks, find the products that have no stock
--     record at all. Return product_name and quantity.
-- ============================================================

-- Part a:


-- Part b:




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

-- Write your query below:




-- ============================================================
--  Question 6 — Aggregate Functions
--  From production.products, write a single query that returns:
--    • total number of products
--    • lowest, highest and average list_price
--      (round the average to 2 decimals)
--  Give every column a meaningful alias.
-- ============================================================

-- Write your query below:




-- ============================================================
--  Question 7 — GROUP BY
--  a) Count the number of products in each category. Show
--     category_name and product_count (join with categories),
--     sorted by product_count descending.
--  b) For each brand_name and model_year combination, find the
--     average list_price. Sort by brand_name, then model_year.
-- ============================================================

-- Part a:


-- Part b:




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

-- Part a:


-- Part b:




-- ============================================================
--  Question 9 — HAVING
--  a) List the brands (brand_name) that have more than 20
--     products.
--  b) List the customers (full name) who have placed 3 or more
--     orders.
--  c) Explain in a comment: what is the difference between
--     WHERE and HAVING?
-- ============================================================

-- Part a:


-- Part b:


-- Part c (answer as a comment):




-- ============================================================
--  Question 10 — Combined Challenge
--  Find the top 5 best-selling products by total quantity sold.
--  Show product_name, category_name, total_quantity_sold and
--  total_revenue.
--  Only count orders that are completed (order_status = 4).
--  Hint: join order_items, orders, products and categories,
--  then use WHERE, GROUP BY, ORDER BY and TOP.
-- ============================================================

-- Write your query below:
