(Select
	DENSE_RANK() OVER (ORDER BY SUM(total_passengers) DESC) as"Top 3 / Bottom 3",
    tr_dc.city_name,
    sum(total_passengers) as total_new_passengers
from 
	trips_db.fact_passenger_summary tr_fps
join
	trips_db.dim_city tr_dc
using
	(city_id)
group by 
	tr_dc.city_name
limit 3)
union
(Select
	DENSE_RANK() OVER (ORDER BY SUM(total_passengers) DESC) as"Top 3 / Bottom 3",
    tr_dc.city_name,
    sum(total_passengers) as total_new_passengers
from 
	trips_db.fact_passenger_summary tr_fps
join
	trips_db.dim_city tr_dc
using
	(city_id)
group by 
	tr_dc.city_name
order by
	total_new_passengers ASC
limit 3)