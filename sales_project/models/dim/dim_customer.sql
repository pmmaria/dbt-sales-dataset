WITH stg_sales AS (
    SELECT * FROM {{ ref('stg_sales') }}
)
SELECT
    customer_id, 
    customer_name, 
    customer_phone,
    customer_address,
    customer_address2,
    customer_city,
    customer_state,
    customer_postal_code,
    customer_country,
    customer_territory,
    customer_contact_lastname,
    customer_contact_firstname
FROM stg_sales