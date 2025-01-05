## Query 5
WITH a AS (
    SELECT 
        city_id, 
        date_format(date, '%M') AS Months,
        SUM(fare_amount) AS revenue_month
    FROM 
        trips_db.fact_trips
    GROUP BY 
        city_id, Months
),
max_revenue AS (
    SELECT 
        city_id, 
        Months AS highest_revenue_month,
        revenue_month,
        RANK() OVER (PARTITION BY city_id ORDER BY revenue_month DESC) AS rnk
    FROM 
        a
),
total_revenue AS (
    SELECT 
        city_id,
        SUM(revenue_month) AS total_revenue
    FROM 
        a
    GROUP BY 
        city_id
)
SELECT 
    dc.city_name,
    max_rev.highest_revenue_month,
    max_rev.revenue_month AS highest_revenue,
    concat(ROUND((max_rev.revenue_month / total_rev.total_revenue) * 100, 2), " %") AS percentage_contribution,
    total_rev.total_revenue
FROM 
    trips_db.dim_city dc
JOIN 
    max_revenue max_rev ON dc.city_id = max_rev.city_id 
                        AND max_rev.rnk = 1
JOIN 
    total_revenue total_rev ON dc.city_id = total_rev.city_id
ORDER BY 
    max_rev.revenue_month / total_rev.total_revenue DESC;


