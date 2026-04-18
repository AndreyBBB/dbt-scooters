with source_cte as (
    select count(*) as row_count
    from {{ ref("stg_events_deduped") }}
),

target_cte as (
    select count(*) as row_count
    from {{ ref("stg_events_enriched") }}
)

select
    'Row count mismatch' as error_message,
    source_cte.row_count as source_count,
    target_cte.row_count as target_count
from
    source_cte,
    target_cte
where
    source_cte.row_count != target_cte.row_count
