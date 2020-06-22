use publications2;

select * from titles;

SELECT 
    *
FROM
    titles;

select price
from titles
where price is not null;

select * from titles;

select distinct type from titles;

select * from titles;

select title, type, price from titles;

select title from titles;

select t.title from titles as t;

select titles.title from titles;

select * from titles t;

select * from titles order by price desc;

select * from titles order by price desc limit 5;

select count(title), type
from titles 
group by type;

select count(distinct title), type
from titles 
group by type;

select count(distinct title) as number_of_books, type
from titles 
group by type;

select count(distinct title) as "number of books", type
from titles 
group by type;

select * from jobs;

select max(min_lvl), min(max_lvl) from jobs;

select avg(min_lvl) from jobs;

select sum(min_lvl) from jobs;

#top 10 jobs with highest value of min_lvl
select * from jobs order by min_lvl desc limit 10;

select * from jobs order by min_lvl desc, max_lvl desc  limit 10;

select * from authors;

select distinct au_lname from authors;

select distinct au_lname, au_fname from authors; # creates an error

select * from authors;

select * from authors
where state='CA';

select * from authors
where state='CA' and contract!=1
;

select * from authors 
where (state='CA' and contract!=1) or state='KS';

select * from authors 
where state='CA' and contract!=1 or state='KS';

select * from authors
where state='IN' or state='KS';

select * from authors
where state in ('IN','KS');

select * from authors
where state in ('IN','KS', 'Ile-de-France');

select * from authors
where not contract=1;

select * from authors
where not contract=1 and state not in ('IN','TN');

select * from authors
where au_fname like '%star';

select * from authors
where au_fname like '%ar%';

select * from authors
where au_fname like '%rie%';

select * from authors
where au_fname like 'mar%';

select * from discounts;

select * from discounts
order by 5 desc;

select * from discounts
order by 5 desc
limit 1;

select * from discounts
where stor_id is null;

select * from discounts
where stor_id is not null;


select * from publishers;

select * from titles;

select *
from publishers pubs
inner join titles t
on pubs.pub_id=t.pub_id;

select pubs.pub_name, count(t.title_id) as titles
from publishers pubs
inner join titles t
on pubs.pub_id=t.pub_id
group by pubs.pub_name;

select distinct pub_name from publishers;

select pubs.pub_name, count(t.title_id) as titles
from publishers pubs
left join titles t
on pubs.pub_id=t.pub_id
group by pubs.pub_name;

select pubs.pub_name, count(t.title_id) as titles
from publishers pubs
right join titles t
on pubs.pub_id=t.pub_id
group by pubs.pub_name;

select *
from employee emp
left join jobs 
on emp.job_id=jobs.job_id;

select *
from employee emp
right join jobs 
on emp.job_id=jobs.job_id;

select *
from employee emp
left join jobs 
on emp.job_id=jobs.job_id
union
select *
from employee emp
right join jobs 
on emp.job_id=jobs.job_id;