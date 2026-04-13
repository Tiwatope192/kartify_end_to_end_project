CREATE OR REPLACE TABLE DATABASE3.SILVER.CATEGORIES AS
SELECT
    "id"                                               AS Id,
    "name"                                             AS Name,
    "slug"                                             AS Slug,
    REPLACE("slug", '-', '_')                          AS Slug_underscored,
    "name" || ' (' || "slug" || ')'                    AS Display_label,
    "is_active"                                        AS Is_active,
    TO_TIMESTAMP("created_at" / 1000000000)            AS Created_date,
    TO_TIMESTAMP("updated_at" / 1000000000)            AS Updated_date
FROM DATABASE3.BRONZE."categories";


SELECT * FROM DATABASE3.SILVER.CATEGORIES;

INSERT INTO DATABASE3.SILVER.CATEGORIES
SELECT
    "id"                                               AS Id,
    "name"                                             AS Name,
    "slug"                                             AS Slug,
    REPLACE("slug", '-', '_')                          AS Slug_underscored,
    "name" || ' (' || "slug" || ')'                    AS Display_label,
    "is_active"                                        AS Is_active,
    TO_TIMESTAMP("created_at" / 1000000000)            AS Created_date,
    TO_TIMESTAMP("updated_at" / 1000000000)            AS Updated_date
FROM DATABASE3.BRONZE."categories";



