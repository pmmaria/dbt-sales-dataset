WITH 
sales_agg AS (
    SELECT 
        order_date,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(quantity_ordered) AS total_quantity_ordered,
        SUM(total_sales) AS total_sales,
        COUNT(DISTINCT customer_id) AS distinct_customers
    FROM {{ ref('fct_sales') }}
    group by 1
),
dates AS (
    SELECT
        date_day,
        day_of_week_name,
        day_of_month,
        month_name,
        year_number
    FROM {{ ref('dim_date') }}
)

SELECT 
    DATE_TRUNC(d.date_day, MONTH) AS month_start_date,
    d.date_day,
    d.day_of_week_name,
    d.day_of_month,
    d.month_name,
    d.year_number,
    s.total_orders,
    s.total_quantity_ordered,
    round(s.total_sales, 2) AS total_sales,
    ROUND(s.total_sales / NULLIF(s.total_quantity_ordered, 0), 2) AS average_order_value,   
    s.distinct_customers
FROM sales_agg s
JOIN dates d
ON s.order_date = d.date_day
ORDER BY d.date_day