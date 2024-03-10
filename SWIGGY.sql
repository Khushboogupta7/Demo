CREATE DATABASE SWIGGY;
USE SWIGGY;
SELECT * FROM items;
SELECT * FROM orders;
  -- 01. How many distinct items were ordered?
  
SELECT COUNT(DISTINCT name) FROM items;

-- 02. Overall distribution of veg and non veg items

SELECT  is_veg, COUNT(is_veg) 
FROM items
WHERE is_veg = 1;

-- 03. Count where name came chicken

SELECT * FROM items
WHERE name LIKE '%chicken%'; 

-- 04. Average items per order

SELECT count(name)/count(distinct order_id)  as avgitemsperorder
FROM items;

-- 05. How many time seach item was ordered?

SELECT name, count(*) 
FROM items
GROUP BY name
ORDER BY COUNT(*) DESC;


-- 06. How many different restaurants from where food got orderd?


 SELECT  DISTINCT(restaurant_name)
 FROM orders;
 
 
 
 -- 07. Select the favourite restaurant which is ordered the most
 
 SELECT * FROM orders;
 SELECT restaurant_name, COUNT(*)
 FROM orders
 GROUP BY restaurant_name
 ORDER BY COUNT(*)DESC;
 
 -- 08. What was the month which had most number of orders?
 
 SELECT monthname(order_time), COUNT(DISTINCT order_id)
 FROM orders
 GROUP BY monthname(order_time)
 ORDER BY COUNT(DISTINCT order_id) DESC;
 
 SELECT CONCAT(YEAR(order_time), '-',MONTH(order_time) ) AS Date,COUNT(DISTINCT order_id)
 FROM orders
 GROUP BY Date
 ORDER BY COUNT(DISTINCT order_id) DESC;


-- 09. When is last or recent  order ordered?

SELECT MAX(order_time)
FROM orders;

-- 10. TOTal revenue
SELECT * FROm orders;
SELECT  CONCAT(YEAR(order_time), '-',MONTH(order_time) ) AS Date, SUM(order_total) AS Total_Revenue
FROM orders
GROUP BY date
ORDER BY Total_Revenue DESC;

-- 11. On average per order how much do customer spend?

 SELECT * FROM orders;
 
 SELECT SUM(order_total)/COUNT(DISTINCT(order_id)) AS AOV
 FROM orders;
 
 -- 12. Every year spent on Swiggy, YoY change in Revenue
 
 SELECT Year(order_time), SUM(order_total)
 FROM orders
 GROUP BY Year(order_time);
 
 WITH final AS (
SELECT Year(order_time), SUM(order_total) AS Revenue
FROM orders
GROUP BY Year(order_time))
 
SELECT Year(order_time), Revenue, LAG (Revenue) OVER(ORDER BY Year(order_time)) AS Previous_Revnue
FROM final;
  
  
  -- Another Way 
  WITH yearly_revenue AS (
  SELECT YEAR(order_time) AS order_year, 
         SUM(order_total) AS revenue
  FROM orders
  GROUP BY YEAR(order_time)
)
SELECT 
  t1.order_year, 
  t1.revenue, 
  LAG(t1.revenue) OVER (ORDER BY t1.order_year) AS previous_revenue
FROM yearly_revenue t1;

-- 13.  Ranking

  WITH yearly_revenue AS (
  SELECT YEAR(order_time) AS order_year, 
         SUM(order_total) AS revenue
  FROM orders
  GROUP BY YEAR(order_time)
)
SELECT 
  t1.order_year, 
  t1.revenue, 
  RANK() OVER (ORDER BY t1.Revenue) AS ranking FROM yearly_revenue t1;
  
  -- 14. Ranking as per restaurant
  
WITH yearly_revenue AS (
  SELECT restaurant_name,
         SUM(order_total) AS revenue
  FROM orders
  GROUP BY restaurant_name
)
SELECT 
  t1.restaurant_name, 
  t1.revenue, 
  RANK() OVER (ORDER BY t1.Revenue) AS ranking FROM yearly_revenue t1;  
  
  
  -- 15. Revenue distributiion according to rain mode
 SELECT * FROM orders; 
 SELECT rain_mode, SUM(order_total)
 FROM orders
 GROUP BY rain_mode;