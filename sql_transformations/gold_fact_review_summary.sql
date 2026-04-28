--customer sentiment

CREATE OR REPLACE TABLE GOLD.fact_review_summary AS
SELECT
    Sentiment,
    COUNT(*)                              AS review_count,
    AVG(rating)                           AS avg_rating
FROM SILVER.reviews
GROUP BY Sentiment;

SELECT * FROM GOLD.fact_review_summary;