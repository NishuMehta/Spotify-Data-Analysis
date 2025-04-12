-- ANALYSIS QUERIES

-- Retrieve the names of all tracks that have more than 1 billion streams.
SELECT 
	title 
FROM 
	spotify 
WHERE 
	stream > 1000000000;


-- List all albums along with their respective artists.
SELECT 
	DISTINCT album, 
	artist 
FROM 
	spotify;


-- Get the total number of comments for tracks where licensed = TRUE.
SELECT 
	SUM(comments) 
FROM 
	spotify 
WHERE 
	licensed = TRUE;


-- Find all tracks that belong to the album type single.
SELECT 
	track 
FROM 
	spotify
WHERE 
	album_type = 'single';


-- Count the total number of tracks by each artist.
SELECT 
	artist, 
	COUNT(track) 
FROM 
	spotify
GROUP BY 
	artist;


-- Calculate the average danceability of tracks in each album.
SELECT 
	DISTINCT album,
	AVG(danceability)
FROM 
	spotify
GROUP BY 
	album
ORDER BY 
	2 DESC;


-- Find the top 5 tracks with the highest energy values.
SELECT 
	track, 
	energy
FROM 
	spotify
ORDER BY 
	energy DESC
LIMIT 5;


-- List all tracks along with their views and likes where official_video = TRUE.
SELECT
	track,
	SUM(views),
	SUM(likes)
FROM 
	spotify
WHERE 
	official_video=TRUE
GROUP BY 
	track
ORDER BY 
	2 DESC;


-- For each album, calculate the total views of all associated tracks.
SELECT 
	album, 
	track, 
	SUM(views)
FROM 
	spotify
GROUP BY 
	album, 
	track;


-- Retrieve the track names that have been streamed on Spotify more than YouTube.
SELECT * FROM (
	SELECT track, 
		COALESCE(SUM(CASE WHEN most_played_on='Spotify' THEN stream END),0) AS spotify_s,
		COALESCE(SUM(CASE WHEN most_played_on='Youtube' THEN stream END),0) AS youtube_s
	FROM spotify
	GROUP BY track
) AS T1
WHERE 
	spotify_s > youtube_s 
	AND youtube_s <> 0;


-- Find the top 3 most-viewed tracks for each artist using window functions.
WITH ranking_artist AS ( 
	SELECT 
		artist, 
		track, 
		SUM(views) AS total_views,
		DENSE_RANK()  OVER (PARTITION BY artist ORDER BY SUM(views) DESC) AS rank
	FROM 
		spotify 
	GROUP BY 
		1, 2 
	ORDER BY 
		1, 3 DESC
)
SELECT * 
FROM ranking_artist
WHERE rank <= 3;


-- Write a query to find tracks where the liveness score is above the average.
SELECT 
	track, 
	liveness 
FROM 
	spotify 
WHERE 
	liveness > (SELECT AVG(liveness) FROM spotify);


-- Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
WITH cte AS (
	SELECT 
		album, 
		MAX(energy) AS max_energy,
		MIN(energy) AS min_energy 
	FROM spotify  
	GROUP BY album
)
SELECT 
	album, 
	max_energy-min_energy AS energy_diff
FROM cte
ORDER BY 2 DESC


