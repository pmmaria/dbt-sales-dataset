WITH stg_sales AS (
    SELECT * FROM {{ ref('sales_project', 'stg_sales') }}
)
SELECT 
    order_id,
    customer_id, 
    product_id,
    order_date,
    quantity,
    price_unit_corrected,
    sales,
    status
FROM stg_sales


