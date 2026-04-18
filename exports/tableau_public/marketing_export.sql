copy (
    select *
    from dbt.rpt_commuter_opportunity_segments
) to 'C:/Users/AB/dbt_scooters/exports/tableau_public/marketing/rpt_commuter_opportunity_segments.csv'
with (format csv, header true);

copy (
    select *
    from dbt.rpt_free_ride_dependency_monthly
) to 'C:/Users/AB/dbt_scooters/exports/tableau_public/marketing/rpt_free_ride_dependency_monthly.csv'
with (format csv, header true);

copy (
    select *
    from dbt.rpt_book_scooter_retention
) to 'C:/Users/AB/dbt_scooters/exports/tableau_public/marketing/rpt_book_scooter_retention.csv'
with (format csv, header true);
