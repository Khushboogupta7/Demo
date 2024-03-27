-- Dataset
-- The following exercises use the athletic championships database that contains eight tables.

-- The competition table stores information about competitions. 
-- The columns are id, name, start_date, end_date, year, and location.

-- The discipline table stores information for all running disciplines (from the short-distance runs (e.g. the 100 meter) to 
-- the long-distance runs (e.g. the marathon)). The columns are id, name, is_men, and distance.

-- The event table stores information about the competition and discipline for each event. 
-- The columns are id, competition_id (references the competition table), and discipline_id (reference the discipline table).

-- The round table stores the rounds of each event. 
-- The columns are id, event_id (references the event table), round_name, round_number, and is_final.

-- The race table stores data for each race of each round. 
-- The columns are id, round_id (references the round table), round_name (same as in the round table), race_number, 
-- race_date, is_final (same as in the round table), and wind.

-- The athlete table stores information about athletes participating in the competition. 
-- The columns are id, first_name, last_name, nationality_id (references the nationality table), and birth_date.

-- The nationality table stores information about athlete’s countries of origin. 
-- The columns are id, country_name, and country_abbr.

-- The result table stores information for all participants of a particular event. 
-- The columns are race_id (references the race table), athlete_id (references the athlete table), result, place, is_dsq, is_dns, and is_dnf.


Exercise 8: Calculate the Difference Between Daily Wind Speed Averages

For each date in which there was a race, display the race_date, the average wind on this date rounded to three decimal points, and
the difference between the average wind speed  on this date and the average wind speed on the date before, also rounded to three decimal points. 
The columns should be named race_date, avg_wind, and avg_wind_delta.

SELECT
  race_date,
  ROUND(AVG(wind), 3) AS avg_wind,
  ROUND(AVG(wind) - LAG(AVG(wind)) OVER(ORDER BY race_date), 3)
     AS avg_wind_delta
FROM race
GROUP BY race_date;

-- Solution explanation:

-- We are going to display race information for each race date, so we select data from the race table.

-- To find the average wind speed on this date rounded to three decimal points, we use the AVG() function with the wind column as its argument. 
-- Then, we enclose it within the ROUND() function and round it to three decimal places. Note that we must group by the race_date column, 
-- since we use the AVG() aggregate function.

-- We can get the average wind on the date before by using the LAG() function with the AVG(wind) value as its argument. 
-- The OVER() clause defines that we order the entire dataset by the race_date column to have the data rows listed chronologically.

-- Since we want to see the difference between the average wind speed on this date and the average wind speed on the date before, 
-- we subtract LAG(AVG(wind)) from AVG(wind). 
-- And to round it to three decimal places, we use the ROUND() function again.

--------------------------------------------------------------------------------------------------------------------------------------------------

Exercise 9: Compare the Best and Previous Results
Exercise:

For each woman who ran in the final round of the womens marathon in Rio, display the following information:

The place they achieved in the race.
Their first name.
Their last name.
comparison_to_best : The difference between their time and the best time in this final.
comparison_to_previous : The difference between their time and the result for the athlete who got the next-highest
Sort the rows by the place column.

SELECT first_name , last_name , result.place
result -FIRST_VALUE(result) over(orderby(result)) AS comparison_to_best
result - LAG(result)OVER(ORDER BY (result)) AS comparison_to_previous
FROM competition
JOIN event
ON competition.id = event.competition_id
JOIN discipline
ON discipline_id = event.discipline_id
JOIN round
  ON event.id = round.event_id
JOIN race
  ON round.id = race.round_id
JOIN result
  ON result.race_id = race.id
JOIN athlete
  ON athlete.id = result.athlete_id
WHERE competition.name = 'Rio de Janeiro Olympic Games'
  AND discipline.name = 'Women''s Marathon'
  AND round.is_final IS TRUE
ORDER BY place;

-- Solution explanation:

-- We are going to use information about competitions, disciplines, rounds, athletes, and results. 
-- Therefore, we must join all these tables on their common columns, as mentioned in the dataset introduction.

-- The instruction says to display information for each woman who ran in the final round of the women's marathon in Rio. 
-- We cover it in the WHERE clause that contains the following conditions:

-- The competition name must be Rio de Janeiro Olympic Games.
-- The discipline name must be Women's Marathon.
-- The round must be the final round.
-- Next we select the place column from the result table and the first_name and last_name columns from the athlete table.

-- To find the difference between their time and the best time in this final, we use the FIRST_VALUE() function with 
-- the result column as its argument. This is followed by the OVER() clause, which orders the dataset by the result column. 
-- Then we subtract this FIRST_VALUE() function from the current row result. We alias it as comparison_to_best.

-- To find the difference between their time and the result for the athlete who got the next-better place, 
-- we use the LAG() function with the result column as its argument to get the previous result. Once again, 
-- this is followed by the OVER() clause to order the dataset by the result column (to ensure we get the next better result). 
-- Then we subtract this LAG() function from the current row result. We alias it as comparison_to_previous.

-- Finally, we sort the rows by the place column using the ORDER BY clause.

--------------------------------------------------------------------------------------------------------------------------------------




