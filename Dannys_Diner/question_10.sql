-- In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
SELECT sl.customer_id
	,sum(CASE 
			WHEN mn.product_name = 'sushi'
				THEN mn.price * 20
			WHEN sl.order_date >= mb.join_date + interval '7 days'
				THEN mn.price * 20
			ELSE mn.price * 10
			END) AS points
FROM dannys_diner.sales AS sl
JOIN dannys_diner.members AS mb ON mb.customer_id = sl.customer_id
JOIN dannys_diner.menu AS mn ON mn.product_id = sl.product_id
GROUP BY sl.customer_id;