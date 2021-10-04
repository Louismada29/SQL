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
