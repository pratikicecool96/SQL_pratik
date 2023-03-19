select * from newschema.wallmart;

select count(*) from newschema.wallmart;

select * from newschema.wallmart where category= 'Labels';

select state,sum(profit) from newschema.wallmart
group by state;

select state,sum(sales) from newschema.wallmart 
group by state;

select *, sales-profit as Cost, sales/quantity as price, (sales/quantity)-(profit/quantity) as unit_cost from newschema.wallmart;

select category,sum(profit) from newschema.wallmart 
group by category 
order by sum(profit) desc;

select category,sum(sales)from newschema.wallmart
group by category 
order by sum(sales) desc;

select category,sum(profit),sum(sales), sum(profit)/sum(sales)*100 as margin from newschema.wallmart 
group by category
order by margin desc;

select state,sum(profit),sum(sales), sum(profit)/sum(sales)*100 as margin from newschema.wallmart 
group by state
order by margin desc;

select customer_name,sum(profit) from newschema.wallmart 
group by customer_name 
order by sum(profit) desc
limit 10;

select state, city , sum(profit) from newschema.wallmart
group by state,city
order by state,sum(Profit) desc;

select State, city ,sum(profit),rank() over (partition by state
order by sum(profit) desc) as rankings
from newschema.wallmart 
group by state,city;

select category,avg(sales/quantity) as price from newschema.wallmart
group by category
order by price desc
limit 5;

select * from(select State, city ,sum(profit),rank() over (partition by state
order by sum(profit) desc) as rankings
from newschema.wallmart 
group by state,city)f
WHERE RANKINGS <2;

select * from(select State, city ,sum(sales) as sales,rank() over (partition by state
order by sum(sales) desc) as rankings
from newschema.wallmart 
group by state,city)f
WHERE RANKINGS <2
order by sales desc;

select state,city, avg(quantity) from newschema.wallmart 
group by state,city
order by state,city;

select state ,count(*) as orders from newschema.wallmart
group by state
order by orders desc;

select customer_name from newschema.wallmart
where category in ('Copiers', 'Tables','Bookcases');

select * from(select Category,Customer_Name ,sum(SALES),rank() over (partition by CATEGORY
order by sum(SALES) desc) as rankings
from newschema.wallmart 
group by CATEGORY,Customer_Name)f
WHERE RANKINGS <2;

select * from(select Category,Product_Name ,sum(Profit),rank() over (partition by CATEGORY
order by sum(Profit) DESC ) AS Rankings
from newschema.wallmart 
group by CATEGORY,PRODUCT_NAME)L
WHERE RANKINGS <2;

SELECT category, avg(sales/quantity)as Pricing from newschema.wallmart;