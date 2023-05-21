-- Creating tables to import CSVs from Home Depot and Lowes
-- I need to specify the columns I'm importing

CREATE TABLE homedepot (
		time_day DATE,
		open_price FLOAT,
		high_price FLOAT,
		low_price FLOAT,
		close_price FLOAT,
		adj_close FLOAT,
		volume INT
);

CREATE TABLE lowes (
		time_day DATE,
		open_price FLOAT,
		high_price FLOAT,
		low_price FLOAT,
		close_price FLOAT,
		adj_close FLOAT,
		volume INT
);

-- Importing the data through the server browser

-- Checking
SELECT *
FROM homedepot
LIMIT

-- -- Summary statistics
SELECT

  MIN(hd.open_price) AS min_open_hd,
  MIN(lw.open_price) AS min_open_lw,
  MAX(hd.open_price) AS max_open_hd,
  MAX(lw.open_price) AS max_open_lw,
  AVG(hd.close_price) AS avg_close_hd,
  AVG(lw.close_price) AS avg_close_lw,
  SUM(hd.volume) AS total_volume_hd,
  SUM(lw.volume) AS total_volume_lw
  
FROM homedepot hd
INNER JOIN lowes lw ON hd.time_day = lw.time_day;

-- Calculating monthly average closing prices
SELECT
  EXTRACT(MONTH FROM time_day) AS month,
  AVG(close_price) AS avg_close
FROM homedepot
GROUP BY month
ORDER BY month;

-- Calculating the daily price change (Close - Open)
SELECT
  time_day,
  close_price - open_price AS price_change
FROM homedepot
ORDER BY time_day;

-- Calculating the total trading volume by month
SELECT
  EXTRACT(MONTH FROM time_day) AS month,
  SUM(volume) AS total_volume
FROM homedepot
GROUP BY month
ORDER BY month;
