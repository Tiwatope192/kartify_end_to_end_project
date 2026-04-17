
CREATE OR REPLACE TABLE DATABASE3.SILVER.reviews AS
SELECT
    "id" AS id,
    "product_id" AS product_id,
    "customer_id" AS customer_id,
    "rating" AS rating,

    CASE
        WHEN "rating" = 5 THEN 'Excellent'
        WHEN "rating" = 4 THEN 'Good'
        WHEN "rating" = 3 THEN 'Average'
        WHEN "rating" = 2 THEN 'Poor'
        WHEN "rating" = 1 THEN 'Very Poor'
        ELSE 'Unknown'
    END AS rating_label,

    CASE
        WHEN "rating" >= 4 THEN 'Positive'
        WHEN "rating" = 3 THEN 'Neutral'
        WHEN "rating" < 3 THEN 'Negative'
        ELSE 'Unknown'
    END AS sentiment,

    COALESCE("comment", 'No Comment') AS comment,

    TO_TIMESTAMP("created_at" / 1000000000) AS created_date,
    TO_TIMESTAMP("updated_at" / 1000000000) AS updated_date

FROM DATABASE3.BRONZE."reviews";

SELECT * FROM DATABASE3.SILVER.reviews;