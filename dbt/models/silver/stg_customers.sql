-- Silver layer: staging customers
-- Reads from the bronze table created by the Python script

{{ config(materialized='table') }}

WITH raw_data AS (
    SELECT * FROM {{ source('bronze', 'customers') }}
)

SELECT
    customer_id,
    INITCAP(name) as customer_name,
    LOWER(email) as email,
    address,
    UPPER(country) as country,
    created_at::timestamp as created_at
FROM raw_data
