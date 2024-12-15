SELECT 
    dc.city_name,
    DATE_FORMAT(mtt.month, '%M') AS month_name,
    ft.actual_trips,
    mtt.total_target_trips,
    CASE 
        WHEN ft.actual_trips > mtt.total_target_trips THEN 'Above Target'
        ELSE 'Below Target'
    END AS performance_status,
    CONCAT(
        ROUND(
            (ft.actual_trips - mtt.total_target_trips) / ft.actual_trips * 100,
            2
        ), '%'
    ) AS perc_difference
FROM 
    targets_db.monthly_target_trips mtt
JOIN 
    trips_db.dim_city dc
ON 
    mtt.city_id = dc.city_id
LEFT JOIN (
    SELECT 
        city_id,
        DATE_FORMAT(date, '%m') AS trip_month,
        COUNT(trip_id) AS actual_trips
    FROM 
        trips_db.fact_trips
    GROUP BY 
        city_id, trip_month
) ft
ON 
    mtt.city_id = ft.city_id 
    AND DATE_FORMAT(mtt.month, '%m') = ft.trip_month;
