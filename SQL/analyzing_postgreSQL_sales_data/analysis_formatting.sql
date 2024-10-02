-- top_five_products_each_category
SELECT * FROM (
SELECT products.category, 
	products.product_name,
	ROUND(SUM(CAST(ord.profit AS NUMERIC)), 2) AS total_profit,
	ROUND(SUM(CAST(ord.sales AS NUMERIC)), 2) AS total_sales,
	RANK() OVER(PARTITION BY products.category ORDER BY SUM(ord.sales) DESC) AS product_rank
	FROM orders AS ord
	INNER JOIN products
		ON ord.product_id = products.product_id
	GROUP BY products.category, products.product_name
) AS tmp
WHERE product_rank < 6;

-- salesperson_market_sales_details
SELECT ppl.person,
	ord.market,
	CASE WHEN ord.sales >= 0 AND ord.sales < 100	THEN '0-100'
		WHEN ord.sales >= 100 AND ord.sales < 500 THEN '100-500'
		WHEN ord.sales >= 500 THEN '500+'
		END AS sales_bin,
		COUNT(DISTINCT ord.order_id) AS order_counts,
		SUM(CASE WHEN ret.returned IS NULL THEN 0 ELSE 1 END) AS orders_returned,
		SUM(ord.sales) AS total_sales,
		SUM(CASE WHEN ret.returned IS NULL THEN 0 ELSE ord.sales END) AS returned_sales
FROM orders as ord
INNER JOIN people AS ppl
	ON ord.region = ppl.region
LEFT JOIN returned_orders AS ret
	ON ord.order_id = ret.order_id AND ord.market = ret.market
GROUP BY sales_bin, ord.market, ppl.person
ORDER BY ppl.person, ord.market, sales_bin;

-- impute_missing_values
WITH missing AS (
	SELECT product_id,
		discount, 
		market,
		region,
		sales,
		quantity
	FROM orders 
	WHERE quantity IS NULL
), 

unit_prices AS (SELECT o.product_id,
	CAST(o.sales / o.quantity AS NUMERIC) AS unit_price
FROM orders o
RIGHT JOIN missing AS m 
	ON o.product_id = m.product_id
	AND o.discount = m.discount
WHERE o.quantity IS NOT NULL
)

SELECT DISTINCT m.*,
	ROUND(CAST(m.sales AS NUMERIC) / up.unit_price,0) AS calculated_quantity
FROM missing AS m
INNER JOIN unit_prices AS up
	ON m.product_id = up.product_id;
