{{ dbt_product_analytics.event_stream(
    from=ref("stg_events_enriched"),
    event_type_col="type",
    user_id_col="user_id",
    date_col='"date"'
) }}
