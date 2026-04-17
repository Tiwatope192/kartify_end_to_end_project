
CREATE OR REPLACE TABLE DATABASE3.SILVER.CATEGORIES AS
SELECT
    "id"                                    AS id,
    "name"                                  AS name,
    "slug"                                  AS slug,
    REPLACE("slug", '-', '_')               AS slug_underscored,
    "name" || ' (' || "slug" || ')'         AS display_label,
    "is_active"                             AS is_active,
    TO_TIMESTAMP("created_at" / 1000000000) AS created_date,
    TO_TIMESTAMP("updated_at" / 1000000000) AS updated_date
FROM DATABASE3.BRONZE."categories";

SELECT * FROM DATABASE3.SILVER.CATEGORIES;
















  
   


SELECT * FROM DATABASE3.SILVER.CATEGORIES;








  






