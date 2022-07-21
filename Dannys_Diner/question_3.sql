SELECT DISTINCT ON (sl.customer_id) sl.customer_id
	,sl.order_date::DATE
	,mn.product_name
FROM dannys_diner.sales AS sl
JOIN dannys_diner.menu AS mn ON mn.product_id = sl.product_id
ORDER BY 1
	,2
	,3;