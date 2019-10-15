# 1. Select the title of all movies.
SELECT Title
FROM movies;

# 2. Show all the distinct ratings in the database.
SELECT DISTINCT Rating
FROM movies;

# 3. Show all unrated movies.
SELECT *
FROM movies
WHERE Rating IS NULL;

# 4. Select all movie theaters that are not currently showing a movie.
SELECT *
FROM movietheaters
WHERE Movie IS NULL;

# 5. Select all data from all movie theaters and, additionally, the data from the movie that is being shown in the theater 
# (if one is being shown).
SELECT * 
FROM movietheaters T
LEFT JOIN movies M
ON M.Code = T.Movie;

# 6. Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.
SELECT *
FROM movies M
LEFT JOIN movietheaters T 
ON M.Code = T.Movie;

# 7. Show the titles of movies not currently being shown in any theaters.
SELECT Title
FROM movies M
WHERE M.Code NOT IN (
					SELECT Movie FROM movietheaters WHERE Movie IS NOT NULL
					);

# 8. Add the unrated movie "One, Two, Three".
INSERT INTO movies(Title, Rating)
VALUES("One, Two, Three", NULL);

# 9. Set the rating of all unrated movies to "G".
UPDATE movies
SET Rating = "G"
WHERE Rating IS NULL;

# 10. Remove movie theaters projecting movies rated "NC-17".
DELETE FROM movietheaters
WHERE Movie IN 
			 (
             SELECT Code FROM movies WHERE Rating = "NC-17"
             );

