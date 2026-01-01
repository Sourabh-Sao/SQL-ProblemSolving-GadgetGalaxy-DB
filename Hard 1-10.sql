--* 1.Rank customers by total spending (2024 only) using RANK() and DENSE_RANK().
-- todo- In SQL, PARTITION BY acts like a "Group By" for your window function. If you omit it, the database treats the entire result set as one single group.
select customer_id,first_name,SUM(total_amount) as total_spending,
DENSE_RANK() OVER(ORDER by SUM(total_amount) desc) as dense_rnk,
RANK() OVER(ORDER by SUM(total_amount) desc) as rnk
from customers
join orders
USING(customer_id)
where YEAR(order_date)=2024
GROUP BY 1,2


-- todo -> below is basic understanding of running total(cumulative sale/sum)
select customer_id,
SUM(customer_id) over(order by customer_id asc)
from customers;

--* 2.Show running total of monthly sales in 2024. (Window SUM() OVER ORDER BY)
with cte as (
select month(order_date) as months,SUM(total_amount) as total_revenue
from orders
where year(order_date)=2024
GROUP BY 1
)
select months,total_revenue,SUM(total_revenue) OVER(ORDER BY months)
from cte


--* 3.Find top 3 selling products each month in 2024. (Window RANK() + QUALIFY if Snowflake/ PARTITION BY)

with cte as (
select MONTH(order_date)Month,product_name,SUM(quantity)qty,
RANK() OVER(PARTITION BY MONTH(order_date) ORDER BY SUM(quantity) desc) as rnk
from order_items
join products USING(product_id)
join orders USING(order_id)
GROUP BY 1,2
)SELECT *
from cte 
where rnk<=3

-- todo -> Recusive CTE (1 to 5 using recusive CTE)
with RECURSIVE cte as (
    select 1 as n
    union all
    select n+1 from cte
    where n<5
)SELECT *
from cte

with RECURSIVE cte as (
    select employee_id,first_name,manager_id
    from employees
    where employee_id=108

    union all

    select employees.employee_id,employees.first_name,employees.manager_id
    from employees
    join cte 
    on employees.employee_id=cte.manager_id

)select *
from cte

--* 4.Show employee hierarchy — full org chart using recursive CTE (Who reports to whom)
with RECURSIVE cte as (

    select employee_id,first_name,manager_id
    from employees
    where manager_id is null

    union all

    select employees.employee_id,employees.first_name,employees.manager_id
    from employees join cte
    on employees.manager_id=cte.employee_id

)select *
from cte


--* 5.Category hierarchy — show full path like "Electronics > Audio > Headphones" using recursive CTE.
with RECURSIVE cte as (
    select category_id,category_name,parent_category_id
    from categories
    where parent_category_id is NULL

    union ALL

    select categories.category_id,categories.category_name,categories.parent_category_id
    from categories
    join cte on categories.parent_category_id=cte.category_id
)select *
FROM cte


--* 6.Find customers whose spending increased every month (gaps & islands + window LAG).

with cte as (
select customer_id,MONTH(order_date) mth,SUM(total_amount) as current_month_spending
from customers
join orders
USING(customer_id)
GROUP BY 1,2
)select *, LAG(current_month_spending) over(PARTITION BY customer_id order by mth) as previous_month_spending
from cte

with cte as (
select customer_id,MONTH(order_date) mth,sum(total_amount )as current_mth_spending
from customers
join orders
USING(customer_id)
group by 1,2
),cte2 as (
select *,
LAG(current_mth_spending) OVER(PARTITION BY customer_id ORDER BY mth) as prev_month_sale
from cte   
),cte3 as (
    select *,
    CASE 
        WHEN prev_month_Sale is not null and current_mth_spending<=prev_month_sale THEN 1  
        ELSE 0  
    END as flg
    from cte2
) select customer_id
from cte3
GROUP BY 1
having SUM(flg)=0




--* 7.Show 3-month moving average of sales.
--* 8.Customer retention cohort analysis (month of first purchase vs subsequent months).
--* 9.Find products with biggest price drop in orders vs list_price.
--* 10.Show ABC analysis of products by revenue (A=80%, B=15%, C=5%).
