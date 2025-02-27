WITH orders_agg AS (
    SELECT
        extract(year from order_date) as year_id,
        extract(month from order_date) as month_id,
        count(distinct order_id) as total_orders, 
        sum(quantity_ordered) as total_quantity_ordered,
        round(sum(total_sales), 2) as total_sales,
        count(distinct customer_id) as distinct_customers
    FROM {{ ref('fct_orders') }}
    GROUP BY 1, 2
) 
SELECT 
    year_id,
    month_id,
    total_orders,
    total_quantity_ordered,
    total_sales,
    round(total_sales/nullif(total_orders, 0), 2) as avg_order_value,
    distinct_customers
FROM orders_agg
ORDER BY 1, 2   