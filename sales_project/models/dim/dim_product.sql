WITH stg_sales AS (
    SELECT * FROM {{ ref('stg_sales') }}
)
SELECT
    product_id,
    product_category,
    msrp,
    round(avg(unit_price_corrected), 2) as avg_unit_price 
FROM stg_sales
GROUP BY product_id, product_category, msrp