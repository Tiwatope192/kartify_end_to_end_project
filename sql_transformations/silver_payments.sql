


CREATE OR REPLACE TABLE DATABASE3.SILVER.payments AS
SELECT
    "id" AS id,
    "order_id" AS order_id,
    INITCAP("method") AS method,
    INITCAP("status") AS status,
    ROUND("amount", 2) AS amount,

    CASE
        WHEN LOWER("status") = 'failed' THEN 'Failed'
        ELSE 'Successful'
    END AS payment_flag,

    LEFT("reference", 8) AS short_reference,
    "reference" AS full_reference,

    TO_TIMESTAMP("created_at" / 1000000000) AS created_date,
    TO_TIMESTAMP("updated_at" / 1000000000) AS updated_date

FROM DATABASE3.BRONZE."payments";