--What is the total items and amount spent for each member before they became a member?
WITH total_spent
AS (
	SELECT sl.customer_id
		,sum(mn.price) AS total_spent
	FROM dannys_diner.sales AS sl
	JOIN dannys_diner.menu AS mn ON mn.product_id = sl.product_id
	JOIN dannys_diner.members AS mb ON mb.customer_id = sl.customer_id
	WHERE sl.order_date < mb.join_date
	GROUP BY sl.customer_id
	)
SELECT sl.customer_id
	,count(sl.product_id)
	,ts.total_spent
FROM dannys_diner.sales AS sl
JOIN dannys_diner.members AS mb ON mb.customer_id = sl.customer_id
JOIN total_spent AS ts ON ts.customer_id = sl.customer_id
WHERE sl.order_date < mb.join_date
GROUP BY sl.customer_id
	,ts.total_spent;