DROP INDEX orders_order_date_idx;

ALTER TABLE order_items ADD
FOREIGN KEY (order_item_order_id) REFERENCES orders (order_id);

COMMIT;

SELECT o.*,oi.*
FROM orders AS o
JOIN order_items AS oi
ON o.order_id = oi.order_item_order_id
WHERE o.order_customer_id = 5

ALTER TABLE orders
ADD FOREIGN KEY (order_customer_id) REFERENCES customers (customer_id);

-- creating indexes to reduce the execution time 

CREATE INDEX orders_order_customer_id_idx
ON orders (order_customer_id);


CREATE INDEX order_items_order_item_order_id_idx
ON order_items (order_item_order_id);

