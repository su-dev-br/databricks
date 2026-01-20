-- Gold layer: customer analytics summary
-- Aggregates data from the silver layer

{{ config(materialized='table') }}

SELECT
    country,
    COUNT(*) as customer_count,
    MIN(created_at) as earliest_registration,
    MAX(created_at) as latest_registration
FROM {{ ref('stg_customers') }}
GROUP BY 1
ORDER BY customer_count DESC
