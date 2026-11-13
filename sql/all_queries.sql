-- ============================================================
-- Northwind Traders - Complete SQL Analysis Queries
-- ============================================================

-- 1. Top 10 Customers by Revenue
SELECT 
    c.company_name,
    SUM(od.quantity * od.unit_price) AS revenue
FROM "order" o
JOIN customer c ON o.customer_id = c.customer_id
JOIN order_detail od ON o.order_id = od.order_id
GROUP BY c.company_name
ORDER BY revenue DESC
LIMIT 10;

-- 2. Top Products by Revenue
SELECT 
    p.product_name, 
    SUM(od.unit_price * od.quantity) AS total_revenue
FROM order_detail od
RIGHT JOIN product p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 20;

-- 3. Underperforming Products (lowest revenue)
SELECT 
    p.product_name, 
    SUM(od.unit_price * od.quantity) AS total_revenue
FROM order_detail od
RIGHT JOIN product p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue ASC
LIMIT 30;

-- 4. Revenue by Category and Product
SELECT 
    c.category_name, 
    p.product_name, 
    SUM(od.quantity * od.unit_price) AS total_revenue 
FROM category c
LEFT JOIN product p ON p.category_id = c.category_id
LEFT JOIN order_detail od ON od.product_id = p.product_id
GROUP BY c.category_name, p.product_name
ORDER BY total_revenue DESC;

-- 5. Employee Performance
SELECT 
    e.first_name, 
    e.last_name, 
    ROUND(SUM(od.quantity * od.unit_price)) AS total_revenue 
FROM employee e
LEFT JOIN "order" o ON e.employee_id = o.employee_id
LEFT JOIN order_detail od ON o.order_id = od.order_id
GROUP BY e.first_name, e.last_name
ORDER BY total_revenue DESC;

-- 6. Order Patterns (Order count, total revenue, average order value)
SELECT 
    c.company_name, 
    COUNT(DISTINCT o.order_id) AS order_count, 
    SUM(od.quantity * od.unit_price) AS total_revenue,
    ROUND(SUM(od.quantity * od.unit_price) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM customer c
INNER JOIN "order" o ON c.customer_id = o.customer_id
LEFT JOIN order_detail od ON o.order_id = od.order_id
GROUP BY c.company_name
ORDER BY avg_order_value DESC;

-- 7. Monthly Sales Trend
SELECT 
    TO_CHAR(o.order_date::date, 'YYYY-MM') AS month,
    SUM(od.quantity * od.unit_price) AS total_revenue
FROM "order" o
LEFT JOIN order_detail od ON o.order_id = od.order_id
GROUP BY TO_CHAR(o.order_date::date, 'YYYY-MM')
ORDER BY month;

-- 8. Customers with no orders
SELECT c.customer_id, c.company_name
FROM customer c
LEFT JOIN "order" o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 9. Category + Product summary with average unit price
SELECT 
    c.category_name,
    p.product_name,
    SUM(od.quantity) AS total_quantity,
    ROUND(SUM(od.quantity * od.unit_price), 2) AS revenue,
    ROUND(AVG(od.unit_price), 2) AS avg_unit_price
FROM product p
RIGHT JOIN category c ON p.category_id = c.category_id
LEFT JOIN order_detail od ON p.product_id = od.product_id
GROUP BY c.category_name, p.product_name
ORDER BY revenue DESC;
