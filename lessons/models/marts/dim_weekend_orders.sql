SELECT *
FROM {{ ref('stg_ecommerce__orders') }}
WHERE {{ is_weekend('CREATED_AT') }}