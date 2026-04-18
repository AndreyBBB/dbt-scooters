# Tableau Public CSV Exports

This folder stores CSV exports of final dbt marts prepared for Tableau Public.

Recommended subfolders:

- `technician/`
- `marketing/`
- `board/`

Export only final marts and reports here.
Do not export staging or intermediate models for Tableau Public.

SQL export scripts included:

- `technician_export.sql`
- `marketing_export.sql`
- `board_export.sql`

If your local PostgreSQL instance uses a schema other than `dbt`,
replace `dbt.` in the scripts with your actual target schema name.

If PostgreSQL refuses to write files because of permissions,
run the same queries in your SQL client and export the result grid to CSV manually.
