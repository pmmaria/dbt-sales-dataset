WITH stg_sales AS (
    SELECT * FROM {{ ref('stg_sales') }}
)
SELECT 
    order_line_id,
    order_id,
    product_id,
    quantity_ordered,
    unit_price_corrected,
    total_sales, 
    order_date,
    customer_id,
    order_status
FROM stg_sales


