WITH trip_stats AS (
    SELECT 
        city_id,
        COUNT(trip_id) AS total_trips, 
        SUM(fare_amount) AS total_fare,
        SUM(distance_travelled_km) AS total_distance
    FROM 
        trips_db.fact_trips
    GROUP BY 
        city_id
)
SELECT 
    tr_dc.city_name, 
    ts.total_trips, 
    ROUND(ts.total_fare / ts.total_distance, 2) AS avg_fare_per_km, 
    ROUND(ts.total_fare / ts.total_trips, 2) AS avg_fare_per_trip, 
    CONCAT(
        ROUND(
            (ts.total_trips * 100.0) / (SELECT COUNT(*) FROM trips_db.fact_trips), 
            2
        ), 
        ' %'
    ) AS per_contribution_to_total_trips
FROM 
    trip_stats ts
JOIN 
    trips_db.dim_city tr_dc USING (city_id)
ORDER BY 
    ROUND(
            (ts.total_trips * 100.0) / (SELECT COUNT(*) FROM trips_db.fact_trips), 
            2
        ) DESC;
