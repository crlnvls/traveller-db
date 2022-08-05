DROP TABLE IF EXISTS travellers;
CREATE TABLE travellers (
	id SERIAL PRIMARY KEY,
	name VARCHAR ( 50 ) NOT NULL
);
COPY travellers
FROM $$/code/data/travellers.csv$$
DELIMITER ',' CSV HEADER;
    

DROP TABLE IF EXISTS destinations;
CREATE TABLE destinations (
	id SERIAL PRIMARY KEY,
	country VARCHAR ( 50 )
);
COPY destinations
FROM $$/code/data/destinations.csv$$
DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS trips;
CREATE TABLE trips (
	id SERIAL PRIMARY KEY,
	traveller_id INT REFERENCES travellers (id) NOT NULL,
    destination_id INT REFERENCES destinations (id) NOT NULL 
);
COPY trips
FROM $$/code/data/trips.csv$$
DELIMITER ',' CSV HEADER;


SELECT travellers.name AS traveller, destinations.country AS destination
FROM ((trips JOIN travellers ON trips.traveller_id = travellers.id)
JOIN destinations ON trips.destination_id = destinations.id);

SELECT COUNT(destinations.country) AS trips, travellers.name AS traveller
FROM ((trips JOIN travellers ON trips.traveller_id = travellers.id)
JOIN destinations ON trips.destination_id = destinations.id)
GROUP BY travellers.name
ORDER BY COUNT(destinations.country) ASC;

SELECT travellers.name, destinations.country 
FROM ((trips JOIN travellers ON trips.traveller_id = travellers.id)
JOIN destinations ON trips.destination_id = destinations.id)
WHERE name='Sharron';
