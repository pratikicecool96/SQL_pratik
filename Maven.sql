SELECT * FROM maven.customers;

select * from maven.sales;

select * from maven.stores;

select * from maven.employees;

select * from maven.products;

select concat( customer_firstname,' ', customer_lastname)
, unit_price*quantity_sold as spent, sum(quantity_sold) as total_quantity
from maven.customers m
join maven.sales c on c.customer_id=m.customer_id
group by customer_firstname
order by spent desc;


select sum(quantity_sold) as total_sold
, concat(b.first_name,' ',b.last_name)as Employee_name
 from maven.sales g
join maven.employees b on b.staff_id= g.staff_id
group by employee_name
order by total_sold desc;

select *,case when gender ="M" then "MALE" else "FEMALE" end as sex from maven.customers;

select sum(quantity_sold) as total_sold, sum(unit_price*quantity_sold) as total_collection,m.store_id
, concat(b.first_name, ' ',b.last_name) as full_name ,store_city from maven.sales m
join maven.stores j on j.store_id=m.store_id 
join maven.employees b on b.staff_id =m.staff_id
group by m.store_id, full_name
order by store_id,total_collection desc;

select sum(quantity_sold) as total_sold, sum(unit_price*quantity_sold) as total_collection,
 j.product_category, concat (k.first_name,' ',k.last_name ) as full_name,m.store_id from 
 maven.sales p
 join maven.employees k on k.staff_id = p.staff_id
 join maven.stores m on m.store_id=p.store_id
 join maven.products j on j.product_id=p.product_id
 group by j.product_category, p.staff_id
 order by full_name,total_collection desc, product_category;
 


 

 select * from(select  concat (k.first_name,' ',k.last_name ) as full_name, m.store_id,
 rank() over(partition by store_id order by sum(unit_price*quantity_sold) desc )as rankings,
 sum(quantity_sold) as total_sold, sum(unit_price*quantity_sold) as total_collection from maven.sales p
  join maven.employees k on k.staff_id = p.staff_id
 join maven.stores m on m.store_id=p.store_id
 join maven.products j on j.product_id=p.product_id
  group by  m.store_id) g
 where rankings<2;
 
 select * from(select  concat (k.first_name,' ',k.last_name ) as full_name, m.store_id,sum(j.current_retail_price-current_cost) as profit,
 rank() over(partition by store_id order by sum(j.current_retail_price-j.current_cost ) desc )as rankings,
 sum(quantity_sold) as total_sold, sum(unit_price*quantity_sold) as total_collection from maven.sales p
  join maven.employees k on k.staff_id = p.staff_id
 join maven.stores m on m.store_id=p.store_id
 join maven.products j on j.product_id=p.product_id
  group by  m.store_id) g
 where rankings<2; 
 
 select m.store_id, sum(j.current_retail_price-j.current_cost) as profit,
 rank() over (partition by store_id order by sum(j.current_retail_price-j.current_cost) desc)
from maven.sales m
join maven.stores j on j.store_id= m.store_id
group by m.store_id
limit 5;