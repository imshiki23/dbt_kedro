#!/bin/sh
cd /workspaces/codeBase/dbt_kedro_example/dbt
echo "Cleaning files..."
rm -f duckDBtest.duckdb
rm -f model_input_table.csv
echo "Start DBT Run..."
dbt seed --target dev
dbt run --target dev
dbt docs generate --target dev
dbt docs serve --target dev &
echo "Start Kedro Run..."
cd /workspaces/codeBase/dbt_kedro_example
kedro run
kedro viz run &