WITH 
customer_region AS (
    SELECT
        customer_id,
        customer_country,
        customer_state,
        customer_city
    FROM {{ ref('dim_customer') }}
),

sales_agg AS (
    SELECT
        order_date,
        customer_id,
        SUM(total_sales) AS total_sales,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(quantity_ordered) AS total_quantity_ordered,
        COUNT(DISTINCT customer_id) AS distinct_customers
    FROM {{ ref('fct_sales') }}
    GROUP BY 1, 2
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
    d.date_day,
    d.day_of_week_name,
    d.day_of_month,
    d.month_name,
    d.year_number,
    c.customer_country,
    c.customer_state,
    c.customer_city,
    s.total_orders,
    s.total_quantity_ordered,
    s.total_sales,
    ROUND(s.total_sales / NULLIF(s.total_quantity_ordered, 0), 2) AS average_order_value,   
    s.distinct_customers
FROM sales_agg s
JOIN dates d
ON s.order_date = d.date_day
JOIN customer_region c
ON s.customer_id = c.customer_id
ORDER BY d.date_day