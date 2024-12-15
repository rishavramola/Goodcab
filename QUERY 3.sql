WITH z AS (
    SELECT 
        city_id,
        SUM(repeat_passenger_count) AS crpc
    FROM 
        trips_db.dim_repeat_trip_distribution tr_drtb
    GROUP BY 
        city_id
),
a AS (
    SELECT 
        city_id,
        SUM(repeat_passenger_count) / z.crpc * 100 AS pc
    FROM 
        trips_db.dim_repeat_trip_distribution tr_drtb
    JOIN 
        z USING (city_id)
    WHERE 
        tr_drtb.trip_count = '2-Trips'
    GROUP BY 
        city_id
),
b AS (
    SELECT 
        city_id,
        SUM(repeat_passenger_count) / z.crpc * 100 AS pc
    FROM 
        trips_db.dim_repeat_trip_distribution tr_drtb
    JOIN 
        z USING (city_id)
    WHERE 
        tr_drtb.trip_count = '3-Trips'
    GROUP BY 
        city_id
),
c AS (
    SELECT 
        city_id,
        SUM(repeat_passenger_count) / z.crpc * 100 AS pc
    FROM 
        trips_db.dim_repeat_trip_distribution tr_drtb
    JOIN 
        z USING (city_id)
    WHERE 
        tr_drtb.trip_count = '4-Trips'
    GROUP BY 
        city_id
),
d AS (
    SELECT 
        city_id,
        SUM(repeat_passenger_count) / z.crpc * 100 AS pc
    FROM 
        trips_db.dim_repeat_trip_distribution tr_drtb
    JOIN 
        z USING (city_id)
    WHERE 
        tr_drtb.trip_count = '5-Trips'
    GROUP BY 
        city_id
),
e AS (
    SELECT 
        city_id,
        SUM(repeat_passenger_count) / z.crpc * 100 AS pc
    FROM 
        trips_db.dim_repeat_trip_distribution tr_drtb
    JOIN 
        z USING (city_id)
    WHERE 
        tr_drtb.trip_count = '6-Trips'
    GROUP BY 
        city_id
),
f AS (
    SELECT 
        city_id,
        SUM(repeat_passenger_count) / z.crpc * 100 AS pc
    FROM 
        trips_db.dim_repeat_trip_distribution tr_drtb
    JOIN 
        z USING (city_id)
    WHERE 
        tr_drtb.trip_count = '7-Trips'
    GROUP BY 
        city_id
),
g AS (
    SELECT 
        city_id,
        SUM(repeat_passenger_count) / z.crpc * 100 AS pc
    FROM 
        trips_db.dim_repeat_trip_distribution tr_drtb
    JOIN 
        z USING (city_id)
    WHERE 
        tr_drtb.trip_count = '8-Trips'
    GROUP BY 
        city_id
),
h AS (
    SELECT 
        city_id,
        SUM(repeat_passenger_count) / z.crpc * 100 AS pc
    FROM 
        trips_db.dim_repeat_trip_distribution tr_drtb
    JOIN 
        z USING (city_id)
    WHERE 
        tr_drtb.trip_count = '9-Trips'
    GROUP BY 
        city_id
),
i AS (
    SELECT 
        city_id,
        SUM(repeat_passenger_count) / z.crpc * 100 AS pc
    FROM 
        trips_db.dim_repeat_trip_distribution tr_drtb
    JOIN 
        z USING (city_id)
    WHERE 
        tr_drtb.trip_count = '10-Trips'
    GROUP BY 
        city_id
)
SELECT 
    tr_dc.city_name,
    a.pc AS "2-Trips",
    b.pc AS "3-Trips",
    c.pc AS "4-Trips",
    d.pc AS "5-Trips",
    e.pc AS "6-Trips",
    f.pc AS "7-Trips",
    g.pc AS "8-Trips",
    h.pc AS "9-Trips",
    i.pc AS "10-Trips"
FROM 
    trips_db.dim_city tr_dc
LEFT JOIN 
    a ON tr_dc.city_id = a.city_id
LEFT JOIN 
    b ON tr_dc.city_id = b.city_id
LEFT JOIN 
    c ON tr_dc.city_id = c.city_id
LEFT JOIN 
    d ON tr_dc.city_id = d.city_id
LEFT JOIN 
    e ON tr_dc.city_id = e.city_id
LEFT JOIN 
    f ON tr_dc.city_id = f.city_id
LEFT JOIN 
    g ON tr_dc.city_id = g.city_id 
LEFT JOIN 
    h ON tr_dc.city_id = h.city_id      
LEFT JOIN 
    i ON tr_dc.city_id = i.city_id;
