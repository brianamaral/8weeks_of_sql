## Case Study Questions
1. What is the total amount each customer spent at the restaurant?
```sql
SELECT sl.customer_id
	,sum(mn.price) AS total_spent
FROM dannys_diner.sales AS sl
JOIN dannys_diner.menu AS mn ON mn.product_id = sl.product_id
GROUP BY sl.customer_id;
```

2. How many days has each customer visited the restaurant?
```sql
SELECT customer_id
	,count(DISTINCT order_date) AS days_visited
FROM dannys_diner.sales
GROUP BY customer_id;
```

3. What was the first item from the menu purchased by each customer?
```sql
SELECT DISTINCT ON (sl.customer_id) sl.customer_id
	,sl.order_date::DATE
	,mn.product_name
FROM dannys_diner.sales AS sl
JOIN dannys_diner.menu AS mn ON mn.product_id = sl.product_id
ORDER BY 1
	,2
	,3;
```

4. What is the most purchased item on the menu and how many times was it purchased by all customers?
```sql
SELECT mn.product_name
	,count(sl.product_id) AS times_purchased
FROM dannys_diner.sales AS sl
JOIN dannys_diner.menu AS mn ON mn.product_id = sl.product_id
GROUP BY mn.product_name
ORDER BY times_purchased DESC;
```

5. Which item was the most popular for each customer?
```sql
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
```

6. Which item was purchased first by the customer after they became a member?
```sql
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
```

7. Which item was purchased just before the customer became a member?
```sql
SELECT DISTINCT ON (sl.customer_id) sl.customer_id
	,sl.order_date::DATE
	,mn.product_name
FROM dannys_diner.sales AS sl
JOIN dannys_diner.menu AS mn ON mn.product_id = sl.product_id
JOIN dannys_diner.members AS mb ON mb.customer_id = sl.customer_id
WHERE sl.order_date <= join_date
ORDER BY 1
	,2 DESC
	,3;
```

8. What is the total items and amount spent for each member before they became a member?
```sql
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
```

9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
```sql
SELECT sl.customer_id
	,sum(CASE 
			WHEN mn.product_name = 'sushi'
				THEN mn.price * 20
			ELSE mn.price * 10
			END) AS points
FROM dannys_diner.sales AS sl
JOIN dannys_diner.menu AS mn ON mn.product_id = sl.product_id
GROUP BY sl.customer_id;
```

10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
```sql
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
```