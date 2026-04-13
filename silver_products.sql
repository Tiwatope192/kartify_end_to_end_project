CREATE TABLE DATABASE3.SILVER.products AS
SELECT
    "id",
    "category_id",
    INITCAP("name")                                                 AS Name,                -- capitalise name
    "slug",                                                                                 -- original slug
    REPLACE("slug", '-', '_')                                       AS Slug_underscored,    -- hyphens to underscores
    INITCAP("description")                                          AS Description,         -- capitalise description
    ROUND("price", 2)                                               AS Price,               -- 2 decimal places
    '₦' || TO_CHAR(ROUND("price", 2), '999,999,990.00')            AS Price_display,       -- naira sign for display
    CASE
        WHEN "price" >= 100  THEN 'Premium'
        WHEN "price" >= 50   THEN 'Mid Range'
        ELSE 'Budget'
    END                                                             AS Price_category,      -- price range flag
    COALESCE(CAST("image_url" AS VARCHAR), 'No Image')               AS Image_url,           -- handle null image url
    CASE
        WHEN "is_active" = TRUE THEN 'Active'
        ELSE 'Inactive'
    END                                                             AS Status,              -- active status label
    TO_TIMESTAMP("created_at" / 1000000000)                         AS Created_date,        -- nanoseconds to readable date
    TO_TIMESTAMP("updated_at" / 1000000000)                         AS Updated_date         -- nanoseconds to readable date
FROM DATABASE3.BRONZE."products";

INSERT INTO DATABASE3.SILVER.PRODUCTS
SELECT
    "id",
    "category_id",
    INITCAP("name")                                                 AS Name,
    "slug",
    REPLACE("slug", '-', '_')                                       AS Slug_underscored,
    INITCAP("description")                                          AS Description,
    ROUND("price", 2)                                               AS Price,
    '₦' || TO_CHAR(ROUND("price", 2), '999,999,990.00')            AS Price_display,
    CASE
        WHEN "price" >= 100  THEN 'Premium'
        WHEN "price" >= 50   THEN 'Mid Range'
        ELSE 'Budget'
    END                                                             AS Price_category,
    COALESCE(CAST("image_url" AS VARCHAR), 'No Image')              AS Image_url,           -- fixed
    CASE
        WHEN "is_active" = TRUE THEN 'Active'
        ELSE 'Inactive'
    END                                                             AS Status,
    TO_TIMESTAMP("created_at" / 1000000000)                         AS Created_date,
    TO_TIMESTAMP("updated_at" / 1000000000)                         AS Updated_date
FROM DATABASE3.BRONZE."products";


SELECT * FROM DATABASE3.SILVER.PRODUCTS;