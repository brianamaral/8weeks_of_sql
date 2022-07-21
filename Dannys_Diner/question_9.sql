-- If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
SELECT sl.customer_id
	,sum(CASE 
			WHEN mn.product_name = 'sushi'
				THEN mn.price * 20
			ELSE mn.price * 10
			END) AS points
FROM dannys_diner.sales AS sl
JOIN dannys_diner.menu AS mn ON mn.product_id = sl.product_id
GROUP BY sl.customer_id;