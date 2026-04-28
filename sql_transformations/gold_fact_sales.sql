--Orders = revenue → core business metric

CREATE OR REPLACE TABLE GOLD.fact_sales_summary AS
SELECT
    DATE(p.created_date)                  AS order_date,
    COUNT(*)                              AS total_orders,
    SUM(o.total)                          AS total_revenue,
    SUM(o.discount_amount)               AS total_discount,
    AVG(o.total)                          AS avg_order_value
FROM SILVER.orders o
JOIN SILVER.payments p ON p.order_id = o.id
GROUP BY order_date;

SELECT * FROM DATABASE3.GOLD.fact_sales_summary;