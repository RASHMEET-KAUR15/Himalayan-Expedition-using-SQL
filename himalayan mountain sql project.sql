/*Retrieving data from all the tables*/
select* from db.deaths;
select* from db1.peaks;
select* from db2.expeditions;
select* from db3.summiters;

/*popular seasons to climb*/
select peak_name,season,count(peak_id) as no_of_expeditions
from db2.expeditions
where peak_name in( select peak_name
from(select peak_name,count(peak_id) as no_of_expeditions,
rank()over(order by count(peak_id) desc)rnk
from db2.expeditions
group by peak_name
order by count(peak_id) desc) rnk_table
where rnk<11)
group by peak_name,season
order by count(peak_id) desc;
/*The most popular seasons to climb mountains are autumn and spring*/

/*peak_wise top 3 participating countries*/
select peak_name,nationality,no_of_expeditions
from(
select peak_name,nationality,count(peak_id) as no_of_expeditions,
dense_rank()over(partition by peak_name order by count(peak_id) desc)rnk
from db2.expeditions
where peak_name in(
select peak_name from (select peak_name,count(peak_id) as no_of_expeditions,
rank()over (order by count(peak_id)  desc)rnk1
from db2.expeditions
group by peak_name) rnk1_table
where rnk1<11)
group by peak_name,nationality) as rnk_table
where rnk<4;
/*Most number of climbers are from USA followed by UK*/

/*Past ten years number of expeditions*/
select year,count(peak_id) as no_of_expeditions
from db2.expeditions
group by year
order by year desc
limit 10;
/*During the year 2020 the number of expeditions was only 3 ,if we compare these with 2019 and 2018 it shows a sharp decline

/*The most popular host countries*/
select peak_name,host_country,count(peak_id) as no_of_expeditions
from db2.expeditions
where peak_name in( select peak_name
from(select peak_name,count(peak_id) as no_of_expeditions,
rank()over(order by count(peak_id) desc)rnk
from db2.expeditions
group by peak_name
order by count(peak_id) desc) rnk_table
where rnk<11)
group by peak_name,host_country
order by count(peak_id) desc;
/*The most popular host countries are nepal and china*/

/*cause of death*/
select cause_of_death,count(peak_id) as no_of_expeditions
from db.deaths
where peak_name in(select peak_name
from(select peak_name,count(peak_id) as no_of_expeditions,
rank()over(order by count(peak_id) desc)rnk
from db2.expeditions
group by peak_name
order by count(peak_id) desc) rnk_table
where rnk<11)
group by cause_of_death
order by count(peak_id) desc;
/*The main causes of death are Avalanche,fall,AMS(Altitude Mountain Sickness) and illness*/

/*Top 3 routes peak-wise*/

select peak_name,count(peak_id)as no_of_expeditions,(rte_1_name) as route_name
from(
select peak_name,rte_1_name,count(peak_id) as no_of_expeditions,
dense_rank() over(partition by peak_name order by count(peak_id) desc)rnk
from db2.expeditions
where rte_1_name is not null and peak_name in( select peak_name
from(select peak_name,count(peak_id) as no_of_expeditions,
rank()over(order by count(peak_id) desc)rnk
from db2.expeditions
group by peak_name)rnk_table
where rnk<11)
group by peak_name,rte_1_name)rnk1_table
where rnk<4
order by count(peak_id)desc;
/*The best route to climb MT Everest is S col-SE Ridge and N col-NE ridge*/






