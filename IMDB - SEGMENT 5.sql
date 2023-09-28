-- Segment 5: Crew Analysis

-- 1. Identify the columns in the names table that have null values.
update names set id = null where id = '';
update names set name = null where name = '';
update names set height = null where height = '';
update names set date_of_birth = null where date_of_birth = '';
update names set known_for_movies = null where known_for_movies = '';

select 
sum(case when id is null then 1 else 0 end) as id_nulls,
sum(case when name is null then 1 else 0 end) as name_nulls,
sum(case when height is null then 1 else 0 end) as height_nulls,
sum(case when date_of_birth is null then 1 else 0 end) as date_of_birth_nulls,
sum(case when known_for_movies is null then 1 else 0 end) as known_for_movies
from names;
-- height, date_of_birth, known_for_movies are the column which has null values


-- 2.Determine the top three directors in the top three genres with movies having an average rating > 8.
with cte as 
(select genre,d.name_id as director_id, n.name as director_name, count(m.id) as movie_count,
row_number() over (partition by genre order by count(m.id) desc) as ranks 
from movie m
left join genre g on m.id=g.movie_id
left join director_mapping d on d.movie_id=m.id
left join names n on n.id=d.name_id
where d.name_id is not null
group by genre,director_id,director_name),

cte2 as 
(select genre,count(id) as counts
from movie m
left join genre g on m.id=g.movie_id
left join rating r on m.id=r.movie_id
where avg_rating>8
group by genre
order by counts desc limit 3)

select * from cte where genre in (select genre from cte2) and ranks<=3;
-- it gives top 3 genres and top 3 directors in each genre. Top 3 genres are Drama, Action, Comedy. 
-- The top 3 directors in action are Sam Liu, Jesse V. Johnson and Peter Mimi and so on for Drama and Commedy.


-- 3. Find the top two actors whose movies have a median rating >= 8.
select n.id as name_id, n.name as actor_name, count(m.id) as movie_count,
row_number() over (order by count(m.id) desc) as ranks 
from names n 
left join role_mapping r on r.name_id=n.id
left join movie m on r.movie_id=m.id
left join rating a on m.id=a.movie_id
where category='actor' and median_rating>=8
group by name_id, actor_name  
limit 2;
-- top 2 actors are Mammooty and Mohanlal


-- 4. Identify the top three production houses based on the number of votes received by their movies.
select * from 
(select production_company, sum(total_votes) as total_votes,
row_number() over (order by sum(total_votes) desc) as ranks
from movie 
left join rating on movie.id = rating.movie_id
group by production_company) as a 
where ranks<=3;
-- Top 3 Production houses are Marvel Studios, Twentieth Century Fox and Warner Bros.


-- 5. Rank actors based on their average ratings in Indian movies released in India.
select role_mapping.name_id as id, names.name as actor_name, avg(rating.avg_rating) as average_rating,
row_number() over (order by avg(rating.avg_rating) desc) as ranks
from movie
left join role_mapping on role_mapping.movie_id = movie.id
left join rating on movie.id = rating.movie_id 
left join names on names.id = role_mapping.name_id
where category='actor' and country='India'
group by id,actor_name;
-- It ranks actors in India based on average rating. Shilpa Mahendar is ranked 1, Gopi Krishna is ranked 2 and so on.


-- 6. Identify the top five actresses in Hindi movies released in India based on their average ratings.
select role_mapping.name_id as id, names.name as actresses_name, avg(rating.avg_rating) as average_rating,
row_number() over (order by avg(rating.avg_rating) desc) as ranks
from movie
left join role_mapping on role_mapping.movie_id = movie.id
left join rating on movie.id = rating.movie_id 
left join names on names.id = role_mapping.name_id
where category='actress' and country='India' and languages='hindi'
group by id, actresses_name
limit 5;
-- It gives top 5 Indian actress for hindi movies. Pranati Rai Prakash is ranked 1, Leera kaljai is ranked 2 and so on.

