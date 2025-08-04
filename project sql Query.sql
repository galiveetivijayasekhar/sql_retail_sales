-- SQL Retail Sales Analysis -p1
CREATE DATABASE sql_project_p2;
-- Create table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
         (
          transactions_id	INT PRIMARY KEY,
          sale_date DATE,
		  sale_time TIME,
		  customer_id INT,
		  gender VARCHAR(15),
		  age INT,
		  category VArCHAR(15),
		  quantiy	INT,
		  price_per_unit FLOAT,
		  cogs FLOAT,
		  total_sale FLOAT
		  );
SELECT * FROM retail_sales;
limit 10
SELECT
COUNT(*)
FROM retail_sales

-- Data Cleaning

SELECT * FROM retail_sales
WHERE transactions_id is NULL

SELECT * FROM retail_sales
WHERE sale_date is NULL

SELECT * FROM retail_sales
WHERE sale_time is NULL

SELECT * FROM retail_sales
where 
     transactions_id is null
	 OR
	 sale_date is NULL
	 OR
	 sale_time IS NULL
	 OR
	 gender is NULL
	 OR
	 category is NULL
	 OR
	 quantiy is NULL
	 OR
	 cogs is NULL
	 or
	 total_sale is NULL

	 --
DELETE FROM retail_sales
WHERE
      
     transactions_id is null
	 OR
	 sale_date is NULL
	 OR
	 sale_time IS NULL
	 OR
	 gender is NULL
	 OR
	 category is NULL
	 OR
	 quantiy is NULL
	 OR
	 cogs is NULL
	 or
	 total_sale is NULL

-- Data  Exploration
-- how many sales we have?

SELECT COUNT(*) as total_sale FROM retail_sales

-- how many uniques customers we have?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales


SELECT DISTINCT category  FROM retail_sales key problem & answers


-- Data Analysis & Business key problems & answers

-- my analysis & findings

-- Q1 write a Sql query to retrive all columns for sales made on '2022-11-05'
--Q2 write a SQL query to retrive all transactions where the category is 'clothing' and teh quantity
 slod is more than 4 in the month of nov_2022
 --Q3. write a sql query to calculate the total sales(total_sale) for each category.
 -- Q4. write a sql query to find the average age of customers who purchased items from the 'Beauty' category.
 -- Q5. write a sql query to find all transactions where the total_sale is graeter than  1000.
 -- Q6. write a sql query to find the total number of transactions (transactiom_id) made by each gender in each category.
 -- Q7. write a sql query to calculate teh averahe sale of each month. find out best selling month in each year.
 -- Q8. write a sql query to find the top 5 customers based on the highest total sales.
 -- Q9. write a sql query to find the number of unique customers who purchased items from each category.
 -- Q10. write a sql query to create each shift and number of orders(Example morning <=12, Afternoon between 12 & 17, Evening >17)
 
 
 -- Q.1 write a Sql query to retrive all columns for sales made on '2022-11-05'
 SELECT * 
 FROM retail_sales
 WHERE  sale_date= '2022-11-05';

--Q2 write a SQL query to retrive all transactions where the category is 'clothing' and teh quantity
    slod is more than 4 in the month of nov_2022

SELECT
   *
FROM retail_sales
WHERE category = 'Clothing'
AND
TO_CHAR(sale_date, 'YYYY-MM-DD') = '2022-11'
AND
quantiy >=4

--Q3. write a sql query to calculate the total sales(total_sale) for each category.
SELECT
  category,
  SUM(total_sale) as net_sale,
  count(*) as total_orders
  
FROM retail_sales
GROUP BY 1


 -- Q4. write a sql query to find the average age of customers who purchased items from the 'Beauty' category.


SELECT 
ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'

-- Q5. write a sql query to find all transactions where the total_sale is graeter than  1000.

SELECT * FROM retail_sales
WHERE  total_sale >1000

 -- Q6. write a sql query to find the total number of transactions (transactiom_id) made by each gender in each category.

 SELECT 
   category,
   gender,
   COUNT(*) as total_trans
FROM retail_sales
GROUP
  BY
  category, gender
ORDER BY 1

 -- Q7. write a sql query to calculate teh averahe sale of each month. find out best selling month in each year.
SELECT * FROM
(

SELECT 
EXTRACT(YEAR FROM sale_date) as year,
EXTRACT(month from sale_date) as month,
AVG(total_sale) as avg_sale,
RANK () OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale)DESC) as rank
FROM retail_sales
GROUP BY 1,2
) as t1
WHERE rank =1
ORDER BY 1,3 DESC

 -- Q8. write a sql query to find the top 5 customers based on the highest total sales
 SELECT 
 customer_id,
 SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
 FROM retail_sales

 -- Q9. write a sql query to find the number of unique customers who purchased items from each category.
 
 
 SELECT 
 category, 
 COUNT(DISTINCT customer_id) as cnt_unique_cs
 
FROM retail_sales
GROUP BY category


 -- Q10. write a sql query to create each shift and number of orders(Example morning <=12, Afternoon between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
 SELECT *,
  CASE 
    WHEN EXTRACT (HOUR FROM sale_time)< 12  THEN 'Morning'
    WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
  
    ELSE 'Evening'
  END  as shift
 FROM retail_sales
 )
 SELECT
  shift,
  COUNT(*) as total_orders
  FROM hourly_sale
 GROUP BY shift
 -- end of project 1
 
