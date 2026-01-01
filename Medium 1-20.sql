--* 1.Show monthly total sales in 2024. (GROUP BY MONTH, YEAR
select YEAR(order_date)as Year,MONTH(order_date) as Month,SUM(total_amount) as total_Sales
from orders
where YEAR(order_date)=2024
group by 1,2;


--* 2.Find customers who placed more than 3 orders. (GROUP BY, HAVING)
select customer_id,first_name,count(customer_id)as order_count
from orders
join customers
USING(customer_id)
group by 1,2
having COUNT(customer_id)>3;


--* 3.List products that have never been ordered. (LEFT JOIN, IS NULL)
select product_name
from products
left join order_items
USING(product_id)
where order_id is null;


--* 4.Show top 5 best-selling products by quantity. (SUM quantity, GROUP BY, ORDER BY DESC)
select product_name,sum(quantity)
from products
join order_items
USING(product_id)
GROUP BY 1
order by 2 desc;

-- ! Interview Level Question
--* 5.Find employees who earn more than their manager. (Self-join)
select e1.first_name as employee
from employees e1
join employees e2
on e1.manager_id=e2.employee_id
where e1.salary>e2.salary;


--* 6.Show customer name and their total spending. (JOIN, GROUP BY, SUM)
select first_name,sum(total_amount) as total_spending
from customers
join orders
USING(customer_id)
group by 1
order by 2 desc;

--* 7.List products with average review rating > 4.5. (JOIN, GROUP BY, AVG, HAVING)
select product_name,avg(rating)
from products
join product_reviews
using (product_id)
GROUP BY 1
having avg(rating)>4.5;



--* 8.Find orders that were never paid. (LEFT JOIN payments, IS NULL)
select order_id
from orders
left join payments
USING(order_id)
where payment_id is null

-- ? Formula for YoY%
-- * YOY% = 
--?  ((current year sale - previous year sale)/previous year sale)*100

--* 9.Show year-over-year sales growth 2023 vs 2024. (CTE or subquery)

--! Interview Level Question 
--* 10.List customers who bought both iPhone and AirPods. (Self-join order_items or EXISTS)
select first_name,product_name
from customers c
join orders o
using(customer_id)
join order_items oi
USING(order_id)
join products 
USING(product_id)
where product_name like "%iPhone%" and 
EXISTS (
        select 1
        from orders o2
        join order_items
        USING(order_id)
        join products 
        USING(product_id)
        where c.customer_id=o2.customer_id and 
        product_name like "%Air%"
)


--* 11.Show top 3 categories by revenue. (SUM(unit_pricequantity(1-discount)))
select category_name,
sum(quantity*unit_price - discount) as total_revenue
from products
join order_items
USING(product_id)
join categories
USING(category_id)
group by 1
order by 2 desc 
limit 3;


--* 12.Find suppliers who supply more than 3 products. (GROUP BY, HAVING)
select supplier_name,count(1) as product_count
from suppliers
join products
USING(supplier_id)
group by 1
HAVING count(1)>3;

-- ! Interview level question
--* 13.Show employees and their manager's name. (LEFT JOIN self)
select e1.first_name as emp_name,e2.first_name as manager_name
from employees e1
left join employees e2
on e1.manager_id=e2.employee_id


--* 14.List products that are out of stock but still have orders. (JOIN, WHERE units_in_stock = 0)
SELECT product_name
FROM products
JOIN order_items ON products.product_id = order_items.product_id
WHERE units_in_stock = 0;


--* 15.Show average delivery time (shipped_date - order_date) in days. (DATEDIFF, AVG)
select ROUND(AVG(DATEDIFF(shipped_date,order_date)),2 )avg_delivery_time
from orders


--* 16.Find customers who only buy from Apple (supplier_id = 2). (NOT EXISTS or GROUP BY + HAVING)
-- ? here i only have to find customer who buys from apple only , so we count supplier only to be 1 
SELECT first_name
from customers
join orders USING(customer_id)
join order_items USING (order_id)
join products USING(product_id)
join suppliers USING(supplier_id)
where supplier_id=2
GROUP BY 1
having COUNT(DISTINCT supplier_id)=1

--* 17.Show monthly new customer count. (GROUP BY YEAR, MONTH registration_date)
select year(registration_date) as Year,MONTH(registration_date) as Month,count(1) as REGISTRATION_count
from customers
group by 1,2;


--* 18.List top 10 most helpful reviews (by helpful_votes).
select *
from product_reviews
order by helpful_votes desc
limit 10


--* 19.Show products that got cheaper over time (current list_price < original launch price — we'll assume we add a column later if needed) 
-- ? since i dont have launch price column
SELECT product_name, list_price, cost_price
FROM products
WHERE list_price > cost_price;


--* 20.Find repeat customers (customers with >1 order) and their second order date. (Window: ROW_NUMBER)
with cte as (
select customer_id,order_date,
ROW_NUMBER() OVER(PARTITION BY customer_id order by order_date asc) as rno
from customers
join orders
using(customer_id)
)
select customer_id,order_date as second_order_date
from cte 
where rno=2

