select 
	*
from batch_kmb.citibike_stations_csv 

select 
	*
from batch_kmb.citibike_trips_csv

-- Question 1
-- find the oldest age of the subscriber for unknown
select distinct 
	usertype,
	birth_year,
	gender
from batch_kmb.citibike_trips_csv
where usertype = 'Subscriber'
	and gender = 'unknown'
group by 1,2,3
order by 2 desc 
limit 1

-- Question 2
-- Find monthly growth of trips (use starttime) in percetage, ordered by descendingly
-- Only for trips that end in Greenwich. Greenwich = station name contains the word "greenwich"
with 
total_trip as(
	select 
		date_trunc('month',to_date(starttime,'YYYY-MM-DD')) as date_trip, 
		end_station_name,
		cast(count(starttime) as DECIMAL(19,2) )as total_trip_permonths
	from batch_kmb.citibike_trips_csv ctc
	where end_station_name like '%Greenwich%'
	group by 1,2
	order by 1 desc 
	
),
make_lag as(
	select 
		* ,
		lag(total_trip_permonths, 1) over(order by date_trip) as last_total_trip_permonths
	from total_trip
)
select 
	*,
	cast(100*((total_trip_permonths-last_total_trip_permonths)/last_total_trip_permonths) as decimal(19,2)) || '%' as monthly_growth
from make_lag

-- Question 3
-- Get trips with start_station_id that were not present at the citibike_station table
-- What percentage of these trips end up end_station_id which are also not present in the station table

-- Menghitung start_station_id
with 
hitung_start_station as(
	select 
		start_station_id ,
		count(start_station_id) as jumlah_trip_start_station
	from batch_kmb.citibike_trips_csv
	left join batch_kmb.citibike_stations_csv
		on batch_kmb.citibike_trips_csv."start_station_id" = batch_kmb.citibike_stations_csv."station_id" 
	where batch_kmb.citibike_stations_csv."station_id" is null
	group by 1
)
select 
	count(distinct start_station_id) as total_start_station
from hitung_start_station

-- Menghitung end_station
with 
hitung_end_station as(
	select 
		end_station_id ,
		count(end_station_id) as jumlah_trip_end_station
	from batch_kmb.citibike_trips_csv
	left join batch_kmb.citibike_stations_csv
		on batch_kmb.citibike_trips_csv."start_station_id" = batch_kmb.citibike_stations_csv."station_id" 
	where batch_kmb.citibike_stations_csv."station_id" is null
	group by 1
)
select 
	count(distinct end_station_id) as total_end_station
from hitung_end_station

-- Percentage of trip start in start_station_id that were not present at citibike_station table
with 
percentage_start_station as(
	select 
		start_station_id,
		count(start_station_id) as total_trip_start_station
	from batch_kmb.citibike_trips_csv
	left join batch_kmb.citibike_stations_csv
		on batch_kmb.citibike_trips_csv."start_station_id" = batch_kmb.citibike_stations_csv."station_id" 
	where batch_kmb.citibike_stations_csv."station_id" is null
	group by 1
)
select 
	*,
	cast(100*(cast(total_trip_start_station as decimal(19,2))/84) as decimal (19,2)) || '%' as percentage_trip_start_station
from percentage_start_station
order by 1 asc 

-- Percentage of trip end in end_station_id that were not present at citibike_station table
with 
percentage_end_station as(
	select 
		end_station_id,
		count(end_station_id) as total_trip_end_station
	from batch_kmb.citibike_trips_csv
	left join batch_kmb.citibike_stations_csv
		on batch_kmb.citibike_trips_csv."start_station_id" = batch_kmb.citibike_stations_csv."station_id" 
	where batch_kmb.citibike_stations_csv."station_id" is null
	group by 1
)
select 
	*,
	cast(100*(cast(total_trip_end_station as decimal(19,2))/84) as decimal (19,2)) || '%' as percentage_trip_end_station
from percentage_end_station
order by 1 asc 

-- Question 4
-- What is the region_id that has the longest avg tripduration
with
raw_1 as(
	select
		name,
		region_id,
		tripduration
	from batch_kmb.citibike_stations_csv
	left join batch_kmb.citibike_trips_csv
		on batch_kmb.citibike_stations_csv."station_id"	= batch_kmb.citibike_trips_csv."start_station_id"
)
select 
	region_id,
	avg(tripduration) as avg_tripduration
from raw_1
group by 1
order by 2 asc 
