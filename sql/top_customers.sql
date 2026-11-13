-- Top 10 Customers by Revenue
SELECT 
    c.company_name,
    SUM(od.quantity * od.unit_price) AS revenue
FROM "order" o
JOIN customer c ON o.customer_id = c.customer_id
JOIN order_detail od ON o.order_id = od.order_id
GROUP BY c.company_name
ORDER BY revenue DESC
LIMIT 10;
