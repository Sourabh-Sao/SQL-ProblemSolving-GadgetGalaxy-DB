--* 11.Show all products that are discontinued. (WHERE, BOOLEAN)
select *
from products
where discontinued=1;

--* 12.List all employees with salary > 10000. (WHERE)
select *
from employees
where salary>10000;

--* 13.Show all orders handled by employee Steven King. (JOIN, WHERE)
select *
from orders od
join employees emp
USING(employee_id)
where employee_id=101;

--* 14.List all products supplied by Samsung. (JOIN)
select product_name
from products pd
join suppliers sp
using(supplier_id)
where supplier_id=1;

--* 15.Show all reviews with rating 5. (WHERE)
select *
from product_reviews
where rating =5; 

--* 16.Find the most recent order date. (MAX(), ORDER BY DESC LIMIT 1)
select order_date
from orders
ORDER BY order_date DESC
limit 1;

--* 17.List all payment methods used. (DISTINCT)
select DISTINCT payment_method
from payments;


--* 18.Show all customers who registered in 2022. (WHERE, YEAR())
select *
from customers
where YEAR(registration_date)=2022;


--* 19.List all products in 'Headphones' category. (JOIN, WHERE)
select product_name
from products pd
join categories ct
USING(category_id)
where ct.category_name='Headphones';


--* 20.Show total number of orders. (COUNT)
select count(*)
from orders;
