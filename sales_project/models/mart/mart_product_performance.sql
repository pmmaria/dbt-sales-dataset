WITH 
sales_agg AS (
    SELECT 
        product_id,
        SUM(total_sales) AS total_sales,
        SUM(quantity_ordered) AS total_quantity_ordered,
        COUNT(DISTINCT order_id) AS total_orders
    FROM {{ ref('fct_sales') }}
    GROUP BY product_id
),

aggregated_product AS (
    SELECT 
        product_id,
        MAX(product_category) AS product_category,  
        MAX(msrp) AS msrp,                        
        MAX(avg_unit_price) AS avg_unit_price                       
    FROM {{ ref('dim_product') }}
    GROUP BY product_id
),

product_performance AS (
    SELECT
        p.product_id,
        p.product_category,  
        p.msrp,              
        p.avg_unit_price,  
        s.total_sales,
        s.total_quantity_ordered,
        s.total_orders,
        ROUND(s.total_sales / NULLIF(s.total_quantity_ordered, 0), 2) AS average_order_value,
        ROUND(s.total_sales / NULLIF(s.total_orders, 0), 2) AS sales_per_order
    FROM sales_agg s
    JOIN aggregated_product p
    ON s.product_id = p.product_id
)

SELECT * 
FROM product_performance
ORDER BY total_sales DESC
