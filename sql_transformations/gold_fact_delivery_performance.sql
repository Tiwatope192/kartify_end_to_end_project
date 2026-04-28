--Operations/logistics insight

CREATE OR REPLACE TABLE GOLD.fact_delivery_performance AS
SELECT
    Status,
    COUNT(*)                              AS total_orders,
    AVG(Delivery_days)                    AS avg_delivery_time
FROM SILVER.shipping
GROUP BY Status;

SELECT * FROM GOLD.fact_delivery_performance;