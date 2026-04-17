
CREATE OR REPLACE TABLE DATABASE3.SILVER.customers AS
WITH base AS (
    SELECT
        "id",
        INITCAP("first_name") AS first_name,
        INITCAP("last_name") AS last_name,
        "email",
        "phone" AS original_phone,
        "address",
        "city",
        "state",
        "postal_code",
        "country",
        "created_at",
        "updated_at"
    FROM DATABASE3.BRONZE."customers"
),
cleaned AS (
    SELECT
        "id",
        first_name,
        last_name,
        "email",
        original_phone,

        CASE
            WHEN original_phone IS NULL THEN 'No Phone'
            WHEN LENGTH(REGEXP_REPLACE(original_phone, '[^0-9]', '')) < 10 THEN 'Invalid Phone'
            WHEN REGEXP_REPLACE(original_phone, '[^0-9]', '') LIKE '234%'
                 AND LENGTH(REGEXP_REPLACE(original_phone, '[^0-9]', '')) = 13
                THEN '+' || REGEXP_REPLACE(original_phone, '[^0-9]', '')
            WHEN REGEXP_REPLACE(original_phone, '[^0-9]', '') LIKE '234%'
                 AND LENGTH(REGEXP_REPLACE(original_phone, '[^0-9]', '')) > 13
                THEN '+234' || RIGHT(REGEXP_REPLACE(original_phone, '[^0-9]', ''), 10)
            WHEN REGEXP_REPLACE(original_phone, '[^0-9]', '') LIKE '0%'
                 AND LENGTH(REGEXP_REPLACE(original_phone, '[^0-9]', '')) >= 11
                THEN '+234' || SUBSTR(REGEXP_REPLACE(original_phone, '[^0-9]', ''), 2, 10)
            ELSE 'Invalid Phone'
        END AS cleaned_phone,

        CASE
            WHEN "address" IS NULL THEN 'No Address'
            WHEN "address" IN ('75015', '75016') THEN 'Unknown'
            ELSE "address"
        END AS address,

        CASE
            WHEN "city" IS NULL THEN 'Unknown'
            WHEN INITCAP("city") = 'Logos' THEN 'Lagos'
            WHEN INITCAP("city") NOT IN ('Lagos', 'Kano', 'Abuja', 'Ibadan', 'Port Harcourt', 'Enugu')
                THEN 'Unknown'
            ELSE INITCAP("city")
        END AS city,

        "state",
        "postal_code",
        "country",
        "created_at",
        "updated_at"
    FROM base
)
SELECT
    "id",
    first_name,
    last_name,
    "email",
    original_phone,
    cleaned_phone,
    address,
    city,
    CASE
        WHEN LOWER("state") IN ('paris', 'lugbe') THEN 'Unknown'
        WHEN LOWER("state") = 'fct' THEN 'FCT'
        WHEN INITCAP("state") = 'Logos' THEN 'Lagos'
        WHEN "state" IS NULL THEN
            CASE
                WHEN city = 'Abuja' THEN 'FCT'
                WHEN city IN ('Lagos', 'Kano', 'Ibadan', 'Port Harcourt', 'Enugu') THEN city
                ELSE 'Unknown'
            END
        ELSE INITCAP("state")
    END AS state,
    CASE
        WHEN "postal_code" IN ('75015', '75016') THEN 'Unknown'
        WHEN city = 'Lagos' THEN '100001'
        WHEN city = 'Kano' THEN '700001'
        WHEN city = 'Abuja' THEN '900001'
        WHEN city = 'Ibadan' THEN '200001'
        WHEN city = 'Port Harcourt' THEN '500001'
        WHEN city = 'Enugu' THEN '400001'
        ELSE COALESCE("postal_code", 'Unknown')
    END AS postal_code,
    CASE
        WHEN LOWER("country") = 'france' THEN 'Unknown'
        ELSE INITCAP("country")
    END AS country,
    TO_TIMESTAMP("created_at" / 1000000000) AS created_date,
    TO_TIMESTAMP("updated_at" / 1000000000) AS updated_date
FROM cleaned;