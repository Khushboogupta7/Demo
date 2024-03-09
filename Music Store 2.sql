USE music_store;
--  set 2 moderate--
-- 01. Write a query to return the email, first_name, last name
-- & genre of all rock music listeners. REturn list ordered alphabetically
-- by email starting with A--

SELECT DISTINCT email, first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN (
  SELECT track_id FROM track
  JOIN genre ON track.genre_id = genre.genre_id
  WHERE genre.name LIKE 'Rock')
ORDER BY email;


-- 02.  Write  a query that returns the Artist name and
--  total track count of the top 10 rock bands-- 


SELECT artist.artist_id, artist.name, COUNT(track.track_id) AS number_of_songs
FROM track
JOIN album_2 ON album_2.album_id = track.album_id
JOIN artist ON artist.artist_id = album_2.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id, artist.name
ORDER BY number_of_songs DESC
LIMIT 10;


-- 03.Return all track names that have a song length  
-- longer than the average song length.
-- return the name and millisecond for each track.
-- and with longest songs listed first. 
 
SELECT name ,milliseconds 
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS Avg_tracklength
	FROM track)
ORDER BY milliseconds DESC;
