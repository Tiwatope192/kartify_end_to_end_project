--inventory monitoring

CREATE OR REPLACE TABLE GOLD.fact_inventory_status AS
SELECT
    Stock_status,
    COUNT(*)                              AS product_count
FROM SILVER.inventory
GROUP BY Stock_status;

SELECT * FROM GOLD.fact_inventory_status;