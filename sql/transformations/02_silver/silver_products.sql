
CREATE OR REPLACE TABLE DATABASE3.SILVER.products AS
SELECT
    "id" AS id,
    "category_id" AS category_id,

    INITCAP("name") AS name,

    "slug" AS slug,
    REPLACE("slug", '-', '_') AS slug_underscored,

    INITCAP("description") AS description,

    ROUND("price", 2) AS price,

    CASE
        WHEN "price" >= 100 THEN 'Premium'
        WHEN "price" >= 50 THEN 'Mid Range'
        ELSE 'Budget'
    END AS price_category,

    COALESCE(CAST("image_url" AS VARCHAR), 'No Image') AS image_url,

    CASE
        WHEN "is_active" = TRUE THEN 'Active'
        ELSE 'Inactive'
    END AS status,

    TO_TIMESTAMP("created_at" / 1000000000) AS created_date,
    TO_TIMESTAMP("updated_at" / 1000000000) AS updated_date

FROM DATABASE3.BRONZE."products";




SELECT * FROM DATABASE3.SILVER.PRODUCTS;