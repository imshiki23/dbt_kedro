{{ config(
  pre_hook="DROP TABLE IF EXISTS duckDBtest.main.model_input_table;",
  post_hook = "COPY duckDBtest.main.model_input_table TO '/workspaces/dbt_kedro/dbt_kedro_example/data/01_raw/model_input_table.csv' (HEADER, DELIMITER ',');"
) }}

SELECT 
S.ID AS shipping_id,
S.COMPANY_ID,
S.shuttle_location,
S.engine_type,
S.engine_vendor,
S.engines,
S.passenger_capacity,
S.cancellation_policy,
S.crew,
CAST(CAST(S.D_CHECK_COMPLETE AS BOOLEAN) AS SMALLINT) AS d_check_complete,
CAST(CAST(S.moon_clearance_complete AS BOOLEAN) AS SMALLINT) AS moon_clearance_complete,
CAST(REPLACE(REPLACE(S.price, '$', ''), ',', '') AS FLOAT) AS price,
R.review_scores_rating,
R.review_scores_comfort,
R.review_scores_amenities,
r.review_scores_trip,
r.review_scores_crew,
r.review_scores_location,
r.review_scores_price,
r.number_of_reviews,
r.reviews_per_month,
CAST(TRIM(C.company_rating , '%') AS FLOAT)/100.00 AS company_rating ,
c.company_location,
c.total_fleet_count,
CAST(CAST(c.iata_approved AS BOOLEAN) AS SMALLINT) AS iata_approved
FROM {{ ref ( 'shuttles') }} S 
JOIN {{ ref( 'reviews') }} R ON S.ID = R.SHUTTLE_ID 
JOIN {{ ref( 'companies') }} C ON C.ID = S.COMPANY_ID 
where shuttle_id IS NOT NULL
  AND company_id IS NOT NULL
  AND shuttle_location IS NOT NULL
  AND engine_type IS NOT NULL
  AND engine_vendor IS NOT NULL
  AND engines IS NOT NULL
  AND passenger_capacity IS NOT NULL
  AND cancellation_policy IS NOT NULL
  AND crew IS NOT NULL
  AND d_check_complete IS NOT NULL
  AND moon_clearance_complete IS NOT NULL
  AND price IS NOT NULL
  AND review_scores_rating IS NOT NULL
  AND review_scores_comfort IS NOT NULL
  AND review_scores_amenities IS NOT NULL
  AND review_scores_trip IS NOT NULL
  AND review_scores_crew IS NOT NULL
  AND review_scores_location IS NOT NULL
  AND review_scores_price IS NOT NULL
  AND number_of_reviews IS NOT NULL
  AND reviews_per_month IS NOT NULL
  AND company_rating IS NOT NULL
  AND company_location IS NOT NULL
  AND total_fleet_count IS NOT NULL
  AND iata_approved IS NOT NULL