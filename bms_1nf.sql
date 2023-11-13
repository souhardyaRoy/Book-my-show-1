--1NF
CREATE DATABASE BookMYShow;

--2NF
-- City -> city_id,city_name
-- Theater -> theater_id,theater_name,city_id(fk)
-- SHOWS -> show_id,date,movie,language,theater_id(fk)

--3NF
use BookMYShow;
CREATE TABLE BOOK_MY_SHOW (
    show_id INT PRIMARY KEY,
    date DATE,
    city VARCHAR(255),
    theater VARCHAR(255),
    movie VARCHAR(255),
    show_time TIME,
    language VARCHAR(255)
);

use BookMYShow;
CREATE TABLE CITY (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(255)
);

use BookMYShow;
CREATE TABLE THEATRE (
    theater_id INT PRIMARY KEY,
    city_id INT,
    theater_name VARCHAR(255),
    FOREIGN KEY (city_id) REFERENCES CITY(city_id)
);

use BookMYShow;
CREATE TABLE ACTIVE_MOVIES (
    movie_id INT PRIMARY KEY,
    movie_name VARCHAR(255)
);

use BookMYShow;
CREATE TABLE LANGUAGE (
    language_id INT PRIMARY KEY,
    language_name VARCHAR(255)
);

use BookMYShow;
CREATE TABLE DATES (
    date_id INT PRIMARY KEY,
    available_date DATE
);

use BookMYShow;
CREATE TABLE SHOWS (
    show_id INT PRIMARY KEY,
    date_id INT,
    show_time TIME,
    theater_id INT,
    movie_id INT,
    language_id INT,
    FOREIGN KEY (date_id) REFERENCES DATES(date_id),
    FOREIGN KEY (theater_id) REFERENCES THEATRE(theater_id),
    FOREIGN KEY (movie_id) REFERENCES ACTIVE_MOVIES(movie_id),
    FOREIGN KEY (language_id) REFERENCES LANGUAGE(language_id)
);


--inserting sample data
use BookMYShow;
INSERT INTO CITY (city_id, city_name) VALUES
(1, 'Mumbai'),
(2, 'Delhi'),
(3, 'Bangalore');

use BookMYShow;
INSERT INTO THEATRE (theater_id, city_id, theater_name) VALUES
(101, 1, 'PVR Mumbai'),
(102, 2, 'INOX Delhi'),
(103, 3, 'Cinepolis Bangalore');

use BookMYShow;
INSERT INTO ACTIVE_MOVIES (movie_id, movie_name) VALUES
(1, 'Movie A'),
(2, 'Movie B'),
(3, 'Movie C');

use BookMYShow;
INSERT INTO LANGUAGE (language_id, language_name) VALUES
(1, 'English'),
(2, 'Hindi'),
(3, 'Kannada');


use BookMYShow;
INSERT INTO DATES (date_id, available_date) VALUES
(1, '2023-11-15'),
(2, '2023-11-16'),
(3, '2023-11-17');

use BookMYShow;
INSERT INTO SHOWS (show_id, date_id, show_time, theater_id, movie_id, language_id) VALUES
(1, 1, '18:00:00', 101, 1, 1),
(2, 1, '19:30:00', 102, 2, 2),
(3, 1, '20:00:00', 103, 3, 3);


--query
use BookMYShow;
SELECT
    S.show_id,
    S.show_time,
    AM.movie_name,
    L.language_name
FROM
    SHOWS S
    JOIN DATES D ON S.date_id = D.date_id
    JOIN ACTIVE_MOVIES AM ON S.movie_id = AM.movie_id
    JOIN LANGUAGE L ON S.language_id = L.language_id
    JOIN THEATRE T ON S.theater_id = T.theater_id
WHERE
    D.available_date = '2023-11-15' 
    AND T.theater_name = 'PVR Mumbai';












