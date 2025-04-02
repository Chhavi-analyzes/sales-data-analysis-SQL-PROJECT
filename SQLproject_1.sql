select * from retail_sales
where category='clothing' 
AND
quantity >= 4 ;
-- 3. sql query to calculate the total sales for each catedory.

SELECT 
	category, 
	SUM(total_sale) as net_sale
FROM retail_sales
GROUP BY 1;

-- 4. SQL query to find the average age of customers who purchased the item from' beauty'
SELECT 
     ROUND(AVG(age),2) as average_age
     FROM retail_sales
	 WHERE category='beauty';
-- 5. SQL query to find all transactions where the total_sales is greater 1k
  SELECT * FROM retail_sales
  WHERE total_sale> 1000;
  -- 6. sql query to find the total number of transactions made by each gender in each category.
  SELECT 
      category,
      gender,
      COUNT(*) as total_trans
  from retail_sales
  GROUP BY
        category,
        GENDER
ORDER BY 1;
-- 7. SQL query to calculate the average sale of each month. find out the best selling month in each year. 
SELECT * from
(
SELECT
     EXTRACT( YEAR FROM sale_date) as year,
	 EXTRACT( MONTH FROM sale_date)as month,
	 AVG(total_sale) as avg_sale,
     rank() over(partition by Extract( year from sale_date) order by avg(total_sale) desc) as ranks
FROM retail_sales
group by 1,2
) AS T1
where ranks = 1
Order by 1, 3 desc;
-- SQL quey to find the top 5 customers based on the highest total sales .
SELECT 
	customer_id,
	SUM(total_sale) as net_sale
FROM retail_sales
group by 1
order by 2 desc
limit 5;
-- SQL query to find the number of unique customers who purchased items from each category 
SELECT 
    count( distinct customer_id) as unique_customer,
     category 
from retail_sales 
group by category;
    
-- SQL query to create each shift of orders
with hourly_sale
AS
(
select *,
   CASE
   WHEN extract(hour from sale_time)< 12 THEN 'Morning'
   WHEN extract(hour from sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
   ELSE 'evening'
   END as shift 
FROM retail_sales
)
SELECT
shift,
count(*) as total_orders
from hourly_sale
Group by shift 
-- end of project
 