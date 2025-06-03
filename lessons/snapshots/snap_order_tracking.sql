{% snapshot snap_order_tracking %}
    {{
        config(
            target_schema='snapshots',
            unique_key='order_id',
            strategy='check',
            check_cols=['status']
        )
    }}

    SELECT
        *
    FROM {{ ref('stg_ecommerce__orders') }}

{% endsnapshot %}