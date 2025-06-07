-- 0) view the headings of the dataset 
SELECT * FROM spotify_data;

-- ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-

-- 1) Count the number of artists in the data set.
	-- There are 2074 artists
SELECT COUNT(DISTINCT artist) AS Artist_count
FROM spotify_data


-- ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
-- 2) See the range of the number of albums each artist has
	-- From 1, 10
SELECT 
	MAX(album_count) AS Max_Range,
	MIN(album_count) AS Min_range,
FROM (
	SELECT artist, COUNT(DISTINCT album) AS album_count
	FROM spotify_data
	GROUP BY artist
	) AS sub;


-- ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
-- 3) Count the range of the number of songs each artist has.
	-- From 1, 10
SELECT 
	MAX(track_count) AS max_track_count,
	MIN(track_count) AS min_track_count

FROM(
	SELECT artist, COUNT(track) AS track_count
	FROM spotify_data
	GROUP BY artist
	) AS sub;

-- FOLLOW UP: 4) Find the total number of tracks by each artist.

SELECT artist, COUNT(*) AS song_count
FROM spotify_data
GROUP BY artist
ORDER BY artist;


-- ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
-- 5) Find the names of all tracks that have more than 1 billion streams.
	-- There are 385 tracks that have over 1 billion streams
SELECT track, artist, album, stream
FROM spotify_data
WHERE stream >= 2000000000
ORDER BY artist;

-- 6) FOLLOW UP: Find the most popular songs.
	-- There are two songs that have over 3.3 billion streams 
SELECT track, artist, album, stream
FROM spotify_data
ORDER BY stream DESC
limit 15;


-- ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
-- 7) Find the number of tracks that belong to each album type.
	-- There are three distinct album types: album 14834, compilation 787, single 4973.
SELECT album_type, COUNT(*) AS album_type
FROM spotify_data
GROUP BY album_type;


-- ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
-- 8) Find the total views of all associated tracks for each album.
	-- The top two albums had more than 10 billion views each.
SELECT artist, album, SUM(views) AS total_views
FROM spotify_data
GROUP BY artist, album
ORDER BY total_views DESC;




-- ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
-- 9) Find the average danceability of tracks in each album.

SELECT artist, album, AVG(danceability) AS dance_rating
FROM spotify_data
GROUP BY artist, album
ORDER BY dance_rating DESC;




-- ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
-- 10) Find tracks That Are Both Licensed and Official Videos
	-- There are 14,060 tracks that are both licensed and official videos.

SELECT artist, album, track 
FROM spotify_data
WHERE licensed = 1 AND official_video = 1
ORDER BY artist, track;


-- ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
-- 11) Find highest liked Longer than 5 Minutes with High Energy (> 0.8)

SELECT artist, track, album, likes
FROM spotify_data
WHERE energy >= 0.8 AND duration_min >= 5
ORDER BY likes DESC;


-- ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
-- 12) Find the total of views by artist
	-- The top 9 artists all had more than 10 billion views
SELECT artist, SUM(views) AS total_views
FROM spotify_data
GROUP BY artist
ORDER BY total_views DESC;


-- ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
-- 13) Find which album type is more popular based on the average number of views
	-- Albums have the highest number of average views, followed by single and compilation
SELECT album_type, AVG(views) AS avg_views
FROM spotify_data
GROUP BY album_type
ORDER BY avg_views DESC
