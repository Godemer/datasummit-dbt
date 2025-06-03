
{% set order_columns = ['order_id', 'status'] -%}

SELECT
    {%- for item in order_columns %}
        {{ item }}
    {%- if not loop.last %}, {% endif %}
    {%- endfor %}
FROM {{ ref('stg_ecommerce__orders') }}
