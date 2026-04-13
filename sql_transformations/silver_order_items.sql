CREATE TABLE DATABASE3.SILVER.order_items AS
SELECT
    "id",
    "order_id",
    "product_id",
    "quantity",
    ROUND("unit_price", 2)                                          AS Unit_price,
    ROUND("total_price", 2)                                         AS Total_price,
    '₦' || TO_CHAR(ROUND("unit_price", 2), '999,999,990.00')       AS Unit_price_display,      -- naira sign for display
    '₦' || TO_CHAR(ROUND("total_price", 2), '999,999,990.00')      AS Total_price_display,     -- naira sign for display
    CASE
        WHEN "total_price" = "quantity" * "unit_price" THEN 'Correct'
        ELSE 'Mismatch'
    END                                                             AS Price_check,             -- verify total price
    CASE
        WHEN "quantity" = 1 THEN 'Single Item'
        WHEN "quantity" <= 3 THEN 'Small Order'
        ELSE 'Bulk Order'
    END                                                             AS Order_size,              -- flag order size
    TO_TIMESTAMP("created_at" / 1000000000)                         AS Created_date,            -- nanoseconds to readable date
    TO_TIMESTAMP("updated_at" / 1000000000)                         AS Updated_date             -- nanoseconds to readable date
FROM DATABASE3.BRONZE."order_items";



INSERT INTO DATABASE3.SILVER.ORDER_ITEMS
SELECT
    "id",
    "order_id",
    "product_id",
    "quantity",
    ROUND("unit_price", 2)                                          AS Unit_price,
    ROUND("total_price", 2)                                         AS Total_price,
    '₦' || TO_CHAR(ROUND("unit_price", 2), '999,999,990.00')       AS Unit_price_display,      -- naira sign for display
    '₦' || TO_CHAR(ROUND("total_price", 2), '999,999,990.00')      AS Total_price_display,     -- naira sign for display
    CASE
        WHEN "total_price" = "quantity" * "unit_price" THEN 'Correct'
        ELSE 'Mismatch'
    END                                                             AS Price_check,             -- verify total price
    CASE
        WHEN "quantity" = 1 THEN 'Single Item'
        WHEN "quantity" <= 3 THEN 'Small Order'
        ELSE 'Bulk Order'
    END                                                             AS Order_size,              -- flag order size
    TO_TIMESTAMP("created_at" / 1000000000)                         AS Created_date,            -- nanoseconds to readable date
    TO_TIMESTAMP("updated_at" / 1000000000)                         AS Updated_date             -- nanoseconds to readable date
FROM DATABASE3.BRONZE."order_items";

SELECT * FROM DATABASE3.SILVER.ORDER_ITEMS;
