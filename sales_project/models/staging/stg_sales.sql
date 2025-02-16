-- This SQL script performs the following operations:
-- 1. Creates a CTE (Common Table Expression) named 'raw_data' that selects all columns from the 'src_sales' table in the 'raw_data' source.
-- 2. Selects and renames specific columns from the 'raw_data' CTE to create a more readable and meaningful dataset.

WITH raw_data AS (
    SELECT * FROM {{ source('raw_data', 'src_sales') }}
)

SELECT
    ordernumber AS order_id,
    quantityordered as quantity,
    round(sales/nullif(quantityordered, 0), 2) as price_unit_corrected,
    priceeach as price_unit,
    orderlinenumber as order_line_number,
    sales, 
    orderdate as order_date,
    status,
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

