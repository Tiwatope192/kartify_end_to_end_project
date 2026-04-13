CREATE TABLE DATABASE3.SILVER.reviews AS
SELECT
    "id",
    "product_id",
    "customer_id",
    "rating",
    CASE
        WHEN "rating" = 5 THEN 'Excellent'
        WHEN "rating" = 4 THEN 'Good'
        WHEN "rating" = 3 THEN 'Average'
        WHEN "rating" = 2 THEN 'Poor'
        WHEN "rating" = 1 THEN 'Very Poor'
    END                                                         AS Rating_label,
    CASE
        WHEN "rating" >= 4 THEN 'Positive'
        WHEN "rating" = 3  THEN 'Neutral'
        ELSE 'Negative'
    END                                                         AS Sentiment,
    COALESCE("comment", 'No Comment')                           AS Comment,
    TO_TIMESTAMP("created_at" / 1000000000)                     AS Created_date,
    TO_TIMESTAMP("updated_at" / 1000000000)                     AS Updated_date
FROM DATABASE3.BRONZE."reviews";


INSERT INTO DATABASE3.SILVER.REVIEWS
SELECT
    "id",
    "product_id",
    "customer_id",
    "rating",
    CASE
        WHEN "rating" = 5 THEN 'Excellent'
        WHEN "rating" = 4 THEN 'Good'
        WHEN "rating" = 3 THEN 'Average'
        WHEN "rating" = 2 THEN 'Poor'
        WHEN "rating" = 1 THEN 'Very Poor'
    END                                                         AS Rating_label,
    CASE
        WHEN "rating" >= 4 THEN 'Positive'
        WHEN "rating" = 3  THEN 'Neutral'
        ELSE 'Negative'
    END                                                         AS Sentiment,
    COALESCE("comment", 'No Comment')                           AS Comment,
    TO_TIMESTAMP("created_at" / 1000000000)                     AS Created_date,
    TO_TIMESTAMP("updated_at" / 1000000000)                     AS Updated_date
FROM DATABASE3.BRONZE."reviews";
SELECT * FROM DATABASE3.SILVER.REVIEWS;

SELECT * FROM DATABASE3.SILVER.REVIEWS;