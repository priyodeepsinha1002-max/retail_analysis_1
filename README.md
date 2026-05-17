# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),	
    quantiy FLOAT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

2. Data Exploration & Cleaning
Record Count: Determine the total number of records in the dataset.  

Customer Count: Find out how many unique customers are in the dataset.

SELECT * FROM retail_sales;

SELECT COUNT(*) FROM retail_sales;

-- Detect Null Values
SELECT * FROM retail_sales WHERE age IS NULL;
SELECT * FROM retail_sales WHERE quantiy IS NULL;
SELECT * FROM retail_sales WHERE price_per_unit IS NULL;
SELECT * FROM retail_sales WHERE cogs IS NULL;
SELECT * FROM retail_sales WHERE total_sale IS NULL;

-- Delete Records with Null Values
DELETE FROM retail_sales
WHERE
    age IS NULL OR
    quantiy IS NULL OR
    price_per_unit IS NULL OR
    cogs IS NULL OR
    total_sale IS NULL;

3. Data Analysis & Findings
The following SQL queries were developed to answer specific business questions:  

Write a SQL query to retrieve all columns for sales made on '2022-11-05':
SELECT * FROM retail_sales 
WHERE sale_date = '2022-11-05';

Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than or equal to 4 in the month of Nov-2022:
SELECT *
FROM retail_sales
WHERE category = 'Clothing' 
  AND quantity >= 4 
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';

(Note: Column name updated from quantiy to quantity prior to running this query via: ALTER TABLE retail_sales RENAME COLUMN quantiy TO quantity;)

Write a SQL query to calculate the total sales (total_sale) for each category:
SELECT 
    DISTINCT category,
    SUM(total_sale) AS total_sale,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;

Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category:
SELECT AVG(age) AS average_age
FROM retail_sales
WHERE category = 'Beauty';

Write a SQL query to find all transactions where the total_sale is greater than 1000:
SELECT * FROM retail_sales
WHERE total_sale > 1000;

Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category:
SELECT 
    gender, 
    category, 
    COUNT(transactions_id) AS total_number_of_transactions
FROM retail_sales
GROUP BY gender, category
ORDER BY total_number_of_transactions DESC;

Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
WITH monthly_ranking AS (
    SELECT
        EXTRACT(YEAR FROM sale_date) AS year, 
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS average_sale_for_each_month,
        RANK() OVER(
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS sales_rank 	
    FROM retail_sales
    GROUP BY 1, 2
)
SELECT 
    year, 
    month, 
    average_sale_for_each_month
FROM monthly_ranking 
WHERE sales_rank = 1;

Write a SQL query to find the top 5 customers based on the highest total sales:
SELECT customer_id, SUM(total_sale) AS total 
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

Write a SQL query to find the number of unique customers who purchased items from each category:
SELECT COUNT(DISTINCT customer_id) AS unique_customers, category
FROM retail_sales
GROUP BY category;

Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
SELECT 
    CASE 
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shifts,
    COUNT(transactions_id) AS nos_of_order
FROM retail_sales
GROUP BY 1
ORDER BY nos_of_order DESC;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------Findings
Customer Demographics: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.

High-Value Transactions: Several transactions had a total sale amount greater than 1000, indicating premium purchases.

Sales Trends: Monthly analysis using structural window functions shows variations in sales, helping identify peak seasons and top-performing periods year-by-year.

Customer Insights: The analysis identifies top-spending customers, unique customer counts across item categories, and order traffic concentrations across morning, afternoon, and evening shifts.

Conclusion
This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.  

How to Use
  
Clone the Repository: Clone this project repository from GitHub.  

Set Up the Database: Run the schema creation query provided in the documentation to build your table structure.  

Run the Queries: Execute the provided analysis scripts inside your pgAdmin or SQL editor environment to evaluate business metrics.

 

Category Count: Identify all unique product categories in the dataset.  

Null Value Check: Check for any null values in the dataset and delete records with missing data.
