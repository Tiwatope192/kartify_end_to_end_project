
CREATE OR REPLACE TABLE DATABASE3.SILVER.orders AS
SELECT
    "id" AS id,
    "customer_id" AS customer_id,
    COALESCE(CAST("coupon_id" AS VARCHAR), 'No Coupon') AS coupon_id,
    INITCAP("status") AS status,
    "subtotal" AS subtotal,
    "discount_amount" AS discount_amount,
    "total" AS total,
    CASE
        WHEN "discount_amount" > 0 THEN 'Discounted'
        ELSE 'Full Price'
    END AS discount_flag,
    ROUND(("discount_amount" / NULLIF("subtotal", 0)) * 100, 2) AS discount_pct,
    COALESCE("notes", 'No Notes') AS notes
FROM DATABASE3.BRONZE."orders";

SELECT * FROM DATABASE3.SILVER.orders;