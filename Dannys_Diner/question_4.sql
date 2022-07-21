--What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT mn.product_name
	,count(sl.product_id) AS times_purchased
FROM dannys_diner.sales AS sl
JOIN dannys_diner.menu AS mn ON mn.product_id = sl.product_id
GROUP BY mn.product_name
ORDER BY times_purchased DESC;