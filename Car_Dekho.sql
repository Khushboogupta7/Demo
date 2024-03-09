CREATE SCHEMA cars;
USE CARS;

-- Read cars data
SELECT * FROM car_dekho;


-- Total cars = To get a total count of total records
SELECT COUNT(*) FROM car_dekho;


 -- How many cars will be available in 2023
 SELECT COUNT(*) 
 FROM car_dekho
 WHERE year = 2023;
 
 -- How many cars will be available in 2020, 2021, 2022
 SELECT COUNT(*) 
 FROM car_dekho
 WHERE year BETWEEN 2020 AND 2022;
 
 -- Display year wise
 SELECT COUNT(*) 
 FROM car_dekho
 WHERE year IN(2020, 2021, 2022)
 GROUP BY year;
 
 -- Print total cars by year
 SELECT year, COUNT(*) 
 FROM car_dekho
 GROUP BY year
 ORDER BY year ASC;
 
 -- Number of diesel cars in 2020
 
 SELECT COUNT(*)
 FROM car_dekho
 WHERE fuel = 'Diesel' AND year = 2020;
 
 
 -- Number of fuel cars in 2020
  SELECT COUNT(*)
 FROM car_dekho
 WHERE fuel = 'Petrol' AND year = 2020;
 
 -- All fuel cars year wise 
 
 SELECT  year,COUNT(*) 
 FROM car_dekho
 Where fuel = 'petrol'
 GROUP BY year;
 
  SELECT  year,COUNT(*) 
 FROM car_dekho
 Where fuel = 'Diesel'
 GROUP BY year;
 SELECT  year,COUNT(*) 
 FROM car_dekho
 Where fuel = 'CNG'
 GROUP BY year;
 
 -- Which year had more than 100 cars--
 
 SELECT year, COUNT(*)
 FROM car_dekho
 GROUP BY year
 HAVING COUNT(*)>100;
 
 
SELECT year, COUNT(*)
 FROM car_dekho
 GROUP BY year
 HAVING COUNT(*)<50;
 
  -- Count details between 2015 and 2023--
  
  SELECT COUNT(*)
  FROM car_dekho
  WHERE year BETWEEN 2015 AND 2023 ;
  
-- Complete details between 2015 to 2023--
 SELECT *
  FROM car_dekho
  WHERE year BETWEEN 2015 AND 2023 ;
