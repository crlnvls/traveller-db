DROP TABLE IF EXISTS travellers;
CREATE TABLE travellers (
	id SERIAL PRIMARY KEY,
	name VARCHAR ( 20 ) NOT NULL,
);
COPY travellers
FROM $$/code/data/travellers.csv$$
DELIMITER ',' CSV HEADER;
    

DROP TABLE IF EXISTS destinations;
CREATE TABLE destinations (
	id SERIAL PRIMARY KEY,
	country VARCHAR ( 20 ),
);
COPY destinations
FROM $$/code/data/destinations.csv$$
DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS trips;
CREATE TABLE trips (
	id SERIAL PRIMARY KEY,
	traveller_id INT REFERENCES travellers (id) NOT NULL
    destination_id INT REFERENCES destinations (id) NOT NULL 
);
