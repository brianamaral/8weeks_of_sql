--join all the things
SELECT sl.customer_id
	,sl.order_date
	,mn.product_name
	,mn.price
	,CASE 
		WHEN mb.customer_id IS NULL
			THEN 'N'
		WHEN order_date < join_date
			THEN 'N'
		ELSE 'Y'
		END AS member
FROM dannys_diner.sales AS sl
LEFT JOIN dannys_diner.members AS mb ON mb.customer_id = sl.customer_id
JOIN dannys_diner.menu AS mn ON mn.product_id = sl.product_id
ORDER BY customer_id
	,order_date;