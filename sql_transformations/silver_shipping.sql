CREATE OR REPLACE TABLE DATABASE3.SILVER.shipping AS
SELECT
    "id",
    "order_id",
    CASE
        WHEN "status" = 'not_shipped'  THEN 'Not Shipped'
        WHEN "status" = 'in_transit'   THEN 'In Transit'
        WHEN "status" = 'delivered'    THEN 'Delivered'
        ELSE INITCAP("status")
    END                                                             AS Status,
    COALESCE("carrier", 'No Carrier')                               AS Carrier,
    COALESCE("tracking_number", 'No Tracking Number')               AS Tracking_number,
    CASE
        WHEN "address" IS NULL                      THEN 'No Address'
        WHEN "address" IN ('75015', '75016')        THEN 'Unknown'
        WHEN "address" LIKE '%paris%'               THEN 'Unknown'
        WHEN "address" LIKE '%Rue Robert%'          THEN 'Unknown'
        ELSE "address"
    END                                                             AS Address,
    CASE
        WHEN "city" IS NULL                                         THEN 'Unknown'
        WHEN INITCAP("city") IN ('Paris', 'Bercy')                  THEN 'Unknown'
        WHEN INITCAP("city") IN ('Lagos', 'Iagos', 'Logos')         THEN 'Lagos'
        WHEN INITCAP("city") NOT IN ('Lagos', 'Kano', 'Abuja', 'Ibadan', 'Port Harcourt', 'Enugu')
                                                                    THEN 'Unknown'
        ELSE INITCAP("city")
    END                                                             AS City,
    CASE
        WHEN LOWER("state") IN ('paris', 'lugbe')                   THEN 'Unknown'
        WHEN LOWER("state") = 'fct'                                 THEN 'FCT'
        WHEN INITCAP("city") = 'Abuja'                              THEN 'FCT'
        WHEN INITCAP("city") IN ('Paris', 'Bercy')                  THEN 'Unknown'
        WHEN INITCAP("city") IN ('Lagos', 'Iagos', 'Logos')         THEN 'Lagos'
        WHEN "state" IS NULL
            THEN
                CASE
                    WHEN "city" IS NULL                             THEN 'Unknown'
                    WHEN INITCAP("city") NOT IN ('Lagos', 'Kano', 'Abuja', 'Ibadan', 'Port Harcourt', 'Enugu')
                                                                    THEN 'Unknown'
                    ELSE INITCAP("city")
                END
        ELSE INITCAP("state")
    END                                                             AS State,
    CASE
        WHEN LOWER("country") IN ('france')         THEN 'Unknown'
        ELSE INITCAP("country")
    END                                                             AS Country,
    CASE
        WHEN "postal_code" IN ('75015', '75016')    THEN 'Unknown'
        WHEN "postal_code" = '10001'                THEN '100001'
        WHEN INITCAP("city") IN ('Lagos', 'Iagos', 'Logos') THEN '100001'
        WHEN INITCAP("city") = 'Kano'               THEN '700001'
        WHEN INITCAP("city") = 'Abuja'              THEN '900001'
        WHEN INITCAP("city") = 'Ibadan'             THEN '200001'
        WHEN INITCAP("city") = 'Port Harcourt'      THEN '500001'
        WHEN INITCAP("city") = 'Enugu'              THEN '400001'
        ELSE COALESCE("postal_code", 'Unknown')
    END                                                             AS Postal_code,
    CASE
        WHEN "shipped_at" IS NULL   THEN 'Not Shipped Yet'
        ELSE CAST(TO_TIMESTAMP("shipped_at" / 1000000000) AS VARCHAR)
    END                                                             AS Shipped_at,
    CASE
        WHEN "delivered_at" IS NULL THEN 'Not Delivered Yet'
        ELSE CAST(TO_TIMESTAMP("delivered_at" / 1000000000) AS VARCHAR)
    END                                                             AS Delivered_at,
    DATEDIFF('day',
        TO_TIMESTAMP("shipped_at" / 1000000000),
        TO_TIMESTAMP("delivered_at" / 1000000000))                  AS Delivery_days,   -- null where not delivered
    TO_TIMESTAMP("created_at" / 1000000000)                         AS Created_date,
    TO_TIMESTAMP("updated_at" / 1000000000)                         AS Updated_date
FROM DATABASE3.BRONZE."shipping";




INSERT INTO DATABASE3.SILVER.SHIPPING
SELECT
    "id",
    "order_id",
    CASE
        WHEN "status" = 'not_shipped'  THEN 'Not Shipped'
        WHEN "status" = 'in_transit'   THEN 'In Transit'
        WHEN "status" = 'delivered'    THEN 'Delivered'
        ELSE INITCAP("status")
    END                                                             AS Status,
    COALESCE("carrier", 'No Carrier')                               AS Carrier,
    COALESCE("tracking_number", 'No Tracking Number')               AS Tracking_number,
    CASE
        WHEN "address" IS NULL                      THEN 'No Address'
        WHEN "address" IN ('75015', '75016')        THEN 'Unknown'
        WHEN "address" LIKE '%paris%'               THEN 'Unknown'
        WHEN "address" LIKE '%Rue Robert%'          THEN 'Unknown'
        ELSE "address"
    END                                                             AS Address,
    CASE
        WHEN "city" IS NULL                                         THEN 'Unknown'
        WHEN INITCAP("city") IN ('Paris', 'Bercy')                  THEN 'Unknown'
        WHEN INITCAP("city") IN ('Lagos', 'Iagos', 'Logos')         THEN 'Lagos'
        WHEN INITCAP("city") NOT IN ('Lagos', 'Kano', 'Abuja', 'Ibadan', 'Port Harcourt', 'Enugu')
                                                                    THEN 'Unknown'
        ELSE INITCAP("city")
    END                                                             AS City,
    CASE
        WHEN LOWER("state") IN ('paris', 'lugbe')                   THEN 'Unknown'
        WHEN LOWER("state") = 'fct'                                 THEN 'FCT'
        WHEN INITCAP("city") = 'Abuja'                              THEN 'FCT'
        WHEN INITCAP("city") IN ('Paris', 'Bercy')                  THEN 'Unknown'
        WHEN INITCAP("city") IN ('Lagos', 'Iagos', 'Logos')         THEN 'Lagos'
        WHEN "state" IS NULL
            THEN
                CASE
                    WHEN "city" IS NULL                             THEN 'Unknown'
                    WHEN INITCAP("city") NOT IN ('Lagos', 'Kano', 'Abuja', 'Ibadan', 'Port Harcourt', 'Enugu')
                                                                    THEN 'Unknown'
                    ELSE INITCAP("city")
                END
        ELSE INITCAP("state")
    END                                                             AS State,
    CASE
        WHEN LOWER("country") IN ('france')         THEN 'Unknown'
        ELSE INITCAP("country")
    END                                                             AS Country,
    CASE
        WHEN "postal_code" IN ('75015', '75016')    THEN 'Unknown'
        WHEN "postal_code" = '10001'                THEN '100001'
        WHEN INITCAP("city") IN ('Lagos', 'Iagos', 'Logos') THEN '100001'
        WHEN INITCAP("city") = 'Kano'               THEN '700001'
        WHEN INITCAP("city") = 'Abuja'              THEN '900001'
        WHEN INITCAP("city") = 'Ibadan'             THEN '200001'
        WHEN INITCAP("city") = 'Port Harcourt'      THEN '500001'
        WHEN INITCAP("city") = 'Enugu'              THEN '400001'
        ELSE COALESCE("postal_code", 'Unknown')
    END                                                             AS Postal_code,
    CASE
        WHEN "shipped_at" IS NULL   THEN 'Not Shipped Yet'
        ELSE CAST(TO_TIMESTAMP("shipped_at" / 1000000000) AS VARCHAR)
    END                                                             AS Shipped_at,
    CASE
        WHEN "delivered_at" IS NULL THEN 'Not Delivered Yet'
        ELSE CAST(TO_TIMESTAMP("delivered_at" / 1000000000) AS VARCHAR)
    END                                                             AS Delivered_at,
    DATEDIFF('day',
        TO_TIMESTAMP("shipped_at" / 1000000000),
        TO_TIMESTAMP("delivered_at" / 1000000000))                  AS Delivery_days,   -- null where not delivered
    TO_TIMESTAMP("created_at" / 1000000000)                         AS Created_date,
    TO_TIMESTAMP("updated_at" / 1000000000)                         AS Updated_date
FROM DATABASE3.BRONZE."shipping";

SELECT * FROM  DATABASE3.SILVER.SHIPPING;