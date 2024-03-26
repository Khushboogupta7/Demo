-- SQL Window Functions Practice Exercises: Health Clinic
-- Dataset
-- The following exercises use a health clinic database that contains two tables.

-- The doctor table stores information about doctors. 
-- The columns are id, first_name, last_name, and age.

-- The procedure table contains information about procedures performed by doctors on patients. 
-- The columns are id, procedure_date, doctor_id (references the doctor table), patient_id, category, name, price, and score.


Exercise 4: Calculate Moving Average for Scores

For each procedure, show the following information: procedure_date, doctor_id, category, name, score and the average score 
from the procedures in the same category which are included in the following window frame: 
the two previous rows, the current row, and the three following rows in terms of the procedure date.

SELECT procedure_date, doctor_id, category, name, score,
AVG(score)OVER (PARTITION BY category ORDER BY procedure_date,ROWS BETWEEN 2 PREECEDING AND 3 FOLLOWING )
FROM procedure;

-- Solution explanation:

-- We are going to show information for each procedure by selecting from the procedure table.

-- Then we’ll find the average score from the procedures in the same category. 
-- To do that, we use the AVG() function with the score column as its argument. 
-- This is followed by the OVER() clause, where we partition the dataset into categories.

-- Additionally, we must consider only rows included in the following window frame: 
-- the two previous rows, the current row, and the three following rows in terms of the procedure date. 
-- We define this data frame within the OVER() clause. First, we order the dataset by the procedure_date column 
-- so the procedures are listed chronologically. And then we define the rows to be considered for calculating the average score value: 
-- two previous rows (BETWEEN 2 PRECEDING) and three following rows (AND 3 FOLLOWING), including the current row.
-------------------------------------------------------------------------------------------------------------------------------------------------

Exercise 5: Find the Difference Between Procedure Prices

For each procedure, show the following information: id, procedure_date, name, price, price of the previous procedure 
(in terms of the id) and the difference between these two values. Name the last two columns previous_price and difference.

SELECT
  id,
  procedure_date,
  name,
  price,
  LAG(price) OVER(ORDER BY id) AS previous_price,
  price - LAG(price) OVER(ORDER BY id) AS difference
FROM procedure;

-- Solution explanation:

-- Again, we start by selecting information about each procedure from the procedure table.

-- The instruction says to show the price of the previous procedure. To do that, we use the LAG() function, 
-- which returns the previous row value for its argument (here, for the price column). 
-- To ensure that we choose the previous procedure price in terms of the id, we order the dataset by the id column in the OVER() clause. 
-- We alias it as previous_price.

-- Now that we have the price value and the previous price value, we can select the difference between these two values. 
-- We simply subtract the LAG() function from the price column and alias it as difference.


-----------------------------------------------------------------------------------------------------------------------------------------------

Exercise 6: Find the Difference Between the Current and Best Prices

For each procedure, show the:

procedure_date
name
price
category
score
Price of the best procedure (in terms of the score) from the same category (column best_procedure).
Difference between this price and the best_procedure (column difference).


SELECT
  procedure_date,
  name,
  price,
  category,
  score,
  FIRST_VALUE(price) OVER(PARTITION BY category ORDER BY score DESC)
     AS best_procedure,
  price - FIRST_VALUE(price) OVER(PARTITION BY category
     ORDER BY score DESC) AS difference
FROM procedure;


-- We start by selecting information about each procedure from the procedure table.

-- The next step is to find the price of the best procedure. We use the FIRST_VALUE() function, which returns the first value in an ordered partition of a result set. To get the price of the best procedure from the same category, we must partition the dataset by the category column. And to get the price of the best procedure in terms of score, we must order the dataset by the score column in descending order. We alias this expression as best_procedure.

-- Lastly, we find the difference between price and best_procedure by subtracting the FIRST_VALUE() function from the price column.

-----------------------------------------------------

Exercise 7: Find the Best Doctor per Procedure.

Find out which doctor is the best at each procedure. For each procedure, select the procedure name and 
the first and last name of all doctors who got high scores (higher than or equal to the average score for this procedure). 
Rank the doctors per procedure in terms of the number of times they performed this procedure. 
Then, show the best doctors for each procedure, i.e. those having a rank of 1.

WITH cte AS (
  SELECT
    name,
    first_name,
    last_name,
    COUNT(*) c,
    RANK() OVER(PARTITION BY name ORDER BY count(*) DESC) AS rank
  FROM procedure p
  JOIN doctor d
    ON p.doctor_id = d.id
  WHERE score >= (SELECT avg(score)
                  FROM procedure pl
                  WHERE pl.name = p.name)
  GROUP BY name, first_name, last_name
)
 
SELECT
  name,
  first_name,
  last_name
FROM cte
WHERE rank = 1;
Solution explanation:

-- First, we select the procedure name and information about doctors, so we join the procedure table with the doctor table 
-- on their common column (doctor_id).

-- We want to select all doctors who got high scores (higher than or equal to the average score for this procedure). 
-- To do that, we define the WHERE clause condition for the score column.
-- The score column must store a value equal to or greater than the average score for the current row’s procedure.

-- Let's rank the doctors per procedure. We'll use the RANK() function with the OVER() clause, 
-- where we partition the dataset by the procedure name. 
-- Additionally, we must rank in terms of the number of times the doctor performed this procedure. 
-- To get the number of times the doctor performed this procedure, we must COUNT(*) while grouping by the procedure name 
-- and the first and last name of the doctor (that is, we are grouping by all columns listed in the SELECT statement).

-- All we’ve done until now is define a Common Table Expression (CTE), which is the inner SELECT statement enclosed by 
-- the WITH clause and named cte.

