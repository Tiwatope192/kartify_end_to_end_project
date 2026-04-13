CREATE TABLE IF NOT EXISTS DATABASE3.SILVER.COUPONS AS
SELECT
    "id",
    "code",
    "discount_pct",
    "max_uses",
    "used_count",
    ("max_uses" - "used_count")                                      AS Remaining_uses,  -- new calculated column
    ROUND(("used_count" / "max_uses") * 100, 2)                      AS Usage_pct,       -- new calculated column
    CASE 
        WHEN "used_count" >= "max_uses" THEN 'Exhausted' 
        ELSE 'Available' 
    END                                                          AS Code_status,     -- new calculated column
    "is_active",
    COALESCE(TO_VARCHAR(TO_TIMESTAMP("expires_at" / 1000000000)), 'No Expiry') AS Expires_at,     -- transformed column
    TO_TIMESTAMP("created_at" / 1000000000)                        AS Created_date,   -- transformed column
    TO_TIMESTAMP("updated_at" / 1000000000)                        AS Updated_date    -- transformed column
FROM DATABASE3.BRONZE."coupons";

--inserting into silver_layer

INSERT INTO DATABASE3.SILVER.COUPONS
SELECT
    "id"                                                              AS Id,
    "code"                                                            AS Code,
    "discount_pct"                                                    AS Discount_pct,
    "max_uses"                                                        AS Max_uses,
    "used_count"                                                      AS Used_count,
    ("max_uses" - "used_count")                                       AS Remaining_uses,
    ROUND(("used_count" / "max_uses") * 100, 2)                       AS Usage_pct,
    CASE 
        WHEN "used_count" >= "max_uses" THEN 'Exhausted' 
        ELSE 'Available' 
    END                                                               AS Code_status,
    "is_active"                                                       AS Is_active,
    COALESCE(TO_VARCHAR(TO_TIMESTAMP("expires_at" / 1000000000)), 'No Expiry') AS Expires_at,
    TO_TIMESTAMP("created_at" / 1000000000)                           AS Created_date,
    TO_TIMESTAMP("updated_at" / 1000000000)                           AS Updated_date
FROM DATABASE3.BRONZE."coupons";

select * from DATABASE3.SILVER.COUPONS;

