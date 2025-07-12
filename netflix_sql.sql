drop table if exists netflix;
create table netflix(
show_id	varchar(6),
type char(10),
title varchar(150),
director varchar(208),	
casts varchar(1000),
country	varchar(150),
date_added	varchar(50),
release_year INT,	
rating	varchar(10),
duration varchar(15),	
listed_in varchar(100),	
description varchar(250)
);
select *from netflix;
select count(*) 
as total_counts
from netflix;
select 
distinct type 
from netflix;
--count no of movies vs tvshows

select 
type,
count(*) as total_count
from netflix
group by type;
--most common rating for movies and tv shows

select 
type,
rating 
from
(
select 
type,
rating,
count(*),
rank() over(partition by type order by count(*)) as ranking
from netflix 
group by 1,2
) as t1
where ranking=1 
--list allmovies relase in a year 2021

select *from netflix 
where type ='Movie'
and
release_year=2021;
--top 10 counties with mosth content on netflix

select 
unnest(string_to_array(country,',')) as new_country,
count(show_id) as total_count
from netflix
group by 1 
order by 2 desc
limit 10

select
unnest(string_to_array(country,',')) as new_country
from netflix
--identifying first 2 largest movie

select* from netflix
where
   type='Movie'
and
duration=(select max(duration) from netflix)
limit 2

--find the CONTENT for last 5 years 
select 
*from netflix;
where 
to_date(date_added,'Month DD,YYYY')>=current_date-interval '5 years'

--find all the movies/tv shows directed by kemi adetiva
select *from netflix
where director ilike '%kemi Adetiba%'

--list all tv shows with more than 3 seasons
select 
*
from netflix
where 
type='TV Show'
AND
SPLIT_PART(duration,' ',1)::numaric>3 sessions

