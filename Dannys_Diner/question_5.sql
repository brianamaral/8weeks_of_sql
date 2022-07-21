--Which item was the most popular for each customer?
SELECT DISTINCT ON (sl.customer_id) sl.customer_id
	,count(sl.product_id) AS times_purchased
	,mn.product_name
FROM dannys_diner.sales AS sl
JOIN dannys_diner.menu AS mn ON mn.product_id = sl.product_id
GROUP BY mn.product_name
	,sl.customer_id
ORDER BY 1
	,2 DESC
	,3;