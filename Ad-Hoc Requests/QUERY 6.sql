# Temporary table for total repeat passengers across all cities by month
WITH monthly_repeats AS (
    SELECT 
        month, 
        SUM(repeat_passengers) AS Repeat_passengers 
    FROM 
        trips_db.fact_passenger_summary 
    GROUP BY 
        month
),
# Temporary table for total repeat passengers for each city across all months
city_total_repeats AS (
    SELECT
        city_id,
        SUM(repeat_passengers) AS total_repeat_passengers
    FROM
        trips_db.fact_passenger_summary
    GROUP BY
        city_id
),
# Calculating monthly repeat passenger rate and city-wide repeat passenger rate
city_rates AS (
    SELECT 
        tr.city_id,
        DATE_FORMAT(tr.month, '%M') AS months,
        ROUND(tr.repeat_passengers / tr.total_passengers * 100, 2) AS monthly_repeat_passenger_rate,
        ROUND(tr.repeat_passengers / ctr.total_repeat_passengers * 100, 2) AS city_repeat_passenger_rate
    FROM 
        trips_db.fact_passenger_summary tr
    JOIN 
        monthly_repeats y USING (month)
    JOIN
        city_total_repeats ctr ON tr.city_id = ctr.city_id
)
-- Generating the final report
SELECT 
    dc.city_name,
    DATE_FORMAT(fps.month, '%M') AS month_name,
    SUM(fps.total_passengers) AS total_passengers,
    SUM(fps.repeat_passengers) AS repeat_passengers,
    MAX(cr.monthly_repeat_passenger_rate) AS monthly_repeat_passenger_rate,
    MAX(cr.city_repeat_passenger_rate) AS city_repeat_passenger_rate
FROM 
    trips_db.fact_passenger_summary fps
JOIN 
    trips_db.dim_city dc ON fps.city_id = dc.city_id
JOIN 
    city_rates cr ON fps.city_id = cr.city_id AND DATE_FORMAT(fps.month, '%M') = cr.months
GROUP BY 
    dc.city_name, month
ORDER BY 
    dc.city_name;
