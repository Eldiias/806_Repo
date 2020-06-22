#lab 1
#1
select client_id from client
where district_id=1
order by client_id
limit 5;
#2
select client_id from client
where district_id=72
order by client_id desc
limit 1;
#3
select amount from loan
order by amount
limit 3;
#4
select status from loan 
group by status
order by status;

#4v2
select distinct status 
from loan 
order by status;

#5
select loan_id from loan
order by payments desc
limit 1;

#6
select account_id,amount from loan
order by account_id 
limit 5;

#7
select account_id from loan
where duration=60
order by amount
limit 5;

#8
select distinct k_symbol
from finance.order;

#9
select order_id
from finance.order
where account_id=34;

#10
select distinct account_id
from finance.order
where order_id>=29540 and order_id<=29560;

#10v2
select distinct account_id
from finance.order
where order_id between 29540 and 29560;

#11
select amount
from finance.order
where account_to=30067122;

#12
select trans_id, date, type, amount
from trans
where account_id=793
order by date desc
limit 10;


#lab2
#1
select district_id, count(*) from client
where district_id<10
group by district_id
order by district_id;

#2
select type, count(*) freq from card
group by type
order by freq desc;

#3
select account_id, sum(amount) totals
from loan
group by account_id
order by totals desc
limit 10;

#4
select date, count(*) from loan
where date<930907
group by date
order by date desc;

#5
select date, duration, count(*) from loan
where date between 971201 and 971231
group by date, duration;

#6
select account_id, type,sum(amount) as total_amount
from trans
where account_id=396
group by type
order by type;

#7
select account_id, 
(case 
when type='PRIJEM' then 'Incoming'
when type='VYDAJ' then 'Outgoing'
else 'Blaah' 
end) new_type,
sum(amount) as total_amount
from trans
where account_id=396
group by type
order by type;


#8
select account_id, round(sum(amount)) total_sum, round(sum(if(type='PRIJEM', amount,0)),2) total_in, round(sum(if(type='VYDAJ', amount,0)),2) total_out, round(sum(if(type='PRIJEM', amount,0))-sum(if(type='VYDAJ', amount,0)),2) pure_diff, round(sum(if(type='PRIJEM', amount,-amount)),2) diff
from trans
where account_id=396;

select account_id, round(sum(if(type='PRIJEM', amount,0))-sum(if(type='VYDAJ', amount,0)),2) pure_diff
from trans
group by account_id
order by pure_diff desc
limit 10;




#Lab3
#1
select district_id, count(distinct account_id) as ac_freq
from account
group by district_id
order by ac_freq desc
limit 5;

#2
select account_id, count(distinct amount) as diff, group_concat(distinct bank_to),group_concat(distinct amount)  from finance.order
where k_symbol='SIPO'
group by account_id
having diff>1;

#3
#option 1
select max(amount) am, district_id from 
(select account_id, amount from finance.order where k_symbol='UVER') ml
inner join account a on a.account_id=ml.account_id
group by district_id
order by am desc;

#option 2
create temporary table xxx
select l.account_id, district_id, amount
from account a
inner join loan l on l.account_id=a.account_id;

select * from xxx;

select district_id, max(amount) as total_amount
from xxx
group by district_id
order by 2 desc;

#challenge 4
#option 1
select sum(amount) am, district_id from 
(select account_id, amount from finance.order where k_symbol='UVER') ml
inner join account a on a.account_id=ml.account_id
group by district_id
order by am desc;

#option 2
select district_id, sum(amount) as total_amount
from xxx
group by district_id
order by 2 desc;

select * from trans;




#challenge 3
select count(*) from trans; 
select * from loan, (select count(*) from trans) as new; #  when we select from 2 tables, we get a table with combinations of each row from both tables. 

select type, count(*) from trans group by type;

select * from loan, (select type, count(*) from trans group by type) as new; #example #2


create table if not exists xxx 
select l.account_id, district_id, amount
from account a
inner join loan l on l.account_id=a.account_id;

select * from xxx x1, xxx x2;

select x1.district_id, x1.amount, count(x2.amount) as ranking
from xxx x1, xxx x2
where x1.district_id=x2.district_id and x1.amount<x2.amount
group by x1.district_id, x1.amount;



select x1.district_id, ceil(count(x1.amount)/2) rankng
from xxx x1
group by district_id;


select *
from 
(select x1.district_id, x1.amount, count(x2.amount) as ranking
from xxx x1, xxx x2
where x1.district_id=x2.district_id and x1.amount<x2.amount
group by x1.district_id, x1.amount) as ranked
where exists(
select x1.district_id, ceil(count(x1.amount)/2) rankng
from xxx x1
group by district_id
having ranked.district_id=x1.district_id
and ranked.ranking=ranking)
;
