
CREATE TABLE DATABASE3.SILVER.payments AS
SELECT
    "id",
    "order_id",
    INITCAP("method")                                           AS Method,
    INITCAP("status")                                           AS Status,
    ROUND("amount", 2)                                          AS Amount,
    '₦' || TO_CHAR(ROUND("amount", 2), '999,999,990.00')       AS Amount_display,
    CASE
        WHEN "status" = 'failed' THEN 'Failed'
        ELSE 'Successful'
    END                                                         AS Payment_flag,
    LEFT("reference", 8)                                        AS Short_reference,
    "reference"                                                 AS Full_reference,
    TO_TIMESTAMP("created_at" / 1000000000)                     AS Created_date,    -- fixed
    TO_TIMESTAMP("updated_at" / 1000000000)                     AS Updated_date     -- fixed
FROM DATABASE3.BRONZE."payments";
FROM DATABASE3.BRONZE."payments";


INSERT INTO  DATABASE3.SILVER.payments 
SELECT
    "id",
    "order_id",
    INITCAP("method")                                           AS Method,
    INITCAP("status")                                           AS Status,
    ROUND("amount", 2)                                          AS Amount,
    '₦' || TO_CHAR(ROUND("amount", 2), '999,999,990.00')       AS Amount_display,
    CASE
        WHEN "status" = 'failed' THEN 'Failed'
        ELSE 'Successful'
    END                                                         AS Payment_flag,
    LEFT("reference", 8)                                        AS Short_reference,
    "reference"                                                 AS Full_reference,
    TO_TIMESTAMP("created_at" / 1000000000)                     AS Created_date,    -- fixed
    TO_TIMESTAMP("updated_at" / 1000000000)                     AS Updated_date     -- fixed
FROM DATABASE3.BRONZE."payments";


SELECT * FROM DATABASE3.SILVER.PAYMENTS;
