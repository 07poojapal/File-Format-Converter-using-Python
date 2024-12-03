SELECT * FROM order_details_v; /* 172198 */
SELECT * FROM products; /* 1345 */
SELECT * 
FROM products as p
LEFT OUTER JOIN order_details_v As odv
ON p.product_id = odv.order_item_product_id
where odv.order_item_product_id is NULL;  /* 1245 */

SELECT * 
FROM products as p
     LEFT OUTER JOIN order_details_v As odv
         ON p.product_id = odv.order_item_product_id
where to_char(odv.order_date::timestamp,'yyyy-MM') = '2014-01'
   AND odv.order_item_product_id is NULL;   /* This query has a bug */

   
/* using exists clause */
SELECT *
FROM products as p
Where NOT EXISTS (
SELECT 1 FROM order_details_v as odv
WHERE p.product_id = odv.order_item_product_id
AND to_char(odv.order_date::timestamp,'yyyy-MM')='2014-01'
)

SELECT * 
FROM products as p
     LEFT OUTER JOIN order_details_v As odv
         ON p.product_id = odv.order_item_product_id
AND to_char(odv.order_date::timestamp,'yyyy-MM') = '2014-01'
   WHERE  odv.order_item_product_id is NULL;  

/* creating empty tables using CTAS concept | by using table name from another table */

CREATE TABLE orders_stg
AS
SELECT * FROM orders WHERE False;

SELECT * FROM orders_stg;

/* Query to compute daily revenue */

Select * from orders;  /* order id, order_date, order_customer_id, order_status */
Select * from order_items; 
/* order_item_id, order_item_order_id, order_item_product_id,order_item_quantity,order_item_subtotal,order_item_product_price */

SELECT o.order_date, round(sum(oi.order_item_subtotal)::numeric,2) as order_revenue
From orders as o
JOIN order_items as oi
on o.order_id = oi.order_item_order_id
Where o.order_status IN ('COMPLETE','CLOSED')
Group by 1
Order by 1;

/* Query result gives order_date along with the order_revernue */

/* using CTS */
CREATE TABLE daily_revenue
AS
SELECT o.order_date, round(sum(oi.order_item_subtotal)::numeric,2) as order_revenue
From orders as o
JOIN order_items as oi
on o.order_id = oi.order_item_order_id
Where o.order_status IN ('COMPLETE','CLOSED')
Group by 1

/* to use the order by we can use it alongwith select statement */

SELECT * FROM daily_revenue
ORDER BY order_date;

CREATE TABLE daily_product_revenue
AS
SELECT o.order_date, oi.order_item_product_id, round(sum(oi.order_item_subtotal)::numeric,2) as order_revenue
From orders as o
JOIN order_items as oi
on o.order_id = oi.order_item_order_id
Where o.order_status IN ('COMPLETE','CLOSED')
Group by 1,2;

SELECT * FROM daily_product_revenue
ORDER BY 1,3 DESC;

SELECT * from daily_revenue
ORDER BY 1;

/* To get the daily revenue and monthly revenue along with the order_date using over (PArtition by) */

SELECT to_char(dr.order_date::timestamp,'yyyy-MM') AS order_month,
       dr.order_date,
	   dr.order_revenue,
	   sum(order_revenue) OVER (
           PARTITION BY to_char(dr.order_date::timestamp,'yyyy-MM')
		   ) AS monthly_order_revenue
FROM daily_revenue AS dr
ORDER BY  2;

SELECT dr.*,
     sum(order_revenue) OVER (PARTITION BY 1) AS total_order_revenue
FROM daily_revenue AS dr
ORDER BY 1;

SELECT COUNT(*) from daily_product_revenue;

SELECT * From daily_product_revenue
ORDER BY order_date,order_revenue DESC;

--rank()
--Dense_rank()

--Global_ranking()
--Ranking based on partition key


SELECT order_date, order_item_product_id, order_revenue,
rank() over (order by order_revenue DESC) AS rnk,
dense_rank() over (order by order_revenue DESC) AS drnk
FROM daily_product_revenue
WHERE order_date = '2014-01-01 00:00:00.0'
ORDER BY order_revenue DESC;






