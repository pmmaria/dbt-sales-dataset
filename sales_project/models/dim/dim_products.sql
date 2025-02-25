WITH stg_sales AS (
    SELECT * FROM {{ ref('sales_project', 'stg_sales') }}
)
SELECT
    product_id,
    unit_price_corrected,
    product_category,
    msrp
FROM stg_sales