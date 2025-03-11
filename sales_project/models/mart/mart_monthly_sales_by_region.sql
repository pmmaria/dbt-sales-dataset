WITH 
customer_region AS (
    SELECT
        customer_id,
        customer_country,
        customer_city
    FROM {{ ref('dim_customer') }}
),

sales_agg AS (
    SELECT
        order_date,
        customer_id,
        round(SUM(total_sales), 2) AS total_sales,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(quantity_ordered) AS total_quantity_ordered,
        COUNT(DISTINCT customer_id) AS distinct_customers
    FROM {{ ref('fct_sales') }}
    GROUP BY 1, 2
),
dates AS (
    SELECT
        date_day,
        month_name,
        year_number
    FROM {{ ref('dim_date') }}
)
SELECT
    DATE_TRUNC(d.date_day, MONTH) AS month_start_date,
    d.month_name,
    d.year_number,
    c.customer_country,
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
ORDER BY month_start_date