
CREATE OR REPLACE TABLE DATABASE3.SILVER.inventory AS
SELECT
    "id" AS id,
    "product_id" AS product_id,
    "quantity" AS quantity,
    "reorder_lvl" AS reorder_lvl,

    ("quantity" - "reorder_lvl") AS stock_surplus,

    CASE
        WHEN "quantity" <= "reorder_lvl" THEN 'Reorder Now'
        WHEN "quantity" <= "reorder_lvl" * 1.5 THEN 'Running Low'
        ELSE 'In Stock'
    END AS stock_status,

    TO_TIMESTAMP("created_at" / 1000000000) AS created_date,
    TO_TIMESTAMP("updated_at" / 1000000000) AS updated_date

FROM DATABASE3.BRONZE."inventory";



    SELECT * FROM DATABASE3.SILVER.INVENTORY;



