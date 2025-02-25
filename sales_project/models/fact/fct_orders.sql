WITH stg_sales AS (
    SELECT * FROM {{ ref('stg_sales') }}
)
SELECT 
    order_id,
    round(sum(total_sales), 2) as total_sales, 
    sum(quantity_ordered) as quantity_ordered,
    count(distinct product_id) as distinct_items_count,
    customer_id,
    order_date,
    order_status
FROM stg_sales
GROUP BY 1, 5, 6, 7