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


-- 03.  dd a new column month_name that contains the extracted months of the year on which given transactions took place
 -- (Jan, Feb, Mar) . Help determine which month has most sales and profit
 
 ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);
UPDATE sales
SET month_name = monthname(Date);

