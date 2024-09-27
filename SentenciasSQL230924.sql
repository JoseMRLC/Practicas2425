--Ejercicios muy facil

--Ejercicio 1
SELECT * FROM movies;

--Ejercicio 2
SELECT * FROM genres;

--Ejercicio 3
SELECT * FROM studios
WHERE studio_active = 1;

--Ejercicio 4
SELECT * FROM members
ORDER BY  member_discharge_date DESC
LIMIT 20;

--Ejercicio Dificultad facil

--Ejercicio 5
SELECT movie_duration,count(*) AS frecuencia
FROM movies
GROUP BY movie_duration
ORDER BY frecuencia DESC 
LIMIT 20;

--Ejercicio 6
SELECT * FROM movies
WHERE year (movie_launch_date) >= 2000 AND UPPER(movie_name) LIKE 'A%';

--Ejercicio 7
SELECT * FROM actors
WHERE month(actor_birth_date) = 6

--Ejercicio 8
SELECT * FROM actors
WHERE month(actor_birth_date) !=6 AND actor_dead_date is NULL;

--Ejercicio 9
SELECT 
 director_name,
 director_dead_date,
YEAR (CURDATE())-YEAR(director_birth_date) AS edad
FROM  directors
    WHERE YEAR (CURDATE())-YEAR(director_birth_date) <=50 
   AND director_dead_date IS NULL;

  --Ejercicio 10
  
  SELECT 
 actor_name,
 actor_dead_date,
YEAR (CURDATE())-YEAR(actor_birth_date) AS edad
FROM  actors
    WHERE YEAR (CURDATE())-YEAR(actor_birth_date) <=50 
   AND actor_dead_date IS not NULL;
  
  
  --Ejercicio 11
  
  SELECT 
 director_name

FROM  directors
    WHERE YEAR (CURDATE())-YEAR(director_birth_date) <=40 
   AND director_dead_date IS NULL;
  
 --Ejercicio 12 
  SELECT AVG(YEAR (CURDATE())-YEAR(director_birth_date))
FROM  directors WHERE director_dead_date IS NULL;

--Ejercicio 13
 SELECT AVG(YEAR (CURDATE())-YEAR(director_birth_date))
FROM  directors WHERE director_dead_date IS NOT NULL;

--Ejercicio Dificultad Media

--Ejercicio 14

SELECT  movie_name AS nombre_peli,
studio_name AS nombre_studio
FROM movies
AS m INNER JOIN studios AS S
ON s.studio_id = m.studio_id
  
--Ejercicio 15

SELECT DISTINCT member_name AS nombre_miembro
FROM members AS m INNER JOIN
members_movie_rental AS mv 
ON m.member_id = mv.member_id
WHERE mv.member_rental_date  BETWEEN '2010-01-01' AND '2015-12-31';


--Ejercicio 16

SELECT  n.nationality_name,COUNT(*) 
FROM movies AS m
INNER JOIN nationalities AS N
ON m.nationality_id = n.nationality_id
 GROUP BY N.NATIONALITY_NAME;

--Ejercicio 17

SELECT movie_name
FROM movies AS m
INNER JOIN genres AS G
ON m.genre_id = g.genre_id
WHERE g.genre_name = 'Documentary';

--Ejercicio 18

SELECT movie_name FROM movies AS m
INNER JOIN directors AS D
ON m.director_id = d.director_id
WHERE year(d.director_birth_date) >= 1980 AND d.director_dead_date IS NULL;

--Ejercicio 19

SELECT m.MEMBER_name AS member_name,d.director_name AS director_name
FROM members AS m
inner JOIN directors AS D
ON m.member_town = d.director_birth_place
--Da consula vacia

--Ejercicio 20
SELECT movie_name, movie_launch_date
FROM movies AS m
INNER JOIN studios AS S
ON m.studio_id = s.studio_id
WHERE s.studio_active = 0;

--Ejercicio 21

SELECT movie_name
FROM movies  AS m
INNER JOIN members_movie_rental AS MV
ON m.movie_id = mv.movie_id
ORDER BY mv.member_rental_date DESC
LIMIT 10;

--Ejercicio 22

SELECT d.director_name,count(m.movie_id) AS cantidad_peliculas
FROM directors AS d
INNER JOIN movies AS M
ON d.director_id = m.director_id
WHERE DATEDIFF(YEAR, m.movie_launch_date, d.director_birth_date) < 41
GROUP BY d.director_id,DIRECTOR_NAME;

--Ejercicio 23

SELECT 
    d.director_name AS director, 
    AVG(m.movie_duration) AS media_duracion
FROM 
    directors AS d
JOIN 
    movies as m ON d.director_id = m.director_id
GROUP BY 
    d.director_id, d.director_name;
   
   --Ejercicio 24

   SELECT 
    m.movie_name AS nombre_pelicula, 
    MIN(m.movie_duration) AS duracion_minima
FROM  members_movie_rental AS mv
INNER JOIN   movies AS m ON mv.movie_id = m.movie_id
WHERE   mv.member_rental_date >= NOW() - INTERVAL 7 YEAR
GROUP BY m.movie_name
ORDER BY  duracion_minima
LIMIT 1;


--Ejercicio 25

SELECT 
    d.director_name AS director, 
    COUNT(m.movie_id) AS cantidad_peliculas
FROM   directors AS d
INNER JOIN   movies AS m ON d.director_id = m.director_id
WHERE  (m.movie_launch_date BETWEEN '1960-01-01' AND '1989-12-31')
   AND m.movie_name LIKE '%The%'
GROUP BY 
 d.director_id, d.director_name;
   
--Consultas Dificiles
   
--Ejercicio 26
    
SELECT 
    m.movie_name AS nombre_pelicula, 
    n.nationality_name, 
    d.director_name AS director
FROM   movies AS m INNER JOIN 
    directors AS d ON m.director_id = d.director_id
   INNER JOIN nationalities AS n ON n.nationality_id = m.nationality_id ;
  
  --Ejercicio 27 
  
  SELECT 
    m.movie_name AS nombre_pelicula, 
    GROUP_CONCAT(a.actor_name SEPARATOR ', ') AS actores
FROM  movies m
INNER JOIN movies_actors as ma ON m.movie_id = ma.movie_id
INNER JOIN  actors as a ON ma.movie_actors_id = a.actor_id
GROUP BY   m.movie_id, m.movie_name;

--Ejercicio 28

SELECT 
    d.director_name AS director, 
    COUNT(mmr.member_movie_rental_id) AS cantidad_alquileres
FROM  directors AS d
INNER JOIN  movies AS m ON d.director_id = m.director_id
INNER JOIN members_movie_rental as mmr ON m.movie_id = mmr.movie_id
GROUP BY d.director_id, d.director_name
ORDER BY  cantidad_alquileres DESC
LIMIT 1;

--Ejercicio 29

SELECT 
s.studio_name AS estudio, 
    COUNT(a.award_id) AS cantidad_premios
FROM studios AS s
INNER JOIN  movies as m ON s.studio_id = m.studio_id
LEFT JOIN awards AS a ON m.movie_id = a.movie_id
GROUP BY   s.studio_id, s.studio_name;

--Ejercicio 30


SELECT 
act.actor_name AS actor, 
      COUNT(DISTINCT a.award_id) AS total_nominations,  -- Contar todas las nominaciones
    COUNT(DISTINCT CASE WHEN a.award_win = 1 THEN a.award_id END) AS total_won,  -- Contar premios ganados
    COUNT(DISTINCT a.award_id) - COUNT(DISTINCT CASE WHEN a.award_win = 1 THEN a.award_id END) AS cantidad_premios_perdidos  -- Calcular premios perdidos
FROM studios as s
INNER JOIN movies as m 
ON s.studio_id = m.studio_id
INNER JOIN movies_actors AS MA
ON ma.movie_id = m.movie_id
INNER JOIN actors AS act ON  
act.actor_id = ma.actor_id
LEFT JOIN awards AS a ON m.movie_id = a.movie_id
GROUP BY   act.actor_id, act.actor_name
ORDER BY cantidad_premios_perdidos desc;


--Ejercicio 31

SELECT 
    COUNT(DISTINCT ma.actor_id) AS total_actores,
    COUNT(DISTINCT m.director_id) AS total_directores
FROM 
    studios AS s
LEFT JOIN 
    movies AS m ON s.studio_id = m.studio_id
LEFT JOIN 
    movies_actors AS ma ON m.movie_id = ma.movie_id
WHERE 
    s.studio_active = 0;
   
   --Ejercicio 32

   SELECT 
    m.member_name AS member_name,
    m.member_town AS member_city,
    m.member_phone AS member_phone
FROM 
    members m
INNER JOIN 
    members_movie_rental mmr ON m.member_id = mmr.member_id
INNER JOIN 
    movies mv ON mmr.movie_id = mv.movie_id
INNER JOIN 
    awards AS a ON mv.movie_id = a.movie_id
WHERE 
    a.award_nomination > 150 AND a.award_win < 50
GROUP BY 
    m.member_id, m.member_name, m.member_town, m.member_phone;
   
   --Ejercicio 33 
   --Si que los hay, en el ejercicio 22 pasa eso
   
   --Ejercicio 34
      --Ejercicio 34
  
 UPDATE directors as d
SET d.director_dead_date = (
    SELECT DATE_ADD(MAX(m.movie_launch_date), INTERVAL 1 YEAR)  
    FROM movies as m
    WHERE m.director_id = d.director_id
    AND m.movie_launch_date > d.director_dead_date 
)
WHERE EXISTS (
    SELECT 1
    FROM movies as m
    WHERE m.director_id = d.director_id
    AND m.movie_launch_date > d.director_dead_date 
)