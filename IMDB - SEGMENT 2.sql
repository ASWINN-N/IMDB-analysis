-- Segment 2: Movie Release Trends

-- 1. Determine the total number of movies released each year and analyse the month-wise trend.
-- for each years
select count(id) as movies, year as movies_released_year from movie
group by year order by 2;
-- month wise analysis
with cte as
(select year , substr(date_published ,1,2) as month , count(id) as movies_released 
from movie 
group by year, substr(date_published , 1,2) 
order by year, substr(date_published , 1,2))

SELECT year, REPLACE(month, '/', '') AS month, movies_released
FROM cte;


-- 2. Calculate the number of movies produced in the USA or India in the year 2019.
select count(id) as movies_released 
from movie 
where (country = 'India' or country = 'USA') and year = 2019;
-- 887 movies produced in the USA or India in the year 2019

