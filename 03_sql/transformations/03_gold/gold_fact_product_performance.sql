--Product performance = quantity + revenue

CREATE OR REPLACE TABLE GOLD.fact_product_performance AS
SELECT
    p.id                                  AS product_id,
    p.name,
    SUM(oi.quantity)                      AS total_units_sold,
    SUM(oi.total_price)                   AS total_revenue,
    AVG(oi.unit_price)                    AS avg_price
FROM SILVER.order_items oi
JOIN SILVER.products p
    ON oi.product_id = p.id
GROUP BY p.id, p.name;

SELECT * FROM DATABASE3.GOLD.fact_product_performance;