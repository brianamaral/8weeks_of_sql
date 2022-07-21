--Which item was purchased first by the customer after they became a member?
SELECT DISTINCT ON (sl.customer_id) sl.customer_id
	,sl.order_date::DATE
	,mn.product_name
FROM dannys_diner.sales AS sl
JOIN dannys_diner.menu AS mn ON mn.product_id = sl.product_id
JOIN dannys_diner.members AS mb ON mb.customer_id = sl.customer_id
WHERE sl.order_date > join_date
ORDER BY 1
	,2
	,3;