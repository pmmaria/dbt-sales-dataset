WITH stg_sales AS (
    SELECT * FROM {{ ref('sales_project', 'stg_sales') }}
)
SELECT 
    order_id,
    customer_id,
    date(order_timestamp) as date_id,
    round(sum(sales), 2) as sales, 
    sum(quantity) as quantity,
    count(distinct product_id) as distinct_items_count,
    order_status
FROM stg_sales
GROUP BY 1, 2, 3, 7