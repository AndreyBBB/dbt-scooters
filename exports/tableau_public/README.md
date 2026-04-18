# Tableau Public CSV Exports

This folder stores CSV exports of final dbt marts prepared for Tableau Public.

Recommended subfolders:

- `technician/`
- `marketing/`
- `board/`

Export only final marts and reports here.
Do not export staging or intermediate models for Tableau Public.

`psql` export scripts included:

- `technician_export.sql`
- `marketing_export.sql`
- `board_export.sql`

If your local PostgreSQL instance uses a schema other than `dbt`,
replace `dbt.` in the scripts with your actual target schema name.

These scripts use `\copy`, so they should be run from `psql`.
They write files from the client machine and avoid the server-side `COPY` permission problem.
