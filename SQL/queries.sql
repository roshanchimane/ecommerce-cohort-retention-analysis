CREATE DATABASE ecommerce_analyticsProject;
USE ecommerce_analyticsProject;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_value DECIMAL(10,2)
);


-- creating tables
CREATE TABLE customers AS
SELECT customer_id,
		MIN(order_date) AS first_order
FROM orders 
GROUP BY customer_id;

select * from customers;


-- adding cohort column
ALTER TABLE customers
ADD cohort_month DATE;

UPDATE customers
SET cohort_month=DATE_FORMAT(first_order,'%Y-%m-01');

select customer_id,first_order,cohort_month
from customers
limit 10;


-- Cohort Retention Analysis

CREATE VIEW cohort_data AS
SELECT
	o.order_id,
    o.customer_id,
    o.order_date,
    c.cohort_month,
    TIMESTAMPDIFF(MONTH,c.cohort_month,DATE_FORMAT(o.order_date,'%Y-%m-01'))as cohort_index
FROM orders o
JOIN customers c 
	ON o.customer_id=c.customer_id;
    
select * from cohort_data LIMIT 10;

-- Building cohort retention table
CREATE VIEW cohort_counts AS
SELECT
	cohort_month,
    cohort_index,
    COUNT(DISTINCT customer_id) AS active_customers
FROM cohort_data
GROUP BY cohort_month,cohort_index;


select * from cohort_counts
ORDER BY cohort_month,cohort_index;

-- calculate retention percentage
CREATE VIEW cohort_sizes AS
SELECT 
	cohort_month,
    COUNT(DISTINCT customer_id)AS cohort_size
FROM cohort_data
WHERE cohort_index=0
GROUP BY cohort_month;

-- retention matrix
SELECT
	cc.cohort_month,
    cc.cohort_index,
    cc.active_customers,
    cs.cohort_size,
    ROUND((cc.active_customers/cs.cohort_size)*100,2)AS retention_percentage
FROM cohort_counts cc
JOIN cohort_sizes cs
	ON cc.cohort_month=cs.cohort_month
ORDER BY cc.cohort_month,cc.cohort_index;


-- Repeat vs One-Time Buyers
SELECT
	CASE
		WHEN COUNT(order_id)=1 THEN 'One-Time Buyer'
        ELSE 'Repeat Buyer'
	END AS buyer_type,
    COUNT(*) AS customer_count
FROM orders
GROUP BY customer_id;


-- customer lifetime value (CLV)
SELECT
	customer_id,
    ROUND(AVG(order_value),2) AS avg_order_value,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(order_value),2) AS lifetime_value
FROM orders
GROUP BY customer_id;


-- View
CREATE VIEW retention_matrix AS
SELECT
	cc.cohort_month,
    cc.cohort_index,
    ROUND((cc.active_customers/cs.cohort_size)*100,2)AS retention_pct
FROM cohort_counts cc
JOIN cohort_sizes cs
	ON cc.cohort_month=cs.cohort_month;
    
    
    select * from retention_matrix;
    
    
    SELECT user, host, plugin
FROM mysql.user;

ALTER USER 'root'@'localhost'
IDENTIFIED WITH mysql_native_password
BY 'Roshan@2003';

FLUSH PRIVILEGES;

SHOW DATABASES;
