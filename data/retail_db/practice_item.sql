SELECT order_date, count(*) As order_count
FROM orders
WHERE order_status IN ('COMPLETE','CLOSED')
GROUP BY 1
HAVING count(*) >= 120
ORDER BY 2 DESC;

SELECT order_item_order_id, round(sum(order_item_subtotal)::numeric,2) AS order_revenue
FROM order_items
GROUP BY 1
HAVING round(sum(order_item_subtotal)::numeric,2) >=2000
ORDER BY 2 DESC;

/* Joins */

SELECT o.order_date, oi.order_item_product_id,oi.order_item_subtotal
FROM orders as o
JOIN order_items as oi
ON o.order_id = oi.order_item_order_id


SELECT o.order_id,o.order_date,oi.order_item_id, oi.order_item_product_id,oi.order_item_subtotal
FROM orders as o
LEFT OUTER JOIN order_items as oi
ON o.order_id = oi.order_item_order_id
ORDER BY 1;

SELECT o.order_date, oi.order_item_product_id,oi.order_item_subtotal
FROM orders as o
JOIN order_items as oi
ON o.order_id = oi.order_item_order_id
WHERE o.order_status IN ('COMPLETE','CLOSED')

SELECT o.order_date, oi.order_item_product_id,round(sum(oi.order_item_subtotal)::numeric,2) As order_revenue
FROM orders as o
JOIN order_items as oi
ON o.order_id = oi.order_item_order_id
WHERE o.order_status IN ('COMPLETE','CLOSED')
GROUP BY 1,2
ORDER BY 1,3 DESC;


/* View */

CREATE OR REPLACE VIEW order_details_v
AS
SELECT o.*,
oi.order_item_product_id,
oi.order_item_subtotal,
oi.order_item_id
FROM orders as o
JOIN order_items as oi
ON o.order_id = oi.order_item_order_id;

SELECT * FROM order_details_v WHERE order_id = 2;

/* CTE */
WITH order_details_cte AS
(SELECT o.*,
oi.order_item_product_id,
oi.order_item_subtotal,
oi.order_item_id
FROM orders as o
JOIN order_items as oi
ON o.order_id = oi.order_item_order_id)

SELECT * FROM order_details_cte 
WHERE order_id = 2;

SELECT * FROM order_details_v;

SELECT * FROM products;  /*1345 result */

SELECT *
FROM products AS p
LEFT OUTER JOIN order_details_v As odv
ON p.product_id = odv.order_item_product_id
Where odv.order_item_product_id IS NULL;  /* 1245 */







