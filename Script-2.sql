select *
from batch_kmb.order_details_csv odc

-- Question 1
-- get total sales
select 
	sum(sales) as total_sales,
	sum(quantity) as tatal_qty
from batch_kmb.order_details_csv

select *
from batch_kmb.order_details_csv odc

-- Question 2
-- Get total profit per category
select
	category,
	sum(total_profit) as total_profit_per_category
from batch_kmb.order_details_csv odc
group by category
order by 2 desc 

select *
from batch_kmb.order_details_csv odc

-- Question 3
-- What are the unique category & sub-category in the table
select distinct 
	category,
	sub_category
from batch_kmb.order_details_csv odc
order by 1,2

-- Question 4
-- How many orders?
select 
	count(distinct "?order_id") as total_order
from batch_kmb.order_details_csv

--Question 5
-- Total profit per category, sort by largest to lower profit
select 	
	category,
	sum(total_profit) as total_profit_per_category
from batch_kmb.order_details_csv
group by 1
order by 2 desc 

-- Question 6
-- Avg & Median profit per order 
select 
	avg(total_profit) as avg_profit_per_order,
	percentile_cont(0.5) within group (order by total_profit) as median_profit_per_order 
from batch_kmb.order_details_csv
--Notes nilai percentile_cont dapat diubah menjadi 0.25;0.5;0,75;1 sesuai dengan Q1,Q2,Q3,Q4

-- Question 7
-- Top 5 sub category with highest total profit
select 
	sub_category,
	sum(total_profit) as total_profit_per_category
from batch_kmb.order_details_csv
group by 1
order by 2 desc 
limit 5

--Question 8
-- Total qty sold for furniture
select 
	category,
	sum(quantity) as total_qty_sold
from batch_kmb.order_details_csv
where category = 'Furniture'
group by 1

-- Question 9
-- Total profit per category
-- Untuk furniture kurs dalam USD (times by 14000)
-- untuk office supplies kurs dalam Poundsterling (times by 19000)
-- untuk technology times by 5000
select 	
	category,
	case 
		when category = 'Furniture' then sum(total_profit*14000)
		when category = 'Office Supplies' then sum(total_profit*19000)
		when category = 'Technology' then sum(total_profit*5000)
		end as total_profit_in_rupiah
from batch_kmb.order_details_csv
group by 1

