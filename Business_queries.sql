--SQL retail analysis-01

-- Create table

Create table retail_sales(

			transactions_id	int primary key,
			sale_date date,
			sale_time time,	
			customer_id	int,
			gender varchar(15),
			age	int,
			category varchar(15),	
			quantiy	float,
			price_per_unit float,	
			cogs float,
			total_sale float
);
select * from retail_sales 

select count(*) 
from retail_sales;

-- detect null

select * 
from retail_sales
where age
is null ;

select * 
from retail_sales
where quantiy
is null ;

select * 
from retail_sales
where price_per_unit
is null ;

select * 
from retail_sales
where cogs
is null ;

select * 
from retail_sales
where total_sale
is null ;
-----------

-- Delete the null

delete 
from retail_sales
where
age is null or
quantiy is null or
price_per_unit is null or
cogs is null or
total_sale is null;

select * from retail_sales 

-- Data exploration

-- How many sales we have?

select count(transactions_id) as total_sales
from retail_sales;

-- How many unique customers we have?

select count(distinct customer_id) as total_customers
from retail_sales;

-- How many categories we have?

select distinct category
from retail_sales;

--- Business quries and solution..

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * 
from retail_sales 
where sale_date= '2022-11-05';

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

select *
from retail_sales
where category= 'Clothing' 
and quantity>=4 
and to_char(sale_date, 'YYYY-MM')= '2022-11';

----
alter table retail_sales
rename column quantiy to quantity;
----

select * from retail_sales;

-- Write a SQL query to calculate the total sales (total_sale) for each category.

select 
distinct category,
sum(total_sale) as total_sale,
count(*) as total_orders
from retail_sales
group by category;

select * from retail_sales ;


-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category

select avg(age) as average_age
from retail_sales
where category= 'Beauty';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000

select * 
from retail_sales
where total_sale> 1000;

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category

select 
gender, category, count(transactions_id) as total_number_of_transactions
from retail_sales
group by 
gender, category
order by
total_number_of_transactions Desc;

select * from retail_sales ;


-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select * from(
select 
extract(year from sale_date) as year, 
extract(month from sale_date) as month,
avg(total_sale) as average_sale_for_each_month,
rank() over(partition by extract(year from sale_date)order by avg(total_sale) desc)
from retail_sales
group by 1,2

) as t1
where rank =1;
--------------------------------------------------
with monthly_ranking as(
select
extract(year from sale_date) as year, 
extract(month from sale_date) as month,
avg(total_sale) as average_sale_for_each_month,
rank() over(partition by extract(year from sale_date)
order by avg(total_sale)desc) as sales_rank 
	
from retail_sales
group by 1,2)

select 
year, month, average_sale_for_each_month
from monthly_ranking 
where 
sales_rank =1;


-- Write a SQL query to find the top 5 customers based on the highest total sales

select * from retail_sales;

select customer_id, sum(total_sale) as total 
from retail_sales
group by 1
order by 2 desc
limit 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category

select count(distinct customer_id) as unique_customers, category
from retail_sales
group by category;


-- select distinct customer_id, category
-- from retail_sales;

-- select count(customer_id) , category
-- from retail_sales
-- group by category;


-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

select 
case 
when extract (hour from sale_time)<12 then 'Morning'
when extract (hour from sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
end as shifts,
count (transactions_id) as nos_of_order
from
retail_sales
group by 1
order by nos_of_order desc;


SELECT * FROM retail_sales LIMIT 5;

