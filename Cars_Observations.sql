--Create Table
CREATE TABLE Used_Cars (region text, price integer, vehicle_year text, 
				manufacturer text, model text, condition text, 
				cylinders text, fuel text, odometer integer, 
				title_status text, transmission text, vin text, 
				drive text, vehicle_size text, vehicle_type text, paint text, 
				description text, vehicle_state text, 
				posting_date text);

--Preview First 5 Columns
SELECT *
FROM used_cars
LIMIT 5; 

--How Many Manufacturers are being Observed 
SELECT COUNT(DISTINCT manufacturer)
FROM used_cars
WHERE manufacturer != '';

--Top 5 Least Expensive Car Brands
SELECT manufacturer, ROUND(AVG(price),2) AS avg_price
FROM used_cars
GROUP BY manufacturer
HAVING COUNT(manufacturer) >= 100
ORDER BY avg_price ASC
LIMIT 5;

--What are the most frequently listed cars and their prices/miles?
SELECT manufacturer, model, COUNT(model) AS model_count, 
	ROUND(AVG(price),2) AS avg_price, ROUND(AVG(odometer),2) AS avg_miles
FROM used_cars
GROUP BY manufacturer, model
ORDER BY model_count DESC
LIMIT 5;

--What are the top 5 cheapest states to buy a car?
SELECT vehicle_state, ROUND(AVG(price),2) AS avg_price, COUNT(vehicle_state)
FROM used_cars
GROUP BY vehicle_state
ORDER BY avg_price ASC
LIMIT 5;

--What are the top 5 most expensive states to buy a car?
SELECT vehicle_state, ROUND(AVG(price),2) AS avg_price, COUNT(vehicle_state)
FROM used_cars
GROUP BY vehicle_state
ORDER BY avg_price DESC
LIMIT 5;

--Avg Prices based on Fuel
SELECT fuel, ROUND(AVG(price),2) AS avg_price, COUNT(fuel)
FROM used_cars
WHERE fuel != 'other' AND fuel != ''
GROUP BY fuel
ORDER BY avg_price DESC; 

--Avg Prices based on Size
SELECT vehicle_size, ROUND(AVG(price),2) AS avg_price
FROM used_cars
WHERE vehicle_size != ''
GROUP BY vehicle_size
ORDER BY avg_price DESC; 

--Avg Prices based on Transmission 
SELECT transmission, ROUND(AVG(price),2) AS avg_price
FROM used_cars
WHERE transmission NOT IN('other','')
GROUP BY transmission
ORDER BY avg_price DESC; 

--Avg Prices based on Color
SELECT paint, ROUND(AVG(price),2) AS avg_price, COUNT(paint)
FROM used_cars
WHERE paint != ''
GROUP BY paint
ORDER BY avg_price DESC; 

--Avg Prices based on Title Status 
SELECT title_status, ROUND(AVG(price),2) AS avg_price
FROM used_cars
WHERE title_status NOT IN('lien','')
GROUP BY title_status
ORDER BY avg_price DESC; 