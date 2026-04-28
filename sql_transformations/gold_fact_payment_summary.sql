--Finance needs payment success tracking

CREATE OR REPLACE TABLE GOLD.fact_payment_summary AS
SELECT
    DATE(created_date)                    AS payment_date,
    COUNT(*)                              AS total_transactions,
    SUM(amount)                           AS total_amount,
    SUM(CASE WHEN payment_flag = 'Successful' THEN amount ELSE 0 END) AS successful_amount,
    SUM(CASE WHEN payment_flag = 'Failed' THEN amount ELSE 0 END)     AS failed_amount
FROM SILVER.payments
GROUP BY payment_date;

SELECT * FROM DATABASE3.GOLD.fact_payment_summary;