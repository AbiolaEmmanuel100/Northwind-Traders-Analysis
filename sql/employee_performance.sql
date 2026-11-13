-- Employee Sales Performance
SELECT 
    e.first_name,
    e.last_name,
    ROUND(SUM(od.quantity * od.unit_price)) AS total_revenue
FROM employee e
LEFT JOIN "order" o ON e.employee_id = o.employee_id
LEFT JOIN order_detail od ON o.order_id = od.order_id
GROUP BY e.first_name, e.last_name
ORDER BY total_revenue DESC;
