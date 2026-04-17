
CREATE OR REPLACE TABLE DATABASE3.SILVER.shipping AS
WITH base AS (
    SELECT * 
    FROM DATABASE3.BRONZE."shipping"
),
cleaned AS (
    SELECT
        "id" AS id,
        "order_id" AS order_id,

        CASE
            WHEN "status" = 'not_shipped' THEN 'Not Shipped'
            WHEN "status" = 'in_transit' THEN 'In Transit'
            WHEN "status" = 'delivered' THEN 'Delivered'
            ELSE INITCAP("status")
        END AS status,

        COALESCE("carrier", 'No Carrier') AS carrier,
        COALESCE("tracking_number", 'No Tracking Number') AS tracking_number,

        CASE
            WHEN "address" IS NULL THEN 'No Address'
            WHEN "address" IN ('75015', '75016') THEN 'Unknown'
            WHEN LOWER("address") LIKE '%paris%' THEN 'Unknown'
            WHEN LOWER("address") LIKE '%rue robert%' THEN 'Unknown'
            ELSE "address"
        END AS address,

        CASE
            WHEN "city" IS NULL THEN 'Unknown'
            WHEN INITCAP("city") IN ('Paris', 'Bercy') THEN 'Unknown'
            WHEN INITCAP("city") IN ('Lagos', 'Iagos', 'Logos') THEN 'Lagos'
            WHEN INITCAP("city") NOT IN ('Lagos', 'Kano', 'Abuja', 'Ibadan', 'Port Harcourt', 'Enugu')
                THEN 'Unknown'
            ELSE INITCAP("city")
        END AS city,

        "state",
        "country",
        "postal_code",
        "shipped_at",
        "delivered_at",
        "created_at",
        "updated_at"
    FROM base
)
SELECT
    id,
    order_id,
    status,
    carrier,
    tracking_number,
    address,
    city,

    CASE
        WHEN LOWER("state") IN ('paris', 'lugbe') THEN 'Unknown'
        WHEN LOWER("state") = 'fct' THEN 'FCT'
        WHEN city = 'Abuja' THEN 'FCT'
        WHEN city = 'Unknown' THEN 'Unknown'
        WHEN city = 'Lagos' THEN 'Lagos'
        WHEN "state" IS NULL THEN city
        ELSE INITCAP("state")
    END AS state,

    CASE
        WHEN LOWER("country") = 'france' THEN 'Unknown'
        ELSE INITCAP("country")
    END AS country,

    CASE
        WHEN "postal_code" IN ('75015', '75016') THEN 'Unknown'
        WHEN "postal_code" = '10001' THEN '100001'
        WHEN city = 'Lagos' THEN '100001'
        WHEN city = 'Kano' THEN '700001'
        WHEN city = 'Abuja' THEN '900001'
        WHEN city = 'Ibadan' THEN '200001'
        WHEN city = 'Port Harcourt' THEN '500001'
        WHEN city = 'Enugu' THEN '400001'
        ELSE COALESCE("postal_code", 'Unknown')
    END AS postal_code,

    TO_TIMESTAMP("shipped_at" / 1000000000) AS shipped_at,
    TO_TIMESTAMP("delivered_at" / 1000000000) AS delivered_at,

    CASE
        WHEN "shipped_at" IS NULL THEN 'Not Shipped Yet'
        WHEN "delivered_at" IS NULL THEN 'In Transit'
        ELSE 'Delivered'
    END AS delivery_stage,

    DATEDIFF(
        'day',
        TO_TIMESTAMP("shipped_at" / 1000000000),
        TO_TIMESTAMP("delivered_at" / 1000000000)
    ) AS delivery_days,

    TO_TIMESTAMP("created_at" / 1000000000) AS created_date,
    TO_TIMESTAMP("updated_at" / 1000000000) AS updated_date

FROM cleaned;






SELECT * FROM  DATABASE3.SILVER.SHIPPING;