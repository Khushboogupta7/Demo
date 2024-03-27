-- Dataset
-- The following exercises use the website statistics database that contains two tables.

-- The website table stores information about websites. The columns are id, name, budget, and opened.

-- The statistics table stores statistics for each 
-- The columns are website_id (references the website table), day, users, impressions, clicks, and revenue.


----------------------------------------------------------------------------------------------------------------------------------------------------

Exercise 10: Look Ahead with the LEAD() Function
Exercise:

Take the statistics for the website with id = 2 between 1 and 14 May 2016 and show the day, the number of users, and 
the number of users 7 days later.

Note that the last 7 rows dont have a value in the last column. This is because no rows '7 days from now' can be found for them. 
For these cases, show -1 instead of NULL if no LEAD() value is found.

ELECT
  day,
  users,
  LEAD(users, 7, -1) OVER(ORDER BY day)
FROM statistics
WHERE website_id = 2
  AND day BETWEEN '2016-05-01' AND '2016-05-14';

-- Solution explanation:

-- We are going to show the day, the number of users, and the number of users 7 days later. 

-- The first two values come from the statistics table – these are the day and users columns. 
-- The last value must be calculated using the LEAD() function.

-- We want to see the users column value after seven days; therefore, we pass the users column as the first argument and 
-- the value of 7 as the second argument to the LEAD() function. And to ensure that we show -1 instead of NULL if no LEAD() value is found, 
-- we pass the third argument as -1.

-- The LEAD() function is followed by the OVER() clause. This clause contains the condition to order the dataset by the day column,
-- as the statistics should be ordered chronologically.

-- To show the statistics for the website with id = 2 between 1 and 14 May 2016, we need to define the relevant conditions in the WHERE clause.

---------------------------------------------------------------------------------------------------------------------------------------------------

Exercise 11: Look Back with the LAG() Function

Show the statistics for the website with id = 3 that include day, revenue, and the revenue 3 days before.
Show -1.00 for rows with no revenue value 3 days before.

SELECT
  day,
  revenue,
  LAG(revenue, 3, -1.00) OVER(ORDER BY day)
FROM statistics
WHERE website_id = 3;

-- Solution explanation:

-- We are going to show the day, revenue, and the revenue 3 days before. The first two values come from the statistics table –
--  these are the day and revenue columns. The last value must be calculated using the LAG() function.

-- We want to see the revenue column value from three days before the current row; therefore, 
-- we pass the revenue column as the first argument and the value of 3 as the second argument to the LAG() function. 
-- And to ensure that we show -1.00 for rows with no revenue value 3 days before, we pass the third argument as -1.00.

-- The LAG() function is followed by the OVER() clause. This contains the condition to order the dataset by the day column, 
-- as the statistics should be ordered chronologically.

-- To show the statistics for the website with id = 3, we need to define a condition in the WHERE clause.

---------------------------------------------------------------------------------------------------------------------------------------------------