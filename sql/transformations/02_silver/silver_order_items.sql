
CREATE OR REPLACE TABLE DATABASE3.SILVER.order_items AS
SELECT
    "id" AS id,
    "order_id" AS order_id,
    "product_id" AS product_id,
    "quantity" AS quantity,

    ROUND("unit_price", 2) AS unit_price,
    ROUND("total_price", 2) AS total_price,

    CASE
        WHEN ROUND("total_price", 2) = ROUND("quantity" * "unit_price", 2) THEN 'Correct'
        ELSE 'Mismatch'
    END AS price_check,

    CASE
        WHEN "quantity" = 1 THEN 'Single Item'
        WHEN "quantity" <= 3 THEN 'Small Order'
        ELSE 'Bulk Order'
    END AS order_size,

    TO_TIMESTAMP("created_at" / 1000000000) AS created_date,
    TO_TIMESTAMP("updated_at" / 1000000000) AS updated_date

FROM DATABASE3.BRONZE."order_items";

SELECT * FROM DATABASE3.SILVER.order_items;