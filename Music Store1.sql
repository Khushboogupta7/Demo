-- Creating Schema for Music Store

CREATE SCHEMA Music_Store;
USE Music_Store;
SELECT * FROM Music_Store.album_2;
SELECT * FROM Music_Store.artist;
SELECT * FROM Music_Store.customer;
SELECT * FROM Music_Store.employee;
SELECT * FROM Music_Store.genre;
SELECT * FROM Music_Store.invoice;
SELECT * FROM Music_Store.invoice_line;
SELECT * FROM Music_Store.media_type;
SELECT * FROM Music_Store.playlist;
SELECT * FROM Music_Store.track;

-- 01. Senior Employee based on job title--
SELECT * 
FROM employee
ORDER BY levels DESC
limit 1;


-- 02. Which countries have the most invoives?--
SELECT * FROM invoice;  
SELECT COUNT(*) AS c,billing_country
FROM invoice
GROUP BY billing_country
ORDER BY c DESC
LIMIT 1;

-- 03. Top 3 value of total invoices--
SELECT total
FROM invoice
ORDER BY total DESC
LIMIT 3;
 
-- 04 Which city has the best customers. Write a query that return one city
-- that has the highest sum of invoices totals. Return both city name and sum of invoice total.-- 

SELECT billing_city, SUM(total) AS invoice_total
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total DESC 
LIMIT 1;

-- Who is the best customer. Write a query tha treturns the person 
-- who has spent the most money--  

SELECT 
    customer.customer_id, 
    customer.first_name, 
    customer.last_name, 
    SUM(invoice.total) AS Total
FROM 
    customer
JOIN 
    invoice
ON 
    customer.customer_id = invoice.customer_id
GROUP BY 
    customer.customer_id, customer.first_name, customer.last_name
ORDER BY 
    Total DESC
LIMIT 1;