--checking for unique values in city 

SELECT 
    "city",
    COUNT(*) AS City_count
FROM DATABASE3.BRONZE."customers"
GROUP BY "city";


CREATE OR REPLACE TABLE DATABASE3.SILVER.customers AS
SELECT
    "id",
    INITCAP("first_name")                                   AS First_name,
    INITCAP("last_name")                                    AS Last_name,
    "email",
    --using REGEXP to format phone number to clean number strings by extracting strings to match Nigerian phone format, and also handle NULLS and Foreign digits
    "phone"                                                 AS Original_phone,
    CASE
        WHEN "phone" IS NULL 
            THEN 'No Phone'
        WHEN REGEXP_REPLACE("phone", '[^0-9]', '') LIKE '234%'
            AND LENGTH(REGEXP_REPLACE("phone", '[^0-9]', '')) = 13
            THEN '+' || REGEXP_REPLACE("phone", '[^0-9]', '')
        WHEN REGEXP_REPLACE("phone", '[^0-9]', '') LIKE '234%'
            AND LENGTH(REGEXP_REPLACE("phone", '[^0-9]', '')) > 13
            THEN '+234' || RIGHT(REGEXP_REPLACE("phone", '[^0-9]', ''), 10)
        WHEN REGEXP_REPLACE("phone", '[^0-9]', '') LIKE '0%'
            THEN '+234' || SUBSTR(REGEXP_REPLACE("phone", '[^0-9]', ''), 2, 10)
        ELSE '+234' || RIGHT(REGEXP_REPLACE("phone", '[^0-9]', ''), 10)
    END                                                     AS Cleaned_phone,
    
    --Handling NULLS, bad or missing values in address and standardizing foreign address as Unknown e.g Paris.
    CASE
        WHEN "address" IS NULL                  THEN 'No Address'
        WHEN "address" IN ('75015', '75016')    THEN 'Unknown'
        ELSE "address"
    END                                                     AS Address,
    --Handling NULLS and standardizing the city and state columns by fixing nulls, misspellings and invalid values. 
    CASE
        WHEN "city" IS NULL                                             THEN 'Unknown'
        WHEN INITCAP("city") = 'Logos'                                  THEN 'Lagos'
        WHEN INITCAP("city") NOT IN ('Lagos', 'Kano', 'Abuja', 'Ibadan', 'Port Harcourt', 'Enugu')
                                                                        THEN 'Unknown'
        ELSE INITCAP("city")
    END                                                     AS City,
    CASE
        WHEN LOWER("state") IN ('paris', 'lugbe')                       THEN 'Unknown'
        WHEN LOWER("state") = 'fct'                                     THEN 'FCT'
        WHEN INITCAP("state") = 'Logos'                                 THEN 'Lagos'
        WHEN "state" IS NULL
            THEN
                CASE
                    WHEN "city" IS NULL                                  THEN 'Unknown'
                    WHEN INITCAP("state") = 'Logos'                      THEN 'Lagos'
                    WHEN INITCAP("city") = 'Abuja'                      THEN 'FCT'
                    WHEN INITCAP("city") NOT IN ('Lagos', 'Kano', 'Abuja', 'Ibadan', 'Port Harcourt', 'Enugu')
                                                                        THEN 'Unknown'
                    ELSE INITCAP("city")
                END
        ELSE INITCAP("state")
    END    
    AS State,
    
-- postal code maps cities to their correct Nigerian codes and country removes any non-Nigerian entries    
    CASE
        WHEN "postal_code" IN ('75015', '75016') THEN 'Unknown'
        WHEN INITCAP("city") IN ('Lagos', 'Logos') THEN '100001'
        WHEN INITCAP("city") = 'Kano'            THEN '700001'
        WHEN INITCAP("city") = 'Abuja'           THEN '900001'
        WHEN INITCAP("city") = 'Ibadan'          THEN '200001'
        WHEN INITCAP("city") = 'Port Harcourt'   THEN '500001'
        WHEN INITCAP("city") = 'Enugu'           THEN '400001'
        ELSE COALESCE("postal_code", 'Unknown')
    END                                                     AS Postal_code,
    CASE
        WHEN LOWER("country") = 'france'        THEN 'Unknown'
        ELSE INITCAP("country")
    END
    AS Country,
--
    TO_TIMESTAMP("created_at" / 1000000000)                 AS Created_date,
    TO_TIMESTAMP("updated_at" / 1000000000)                 AS Updated_date
FROM DATABASE3.BRONZE."customers";


INSERT INTO DATABASE3.SILVER.customers
SELECT 
    "id",
    INITCAP("first_name")                                   AS First_name,
    INITCAP("last_name")                                    AS Last_name,
    "email",
    "phone"                                                 AS Original_phone,
    CASE
        WHEN "phone" IS NULL 
            THEN 'No Phone'
        WHEN REGEXP_REPLACE("phone", '[^0-9]', '') LIKE '234%'
            AND LENGTH(REGEXP_REPLACE("phone", '[^0-9]', '')) = 13
            THEN '+' || REGEXP_REPLACE("phone", '[^0-9]', '')
        WHEN REGEXP_REPLACE("phone", '[^0-9]', '') LIKE '234%'
            AND LENGTH(REGEXP_REPLACE("phone", '[^0-9]', '')) > 13
            THEN '+234' || RIGHT(REGEXP_REPLACE("phone", '[^0-9]', ''), 10)
        WHEN REGEXP_REPLACE("phone", '[^0-9]', '') LIKE '0%'
            THEN '+234' || SUBSTR(REGEXP_REPLACE("phone", '[^0-9]', ''), 2, 10)
        ELSE '+234' || RIGHT(REGEXP_REPLACE("phone", '[^0-9]', ''), 10)
    END                                                     AS cleaned_phone,
    CASE
        WHEN "address" IS NULL                  THEN 'No Address'
        WHEN "address" IN ('75015', '75016')    THEN 'Unknown'
        ELSE "address"
    END                                                     AS Address,
    CASE
        WHEN "city" IS NULL                                             THEN 'Unknown'
        WHEN INITCAP("city") = 'Logos'                                  THEN 'Lagos'
        WHEN INITCAP("city") NOT IN ('Lagos', 'Kano', 'Abuja', 'Ibadan', 'Port Harcourt', 'Enugu')
                                                                        THEN 'Unknown'
        ELSE INITCAP("city")
    END                                                     AS City,
    CASE
        WHEN LOWER("state") IN ('paris', 'lugbe')                       THEN 'Unknown'
        WHEN LOWER("state") = 'fct'                                     THEN 'FCT'
        WHEN INITCAP("state") = 'Logos'                                 THEN 'Lagos'
        WHEN "state" IS NULL
            THEN
                CASE
                    WHEN "city" IS NULL                                  THEN 'Unknown'
                    WHEN INITCAP("state") = 'Logos'                     THEN 'Lagos'
                    WHEN INITCAP("city") = 'Abuja'                      THEN 'FCT'
                    WHEN INITCAP("city") NOT IN ('Lagos', 'Kano', 'Abuja', 'Ibadan', 'Port Harcourt', 'Enugu')
                                                                        THEN 'Unknown'
                    ELSE INITCAP("city")
                END
        ELSE INITCAP("state")
    END                                                     AS State,
    CASE
        WHEN "postal_code" IN ('75015', '75016')  THEN 'Unknown'
        WHEN INITCAP("city") IN ('Lagos', 'Logos') THEN '100001'
        WHEN INITCAP("city") = 'Kano'             THEN '700001'
        WHEN INITCAP("city") = 'Abuja'            THEN '900001'
        WHEN INITCAP("city") = 'Ibadan'           THEN '200001'
        WHEN INITCAP("city") = 'Port Harcourt'    THEN '500001'
        WHEN INITCAP("city") = 'Enugu'            THEN '400001'
        ELSE COALESCE("postal_code", 'Unknown')
    END                                                     AS Postal_code,
    CASE
        WHEN LOWER("country") = 'france'        THEN 'Unknown'
        ELSE INITCAP("country")
    END                                                     AS Country,
    TO_TIMESTAMP("created_at" / 1000000000)                 AS Created_date,
    TO_TIMESTAMP("updated_at" / 1000000000)                 AS Updated_date
FROM DATABASE3.BRONZE."customers";

select * from DATABASE3.SILVER.CUSTOMERS;