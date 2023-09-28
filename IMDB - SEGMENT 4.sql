-- Segment 4: Ratings Analysis and Crew Members

-- 1. Retrieve the minimum and maximum values in each column of the ratings table (except movie_id).
select max(avg_rating) as max_avg_rating , min(avg_rating) as min_avg_rating from rating; -- min and max of avg_rating - 1, 10
select max(total_votes) as max_total_votes , min(total_votes) as min_total_votes from rating;-- min and max of total_votes - 100, 725138
select max(median_rating) as max_median_rating , min(median_rating) as min_median_rating from rating;-- min and max of median_rating - 1, 10


-- 2. Identify the top 10 movies based on average rating.
select title from movie
left join rating on (movie.id = rating.movie_id) 
order by avg_rating desc limit 10;
 
 
 -- 3. Summarise the ratings table based on movie counts by median ratings.
select median_rating, count(movie_id) as movie_count 
from rating
group by median_rating 
order by 1 asc;
 
 
 -- 4. Identify the production house that has produced the most number of hit movies (average rating > 8).
select production_company, count(movie_id) as movie_count 
from movie
left join rating on (movie.id = rating.movie_id)
where avg_rating > 8 and production_company is not null
group by production_company order by 2 desc;
-- Dream Warrior Pictures, National Theatre Live production house that has produced the most number of hit movies


-- 5. Determine the number of movies released in each genre during March 2017 in the USA with more than 1,000 votes.
select genre, count(id) as movie_released from movie
left join genre on (movie.id = genre.movie_id)
left join rating on (movie.id = rating.movie_id) 
where total_votes > 1000 and substr(date_published ,1,2) = 3 and country = 'USA' and year = 2017
group by genre order by 2 desc;

 
-- 6. Retrieve movies of each genre starting with the word 'The' and having an average rating > 8.
select title, genre from movie
left join genre on (movie.id = genre.movie_id)
left join rating on (movie.id = rating.movie_id)
where title regexp '^The ' and avg_rating > 8;

