-- MOVIE RATING ANALYSIS PROJECT
-- File: analysis_queries.sql
-- Description: Contains all SQL analysis and insights queries

SELECT * FROM Movies;

SELECT m.title, u.username, r.rating, r.review_date
FROM Ratings r
JOIN Movies m ON r.movie_id = m.movie_id
JOIN Users u ON r.user_id = u.user_id;

SELECT genre, COUNT(*) AS total_movies
FROM Movies
GROUP BY genre;

SELECT m.title, ROUND(AVG(r.rating), 2) AS avg_rating
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.title
ORDER BY avg_rating DESC;

SELECT m.genre, ROUND(AVG(r.rating), 2) AS avg_rating
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.genre
ORDER BY avg_rating DESC;

SELECT m.title, ROUND(AVG(r.rating), 2) AS avg_rating
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.title
ORDER BY avg_rating DESC
LIMIT 3;

SELECT m.title, m.release_year, ROUND(AVG(r.rating), 2) AS avg_rating
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
WHERE m.release_year > 2010
GROUP BY m.title, m.release_year;

SELECT u.username, COUNT(r.rating_id) AS total_ratings
FROM Users u
JOIN Ratings r ON u.user_id = r.user_id
GROUP BY u.username
ORDER BY total_ratings DESC;

SELECT m.genre, m.title, AVG(r.rating) AS avg_rating
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.genre, m.title
HAVING AVG(r.rating) = (
    SELECT MAX(avg_rating)
    FROM (
        SELECT m2.genre AS genre, AVG(r2.rating) AS avg_rating
        FROM Movies m2
        JOIN Ratings r2 ON m2.movie_id = r2.movie_id
        WHERE m2.genre = m.genre
        GROUP BY m2.title
    ) AS temp
);

SELECT m.title, ROUND(AVG(r.rating), 2) AS avg_rating
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.title
HAVING AVG(r.rating) > (
    SELECT AVG(rating) FROM Ratings
)
ORDER BY avg_rating DESC;

SELECT u.username, ROUND(AVG(r.rating), 2) AS avg_given
FROM Users u
JOIN Ratings r ON u.user_id = r.user_id
GROUP BY u.username
ORDER BY avg_given DESC
LIMIT 3;

SELECT u.username
FROM Users u
WHERE NOT EXISTS (
    SELECT movie_id FROM Movies
    WHERE movie_id NOT IN (
        SELECT r.movie_id FROM Ratings r WHERE r.user_id = u.user_id
    )
);

SELECT m.title,
       ROUND(AVG(r.rating), 2) AS avg_rating,
       RANK() OVER (ORDER BY AVG(r.rating) DESC) AS rank_position
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.title;

SELECT m.title, u.username, r.rating, r.review_date
FROM Ratings r
JOIN Movies m ON m.movie_id = r.movie_id
JOIN Users u ON u.user_id = r.user_id
WHERE (r.movie_id, r.review_date) IN (
    SELECT movie_id, MAX(review_date)
    FROM Ratings
    GROUP BY movie_id
);

SELECT m.genre, COUNT(r.rating_id) AS total_ratings,
       RANK() OVER (ORDER BY COUNT(r.rating_id) DESC) AS popularity_rank
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.genre;

