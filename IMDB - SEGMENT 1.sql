create database IMDB;
use IMDB;

select * from movie;
select * from genre;
select * from director_mapping;
select * from role_mapping;
select * from names;
select * from rating;

-- Segment 1: Database - Tables, Columns, Relationships

-- 1. What are the different tables in the database and how are they connected to each other in the database?



-- 2. Find the total number of rows in each table of the schema
select count(*) as movie_total_row from movie;
select count(*) as director_Mapping_total_row from director_mapping;
select count(*) as genre_total_row from genre;
select count(*) as names_total_row from names;
select count(*) as rating_total_row from rating;
select count(*) as role_mapping_total_row from role_mapping;
/*
total number of rows in movie table - 7997
total number of rows in director_mapping table - 3867
total number of rows in genre table - 14662
total number of rows in names table - 25735
total number of rows in rating table - 7997
total number of rows in role_mapping table - 15615
*/


-- 3. Identify which columns in the movie table have null values 
select * from movie;
SET SQL_SAFE_UPDATES=0;

update movie set id = null where id = '';
update movie set title = null where title = '';
update movie set year = null where year = '';
update movie set date_published = null where date_published = '';
update movie set duration = null where duration = '';
update movie set country = null where country = '';
update movie set worlwide_gross_income = null where worlwide_gross_income = '';
update movie set languages = null where languages = '';
update movie set production_company = null where production_company = '';

select 
sum(case when id is null then 1 else 0 end) as id_nulls,
sum(case when title is null then 1 else 0 end) as title_nulls,
sum(case when year is null then 1 else 0 end) as year_nulls,
sum(case when date_published is null then 1 else 0 end) as datep_nulls,
sum(case when duration is null then 1 else 0 end) as duration_nulls,
sum(case when country is null then 1 else 0 end) as country_nulls,
sum(case when worlwide_gross_income is null then 1 else 0 end) as income_nulls,
sum(case when languages is null then 1 else 0 end) as lang_nulls,
sum(case when production_company is null then 1 else 0 end) as production_nulls
from movie;
-- country, worlwide_gross_income, languages, production_company are the columns in movie table which has null values

