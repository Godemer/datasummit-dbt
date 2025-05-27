with source as (

    select * from {{ source('thelook_ecommerce', 'order_items') }}

),

renamed as (

    select
        -- IDs
        id as order_item_id,
        order_id,
        user_id,
        product_id,

        /* Other columns */
        sale_price

        {# Unused columns
        inventory_item_id,
        status,
        created_at,
        shipped_at,
        delivered_at,
        returned_at
        #}

    from source

)

select * from renamed