SELECT * FROM production.products;

-- column wise filteration 
SELECT customer_id,first_name, last_name FROM SALES.customers;

-- as -> Alias
SELECT 
	product_id as product_primary_id, 
	product_name ,
	list_price,
	list_price * 0.9 as dicounted_price -- 90 % value (10 % dis
FROM 
	production.products;



SELECT list_price AS "Retail Price" FROM production.products;


SELECT DISTINCT category_id FROM production.products;

select product_id, product_name, category_id from production.products;

select * from production.categories;

SELECT product_name, list_price
FROM production.products 
order by list_price desc; -- asc


SELECT product_name, category_id, list_price
FROM production.products
ORDER BY category_id ASC, list_price asc;


SELECT top 5 product_name, list_price
FROM production.products
ORDER BY list_price DESC;

-- where 

SELECT product_name, category_id, list_price
FROM production.products
where category_id = 6 or category_id = 7;


SELECT product_name, category_id, list_price
FROM production.products
where category_id = 6 and list_price > 1000;


-- wrong one it will return all the results with list price greater than 1000 or with cateogry id 6 
SELECT product_name, category_id, list_price
FROM production.products
where category_id = 6 or list_price > 1000;


-- with cateid - 6 & 7 and list price > 1000
SELECT product_name, category_id, list_price
FROM production.products
where (category_id =  6 or category_id = 7) AND list_price > 1000;

-- IN
-- 5,6,7
SELECT product_name, category_id, list_price
FROM production.products
where category_id in (4,5,6,7)
order by category_id asc


-- list price 500 - 1500 
SELECT product_name, category_id, list_price
FROM production.products
where list_price >= 500 and list_price <= 1500;

-- By using between

SELECT product_name, category_id, list_price
FROM production.products
where list_price between 500 AND 1500;


-- Null 

select * from sales.orders
where shipped_date is null;

