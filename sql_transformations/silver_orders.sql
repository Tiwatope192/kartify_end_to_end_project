
CREATE TABLE DATABASE3.SILVER.orders AS
SELECT
    "id",
    "customer_id",
    COALESCE(CAST("coupon_id" AS VARCHAR), 'No Coupon')     AS Coupon_id,       -- handle null coupon ids
    INITCAP("status")                                        AS Status,          -- capitalise status
    "subtotal",
    "discount_amount",
    "total",
    CASE
        WHEN "discount_amount" > 0 THEN 'Discounted'
        ELSE 'Full Price'
    END                                                      AS Discount_flag,   -- flag discounted orders
    ROUND(("discount_amount" / "subtotal") * 100, 2)         AS Discount_pct,   -- discount percentage
    COALESCE("notes", 'No Notes')                            AS Notes            -- handle null notes
FROM DATABASE3.BRONZE."orders";

INSERT INTO DATABASE3.SILVER.orders
SELECT
    "id",
    "customer_id",
    COALESCE(CAST("coupon_id" AS VARCHAR), 'No Coupon')     AS Coupon_id,       -- handle null coupon ids
    INITCAP("status")                                        AS Status,          -- capitalise status
    "subtotal",
    "discount_amount",
    "total",
    CASE
        WHEN "discount_amount" > 0 THEN 'Discounted'
        ELSE 'Full Price'
    END                                                      AS Discount_flag,   -- flag discounted orders
    ROUND(("discount_amount" / "subtotal") * 100, 2)         AS Discount_pct,   -- discount percentage
    COALESCE("notes", 'No Notes')                            AS Notes            -- handle null notes
FROM DATABASE3.BRONZE."orders";    


SELECT * FROM DATABASE3.SILVER.ORDERS;