--How many days has each customer visited the restaurant?
SELECT customer_id
	,count(DISTINCT order_date) AS days_visited
FROM dannys_diner.sales
GROUP BY customer_id;