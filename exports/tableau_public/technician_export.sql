copy (
    select *
    from dbt.rpt_geo_demand_supply_imbalance_tableau
) to 'C:/Users/AB/dbt_scooters/exports/tableau_public/technician/rpt_geo_demand_supply_imbalance_tableau.csv'
with (format csv, header true);

copy (
    select *
    from dbt.rpt_fleet_stress_company_model
) to 'C:/Users/AB/dbt_scooters/exports/tableau_public/technician/rpt_fleet_stress_company_model.csv'
with (format csv, header true);

copy (
    select *
    from dbt.fct_trips_daily
) to 'C:/Users/AB/dbt_scooters/exports/tableau_public/technician/fct_trips_daily.csv'
with (format csv, header true);
