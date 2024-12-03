EXPLAIN
SELECT * From Orders Where order_id = 2;

EXPLAIN
SELECT o.* , round(sum(oi.order_item_subtotal)::numeric,2) As revenue
FROM orders as o
JOIN order_items as oi
ON o.order_id =oi.order_item_order_id
Where o.order_id = 2
Group by o.order_id, o.order_date, o.order_customer_id,o.order_status;


SELECT o.* , round(sum(oi.order_item_subtotal)::numeric,2) As revenue
FROM orders as o
JOIN order_items as oi
ON o.order_id =oi.order_item_order_id
Where o.order_id = 2
Group by o.order_id, o.order_date, o.order_customer_id,o.order_status;
