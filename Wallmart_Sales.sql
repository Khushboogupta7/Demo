USE walmart;

SELECT *  FROM sales;
-- 01. Add a new column time_of_day to give insight of sales in morning, afternooon, evening
-- Which part of day most sales are closed. 

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);
UPDATE sales
SET time_of_day = (
	CASE 
		WHEN 'time' BETWEEN "00:00:00" AND "12:00:00" THEN 'Morning'
        WHEN 'time' BETWEEN "12:00:00" AND "16:00:00" THEN 'Afternoon'
        ELSE 'Evening'
	END
); 

-- 02.   Add a new column day_name that contains extracted days of week on which given transaction took place 
-- (Mon, Tue, Wed, Thu , Fri)  Which day each branch is busiest?

ALTER TABLE sales ADD COLUMN day_name VARCHAR(20);
UPDATE sales
SET day_name = DAYNAME(Date);


-- 03.  Add a new column month_name that contains the extracted months of the year on which given transactions took place
 -- (Jan, Feb, Mar) . Help determine which month has most sales and profit
 
 ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);
UPDATE sales
SET month_name = monthname(Date);

-- Generic Questions 


-- 01. How many unique citiies and branch does the data have?

SELECT DISTINCT City, Branch
FROM sales;


-- Product

-- 01. How many unique product lines does the data have?  

SELECT product_line
FROM sales;

-- 02. What is the most common payment method?  

SELECT * FROM sales;
SELECT payment, COUNT(payment) as CNT FROM sales
GROUP BY payment
ORDER BY CNT DESC
LIMIT 1;

-- 03. What is the most selling priduct line? 

SELECT 'Product line', COUNT('Product line') AS A
FROM sales
GROUP BY 'Product line'
ORDER BY A DESC;


-- 04. What is total Revenue by month

 SELECT  month_name, SUM(Total) AS total_revenue
 FROM sales
 GROUP BY month_name
 ORDER BY total_revenue DESC;


-- 05. What month has largest cogs

SELECT * FROM sales;
 SELECT month_name AS month, SUM(cogs) AS cogs
 FROM sales
 GROUP BY month_name
 ORDER BY cogs DESC
;

-- 06. What Product line  has highest revenue
SELECT 'Product line' , SUM(Total) Revenue
FROM sales
GROUP BY 'Product line' 
ORDER BY Revenue;


-- 07. What city has largest revenue
SELECT 
	branch,city, SUM(Total) AS Revenue
 FROM sales
 GROUP BY city, branch
 ORDER BY Revenue DESC
;

-- 08.What product line has the largest VAT?

SELECT * FROM sales; 
SELECT 'Product line' AS Pl, 'Tax 5%'
FROM sales
GROUP BY 'Product line'
ORDER BY 'Tax 5%' desc;


