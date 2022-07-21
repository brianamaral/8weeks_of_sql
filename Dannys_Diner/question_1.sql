-- What is the total amount each customer spent at the restaurant?
SELECT sl.customer_id
	,sum(mn.price) AS total_spent
FROM dannys_diner.sales AS sl
JOIN dannys_diner.menu AS mn ON mn.product_id = sl.product_id
GROUP BY sl.customer_id;