WITH y AS (
    SELECT 
        month, 
        SUM(repeat_passengers) AS Repeat_managers 
    FROM 
        trips_db.fact_passenger_summary 
    GROUP BY 
        month
),
x AS (
    SELECT 
        tr.city_id,
        date_format(tr.month, '%M') AS months,
        ROUND(tr.repeat_passengers / tr.total_passengers * 100, 2) AS monthly_repeat_passenger_rate,
        ROUND(tr.repeat_passengers / y.Repeat_managers * 100, 2) AS city_repeat_passenger_rate
    FROM 
        trips_db.fact_passenger_summary tr
    JOIN 
        y using (month)
)
SELECT 
    tr_dc.city_name,
    date_format(tr_fps.month, '%M') AS month,
    SUM(tr_fps.total_passengers) AS total_passengers,
    SUM(tr_fps.repeat_passengers) AS repeat_passengers,
    MAX(x.monthly_repeat_passenger_rate) AS monthly_repeat_passenger_rate,
    MAX(x.city_repeat_passenger_rate) AS city_repeat_passenger_rate
FROM 
    trips_db.fact_passenger_summary tr_fps
JOIN 
    trips_db.dim_city tr_dc ON tr_fps.city_id = tr_dc.city_id
JOIN 
    x ON tr_fps.city_id = x.city_id AND date_format(tr_fps.month, '%M') = x.months
GROUP BY 
    tr_dc.city_name, month
ORDER BY 
    tr_dc.city_name;
