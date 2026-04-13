
  CREATE TABLE IF NOT EXISTS DATABASE3.SILVER.INVENTORY AS
    SELECT 
  "id",
    "product_id",
    "quantity",
    "reorder_lvl",
    ("quantity" - "reorder_lvl")                AS Stock_surplus,       -- how much stock is above reorder level
    CASE
        WHEN "quantity" <= "reorder_lvl"         THEN 'Reorder Now'     -- at or below reorder level
        WHEN "quantity" <= "reorder_lvl" * 1.5   THEN 'Running Low'     -- within 50% of reorder level
        ELSE 'In Stock'                                                  -- sufficient stock
    END                                         AS Stock_status,
    TO_TIMESTAMP("created_at" / 1000000000) AS created_date,
    TO_TIMESTAMP("updated_at" / 1000000000) AS updated_date
    FROM DATABASE3.BRONZE."inventory";



INSERT INTO  DATABASE3.SILVER.INVENTORY
 SELECT 
  "id",
    "product_id",
    "quantity",
    "reorder_lvl",
    ("quantity" - "reorder_lvl")                AS Stock_surplus,       -- how much stock is above reorder level
    CASE
        WHEN "quantity" <= "reorder_lvl"         THEN 'Reorder Now'     -- at or below reorder level
        WHEN "quantity" <= "reorder_lvl" * 1.5   THEN 'Running Low'     -- within 50% of reorder level
        ELSE 'In Stock'                                                  -- sufficient stock
    END                                         AS Stock_status,
    TO_TIMESTAMP("created_at" / 1000000000) AS created_date,
    TO_TIMESTAMP("updated_at" / 1000000000) AS updated_date
    FROM DATABASE3.BRONZE."inventory";

    SELECT * FROM DATABASE3.SILVER.INVENTORY;



