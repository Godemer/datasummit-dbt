
{% set order_is_valid %}
    status != 'Cancelled'
    AND num_items_ordered > 0
{%- endset -%}

SELECT *
FROM {{ ref('stg_ecommerce__orders') }}
WHERE {{ order_is_valid }}
