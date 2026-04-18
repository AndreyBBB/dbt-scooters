copy (
    select *
    from dbt.fct_revenue_monthly
) to 'C:/Users/AB/dbt_scooters/exports/tableau_public/board/fct_revenue_monthly.csv'
with (format csv, header true);

copy (
    select *
    from dbt.fct_user_revenue_monthly
) to 'C:/Users/AB/dbt_scooters/exports/tableau_public/board/fct_user_revenue_monthly.csv'
with (format csv, header true);

copy (
    select *
    from dbt.rpt_revenue_concentration_risk_monthly
) to 'C:/Users/AB/dbt_scooters/exports/tableau_public/board/rpt_revenue_concentration_risk_monthly.csv'
with (format csv, header true);

copy (
    select *
    from dbt.rpt_company_fleet_usage
) to 'C:/Users/AB/dbt_scooters/exports/tableau_public/board/rpt_company_fleet_usage.csv'
with (format csv, header true);
