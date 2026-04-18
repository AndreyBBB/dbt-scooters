{{ dbt_product_analytics.retention(
  event_stream=ref("int_events_stream"),
  first_action="start_search",
  second_action="book_scooter"
) }}
