-- Segment 3: Production Statistics and Genre Analysis

-- 1. Retrieve the unique list of genres present in the dataset.
select * from genre;
select distinct genre
from genre;
-- There are 13 unique list of genres present in the dataset.


-- 2. Identify the genre with the highest number of movies produced overall.
select genre , count(movie_id) as movies from movie
left join genre on (movie.id = genre.movie_id) 
group by genre order by 2 desc limit 1;
-- Drama genre has the highest number of movies produced overall


-- 3. Determine the count of movies that belong to only one genre.
with cte as
(select id , count(distinct genre) as genres from movie
left join genre on (movie.id = genre.movie_id) 
group by id 
having count(distinct genre) = 1)

select count(id) as movies from cte; 
-- 3289 movies are belong to only one genre


-- 4. Calculate the average duration of movies in each genre
select sum(duration) as Average_duration , genre from movie
left join genre on (movie.id = genre.movie_id) 
group by genre 
order by Average_duration asc;
 

-- 5. Find the rank of the 'thriller' genre among all genres in terms of the number of movies produced.
with cte_1 as 
(
select genre , count(movie_id) as movies from movie
left join genre on (movie.id = genre.movie_id) 
group by genre order by movies desc
)
		 
select * , rank() over (order by movies desc) as genre_rank 
from cte_1;
-- 'thriller' genre has 3th rank among all genres in terms of the number of movies produced.

