WITH raw_data AS (
    SELECT * FROM {{ source('raw_data', 'src_sales') }}
)

SELECT
    ordernumber AS order_id,
    quantityordered as quantity_ordered,
    round(sales/nullif(quantityordered, 0), 2) as unit_price_corrected,
    priceeach as unit_price,
    orderlinenumber as order_line_number,
    {{ dbt_utils.generate_surrogate_key(['orderlinenumber', 'ordernumber']) }} AS order_line_id,  -- Order line surrogate key
    sales as total_sales, 
    date(orderdate) as order_date,
    status as order_status,
    qtr_id,
    month_id,
    year_id,
    productline as product_category,
    msrp,
    productcode as product_id,
    {{ dbt_utils.generate_surrogate_key(['customername', 'phone']) }} AS customer_id,  -- Customer surrogate key
    customername as customer_name,
    phone as customer_phone,
    addressline1 as customer_address,
    addressline2 as customer_address2,
    city as customer_city,
    state as customer_state,
    postalcode as customer_postal_code,
    country as customer_country,
    territory as customer_territory,
    contactlastname as customer_contact_lastname,
    contactfirstname as customer_contact_firstname,
    dealsize as deal_size
FROM raw_data
