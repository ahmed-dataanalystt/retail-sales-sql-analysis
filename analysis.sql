-- ============================================================
-- Retail Sales Analysis | 10 Business Questions (SQL Server)
-- Revenue = quantity * price (EGP)
-- ============================================================

USE RetailSalesDB;
GO

-- ------------------------------------------------------------
-- Q1. What is the total revenue?
-- ------------------------------------------------------------
SELECT
    SUM(o.quantity * p.price) AS total_revenue,
    COUNT(o.order_id)         AS total_orders
FROM orders o
JOIN products p ON o.product_id = p.product_id;


-- ------------------------------------------------------------
-- Q2. How many orders were placed each month?
-- ------------------------------------------------------------
SELECT
    YEAR(order_date)  AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(order_id)   AS orders_count
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;


-- ------------------------------------------------------------
-- Q3. What are the top 5 best-selling products by quantity?
-- ------------------------------------------------------------
SELECT TOP 5
    p.product_name,
    SUM(o.quantity) AS units_sold
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY units_sold DESC;


-- ------------------------------------------------------------
-- Q4. Which category brings in the most revenue?
-- ------------------------------------------------------------
SELECT
    p.category,
    SUM(o.quantity * p.price) AS category_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;


-- ------------------------------------------------------------
-- Q5. Which city has the most customers?
-- ------------------------------------------------------------
SELECT
    city,
    COUNT(customer_id) AS customers_count
FROM customers
GROUP BY city
ORDER BY customers_count DESC;


-- ------------------------------------------------------------
-- Q6. Who are the top 10 customers by total spending?
-- ------------------------------------------------------------
SELECT TOP 10
    c.customer_id,
    c.customer_name,
    c.city,
    SUM(o.quantity * p.price) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products  p ON o.product_id  = p.product_id
GROUP BY c.customer_id, c.customer_name, c.city
ORDER BY total_spent DESC;


-- ------------------------------------------------------------
-- Q7. What is the average order value?
-- ------------------------------------------------------------
SELECT
    CAST(SUM(o.quantity * p.price) / COUNT(o.order_id) AS DECIMAL(10,2)) AS avg_order_value
FROM orders o
JOIN products p ON o.product_id = p.product_id;


-- ------------------------------------------------------------
-- Q8. Which products have never been ordered?
-- ------------------------------------------------------------
SELECT
    p.product_id,
    p.product_name,
    p.category
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
WHERE o.order_id IS NULL;


-- ------------------------------------------------------------
-- Q9. How do sales compare between weekdays and weekends?
--     (Weekend in Egypt = Friday and Saturday)
-- ------------------------------------------------------------
SELECT
    CASE
        WHEN DATENAME(WEEKDAY, o.order_date) IN ('Friday', 'Saturday') THEN 'Weekend'
        ELSE 'Weekday'
    END                        AS day_type,
    COUNT(o.order_id)          AS orders_count,
    SUM(o.quantity * p.price)  AS revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY
    CASE
        WHEN DATENAME(WEEKDAY, o.order_date) IN ('Friday', 'Saturday') THEN 'Weekend'
        ELSE 'Weekday'
    END;


-- ------------------------------------------------------------
-- Q10. How many customers fall into each spending segment?
--      High   : 45,000 EGP or more
--      Medium : 25,000 – 44,999 EGP
--      Low    : under 25,000 EGP
-- ------------------------------------------------------------
SELECT
    segment,
    COUNT(customer_id) AS customers_count
FROM (
    SELECT
        o.customer_id,
        CASE
            WHEN SUM(o.quantity * p.price) >= 45000 THEN 'High'
            WHEN SUM(o.quantity * p.price) >= 25000 THEN 'Medium'
            ELSE 'Low'
        END AS segment
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
    GROUP BY o.customer_id
) AS customer_segments
GROUP BY segment
ORDER BY customers_count DESC;
