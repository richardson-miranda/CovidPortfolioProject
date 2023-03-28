select * 
from [videos-stats$]

select * from comments$

--What is the average sentiment score in each keyword category?
select v.keyword, AVG(c.sentiment) as Sentiment_Score
from [videos-stats$] as v
JOIN comments$ as c
ON v.[Video ID] = c.[Video ID]
group by v.Keyword

--What is the ratio of views/likes per video? 
select title, likes, views, (views/likes) as ratio
from [videos-stats$]
where likes <> 0

--Per each category?
select keyword, SUM(likes), SUM(views), (SUM(views)/SUM(likes)) as ratio
from [videos-stats$]
where likes <> 0
group by keyword

--What are the most commented-upon videos? Or the most liked?
Select title, comments
from [videos-stats$]
order by comments desc

Select title, likes
from [videos-stats$]
order by likes desc

--How many total views does each category have? How many likes?
Select keyword, sum(views)
from [videos-stats$]
group by keyword

Select keyword, sum(likes)
from [videos-stats$]
group by keyword
