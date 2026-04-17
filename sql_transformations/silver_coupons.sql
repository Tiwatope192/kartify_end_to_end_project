CREATE OR REPLACE TABLE DATABASE3.SILVER.COUPONS AS
SELECT
    "id" AS id,
    "code" AS code,
    "discount_pct",
    "max_uses",
    "used_count",

    ("max_uses" - "used_count") AS remaining_uses,

    ROUND(("used_count" / NULLIF("max_uses", 0)) * 100, 2) AS usage_pct,

    CASE 
        WHEN "used_count" >= "max_uses" THEN 'Exhausted' 
        ELSE 'Available' 
    END AS code_status,

    "is_active",

    TO_TIMESTAMP("expires_at" / 1000000000) AS expires_at,
    TO_TIMESTAMP("created_at" / 1000000000) AS created_date,
    TO_TIMESTAMP("updated_at" / 1000000000) AS updated_date

FROM DATABASE3.BRONZE."coupons";

select * from DATABASE3.SILVER.COUPONS;































 






































select * from DATABASE3.SILVER.COUPONS;

