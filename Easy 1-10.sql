--* 1. List all customers from USA. (WHERE)
select *
from customers
where country="USA"

--* 2. Show all products launched in 2023. (WHERE, DATE)
SELECT *
FROM products
WHERE YEAR(launch_date)=2023;

--* 3. Display all employees hired after 2023-01-01. (WHERE, ORDER BY)
SELECT *
FROM employees
WHERE DATE(hire_date)>'2023-01-01'
ORDER BY hire_date ASC;

--* 4.Find all orders placed in March 2024. (WHERE, DATE functions)
SELECT *
FROM orders
WHERE YEAR(order_date)=2024 AND MONTH(order_date)=3;


--* 5.List all completed orders. (WHERE)
SELECT *
FROM orders
WHERE status='Completed';

--* 6.Show top 10 most expensive products. (ORDER BY DESC, LIMIT)
SELECT *
FROM products
ORDER BY list_price DESC
LIMIT 10;

--* 7. List all categories that have a parent category. (IS NOT NULL)
SELECT category_name
from categories
where parent_category_id is NOT NULL; 

--* 8.Show all suppliers from South Korea or Japan. (IN / OR) 
select *
from suppliers
where country='South Korea' or country='Japan'

--* 9.List all customers whose email ends with @gmail.com. (LIKE)
SELECT first_name,email
from customers
where email like "%@gmail.com"; 

--* 10.Show total number of customers. (COUNT(*))
select COUNT(*) as Total_Customer
from customers;

