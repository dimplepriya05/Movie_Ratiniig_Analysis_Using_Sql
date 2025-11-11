CREATE DATABASE movie_db;
USE movie_db;

CREATE TABLE Movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    release_year INT,
    genre VARCHAR(50),
    duration INT,
    language VARCHAR(30)
);

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50),
    country VARCHAR(50),
    age INT
);

CREATE TABLE Ratings (
    rating_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT,
    user_id INT,
    rating DECIMAL(2,1),
    review_date DATE,
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Movies (title, release_year, genre, duration, language) VALUES
('Inception', 2010, 'Sci-Fi', 148, 'English'),
('Parasite', 2019, 'Thriller', 132, 'Korean'),
('The Dark Knight', 2008, 'Action', 152, 'English'),
('Interstellar', 2014, 'Sci-Fi', 169, 'English'),
('Spirited Away', 2001, 'Animation', 125, 'Japanese');

INSERT INTO Users (username, country, age) VALUES
('Alice', 'USA', 25),
('Rahul', 'India', 22),
('Maria', 'Spain', 30),
('Kenji', 'Japan', 27),
('Fatima', 'UAE', 29);

INSERT INTO Ratings (movie_id, user_id, rating, review_date) VALUES
(1, 1, 9.0, '2023-01-10'),
(1, 2, 8.5, '2023-01-12'),
(2, 3, 9.3, '2023-02-01'),
(3, 2, 9.0, '2023-03-15'),
(4, 4, 8.8, '2023-03-20'),
(5, 5, 9.5, '2023-04-10'),
(2, 1, 8.9, '2023-04-15'),
(3, 5, 9.1, '2023-04-25');

SELECT m.title, ROUND(AVG(r.rating), 2) AS avg_rating
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.title
ORDER BY avg_rating DESC
LIMIT 3;

SELECT m.genre, ROUND(AVG(r.rating), 2) AS avg_rating
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.genre
ORDER BY avg_rating DESC;


