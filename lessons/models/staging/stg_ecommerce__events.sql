{{
	config(
		materialized='table',
		partition_by={
			"field": "created_at",
			"data_type": "timestamp",
			"granularity": "day"
		}
	)
}}

WITH source AS (
	SELECT *

	FROM {{ source('thelook_ecommerce', 'events') }}
)

SELECT
	id AS event_id,
	user_id,
	sequence_number,
	session_id,
	created_at,
	ip_address,
	city,
	state,
	postal_code,
	browser,
	traffic_source,
	uri AS web_link,
	event_type,
	{# Look in macros/macro_get_brand_name.sql to see how this function is defined #}
	{{ target.schema }}.get_brand_name(uri) AS brand_name


FROM source

{# Only runs this filter on an incremental run #}
{% if is_incremental() %}

{# The {{ this }} macro is essentially a {{ ref('') }} macro that allows for a circular reference #}
WHERE created_at > (SELECT MAX(created_at) FROM {{ this }})

{% endif %}
