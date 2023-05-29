CREATE TABLE IF NOT EXISTS counties (
county      TEXT PRIMARY KEY,
y2022       INTEGER,
y2023       INTEGER,
pop_change  NUMERIC
);

CREATE TEMP TABLE counties_tmp (
county      TEXT PRIMARY KEY,
y2022       TEXT,
y2023       TEXT,
pop_change  NUMERIC
);

COPY counties_tmp
FROM '/database/counties.csv'
DELIMITER ','
CSV HEADER;

INSERT INTO counties(county, y2022, y2023, pop_change)
    SELECT  county,
            replace(y2022, ',', '') :: NUMERIC,
            replace(y2023, ',', '') :: NUMERIC,
            pop_change
    FROM counties_tmp;

CREATE TABLE IF NOT EXISTS cities (
city        TEXT NOT NULL,
y2022       INTEGER,
y2023       INTEGER,
pop_change  NUMERIC,
county      TEXT NOT NULL,
PRIMARY KEY (city, county)
);

CREATE TEMP TABLE cities_tmp (
city        TEXT NOT NULL,
y2022       TEXT,
y2023       TEXT,
pop_change  NUMERIC,
county      TEXT NOT NULL
);

COPY cities_tmp 
FROM '/database/cities.csv'
DELIMITER ','
CSV HEADER;

INSERT INTO cities(city, y2022, y2023, pop_change, county)
    SELECT  city,
            replace(y2022, ',', '') :: NUMERIC,
            replace(y2023, ',', '') :: NUMERIC,
            pop_change,
            county
    FROM cities_tmp;
