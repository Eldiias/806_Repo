use publications;

select a.au_id, a.au_lname, a.au_fname, t.title, p.pub_name
from authors a
inner join titleauthor ta on a.au_id=ta.au_id
inner join titles t on t.title_id=ta.title_id
inner join publishers p on t.pub_id=p.pub_id;


select a.au_id, a.au_lname, a.au_fname, count(t.title) as nbpub, p.pub_name
from authors a
inner join titleauthor ta on a.au_id=ta.au_id
inner join titles t on t.title_id=ta.title_id
inner join publishers p on t.pub_id=p.pub_id
group by a.au_id, p.pub_name
order by nbpub desc;

select a.au_id, a.au_lname, a.au_fname, sum(t.ytd_sales) as total, t.title
from authors a
inner join titleauthor ta on a.au_id=ta.au_id
inner join titles t on t.title_id=ta.title_id
group by a.au_id,t.title
order by total desc;

select a.au_id, a.au_lname, a.au_fname, ifnull(sum(t.ytd_sales),0) as total, t.title
from authors a
inner join titleauthor ta on a.au_id=ta.au_id
inner join titles t on t.title_id=ta.title_id
group by a.au_id,t.title
order by total desc;