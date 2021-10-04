select 
	* 
from batch_kmb.order_details_csv odc 

-- untuk menampilkan data
select
	category,
	sub_category,
	sum(quantity) as total_quantity_sold,
	count('order_id') as total_order,
	avg(total_cost) as avg_total_cost,
	sum(sales) as total_sales,
	sum(total_profit) as total_profit
from batch_kmb.order_details_csv odc 
group by 1,2

-- Top 5 berdasarkan highest sales sub_category
select
	sub_category,
	sum(sales) as total_sales
from batch_kmb.order_details_csv odc 
group by 1
order by 2 desc 
limit 5

-- Top 5 berdasarkan highest cost in sub_category
select
	sub_category,
	avg(total_cost) as avg_total_cost
from batch_kmb.order_details_csv odc 
group by 1
order by 2 desc 
limit 5

-- Top 5 berdasarkan highest profit in sub_category
select
	sub_category,
	sum(total_profit) as total_profit
from batch_kmb.order_details_csv odc 
group by 1
order by 2 desc 
limit 5

-- Top 3 lowest sub_category by Sales
select
	sub_category,
	sum(sales) as total_sales
from batch_kmb.order_details_csv odc 
group by 1
order by 2 asc 
limit 3

-- Top 3 lowest sub-category by orders
select
	sub_category,
	count('order_id') as total_order
from batch_kmb.order_details_csv odc 
group by 1
order by 2 asc 
limit 3
