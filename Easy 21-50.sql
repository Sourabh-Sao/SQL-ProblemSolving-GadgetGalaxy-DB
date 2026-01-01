--* 21.List all employees who have a manager. (IS NOT NULL)
select *
from employees
where manager_id is not null;

--* 22.Show all products with stock less than 50. (WHERE)
select product_name
from products
where units_in_stock<50;

--* 23.List all cancelled orders. (WHERE)
select *
from orders
where status='Cancelled';

--* 24.Show all customers from Gold segment. (WHERE)
select *
from customers
where customer_segment='Gold';

--* 25.Find the cheapest product. (MIN(), ORDER BY ASC LIMIT 1)
select product_name,cost_price
from products
order by cost_price ASC
limit 1;


--* 26.List all employees in Sales department. (JOIN)
select first_name,last_name,department_name
from employees emp
join departments dp
USING(department_id)
WHERE department_id=1;

--* 27.Show all orders with total_amount > 2000. (WHERE)
SELECT *
from orders
where total_amount>2000;

--* 28.List all products without supplier (NULL supplier_id). (LEFT JOIN, IS NULL)
select pd.product_name,sp.supplier_id
from products pd
left join suppliers sp
on pd.supplier_id=sp.supplier_id
where sp.supplier_id is null;


--* 30.Show top 5 customers who placed most orders. (GROUP BY, COUNT, ORDER BY DESC LIMIT)
select cu.customer_id,cu.first_name,
count(*) as Order_Count
from customers cu
join orders od
USING(customer_id)
group by 1,2
order by 3 DESC
limit 5;

--* 31.List all reviews posted in 2024. (WHERE, YEAR)
select *
from product_reviews
where YEAR(review_date)=2024;


--* 32.Show average product list price. (AVG)
select product_name,avg(list_price)
from products
group by product_name

--* 33.List all employees with commission. (IS NOT NULL)
select first_name
from employees
where commission_pct is not null;

--*⭐ 34.Show all orders shipped after order date + 5 days. (DATEDIFF / INTERVAL)
select *
from orders
where DATEDIFF(shipped_date,order_date)>5;

-- ? Second Approach
select *
from orders
where shipped_date>order_date + INTERVAL 5 DAY;

--*⭐ 35.List all categories that are sub-categories of 'Audio'. (JOIN, WHERE)
SELECT c1.category_name
FROM categories c1
JOIN categories c2 ON c1.category_id = c2.parent_category_id
WHERE c2.category_name = 'Audio';


--* 36.Show total number of products per category. (GROUP BY, COUNT)
select category_name,count(p.product_name) as total_product
from categories
join products p
using(category_id)
group by category_name
order by 2 desc;


--* 37.List all customers who never placed an order. (LEFT JOIN, IS NULL)
select *
from customers c
left join orders o
on c.customer_id=o.customer_id
where o.order_id is NULL


--* 38.Show all products with discount > 0 in order_items. (JOIN, WHERE)
select product_name
from products
join order_items
USING(product_id)
where discount>0


--* 39.List top 3 highest paid employees. (ORDER BY DESC LIMIT)
select CONCAT(first_name," ",last_name),salary
from employees
order by salary DESC
limit 3;

--* 40.Show all orders placed on weekends. (DAYOFWEEK / WEEKDAY)
select *
from orders
where WEEKDAY(order_date) in(5,6);
--? Alternate Solution
select *
from orders
where DAYOFWEEK(order_date) in (7,1);


--* 41.List all employees without commission. (WHERE commission_pct IS NULL OR = 0)
select *
from employees
where commission_pct=0;


--* 42.Show total revenue from completed orders. (SUM, WHERE)
select SUM(total_amount)
from orders
where status='Completed';

--* 43.List all suppliers who supply Mobile Phones. (JOIN ×2)
select supplier_name
from categories c
join products p
USING(category_id)
join suppliers s
USING(supplier_id)
where category_name='Mobile Phones'

--* 44.Show number of orders per status. (GROUP BY, COUNT)
select status ,count(*) as Order_Count
from orders
group by status;


--* 45.List all customers from Europe region (UK, Spain, Germany). (IN)
select *
from customers
where country in ('UK','Spain','Germany')

--* 46.Show all products launched after iPhone 15 Pro. (WHERE launch_date >)
select *
from products
where launch_date >'2023-09-22';


--* 46.List all employees who report to Steven King (manager_id = 101). (WHERE)
select first_name
from employees
where manager_id=101;

--* 47.Show average rating per product. (GROUP BY, AVG)
select product_name,AVG(rating)
from products
join product_reviews
using(product_id)
GROUP BY product_name;

--* 48.List all orders placed by Gold customers. (JOIN, WHERE)
select *
from customers
join orders
USING(customer_id)
where customer_segment ='Gold';


--* 49.Show the most expensive order ever placed. (MAX, LIMIT)
select *
from orders
order by total_amount DESC
limit 1;

--* 50.List all employees in North America region. (JOIN ×2)
select first_name
from employees
join departments
using(department_id)
join regions
using(region_id)
where region_name='North America';
