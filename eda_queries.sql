-- Exploratory Data Analysis

Select * FROM spotify;

-- Number of Artists
SELECT Count(DISTINCT(artist)) FROM spotify;

-- Number of Albums
SELECT COUNT(DISTINCT (album)) FROM spotify;

-- Type of Albums
SELECT DISTINCT album_type FROM spotify;

-- Maximum Duration
SELECT MAX(duration_min) FROM spotify;

-- Minimum Duration
SELECT MIN(duration_min) FROM spotify;

-- Deletion of Rows where Duration is 0
DELETE FROM spotify WHERE duration_min = 0;

-- List all Channels
SELECT DISTINCT channel FROM spotify;


