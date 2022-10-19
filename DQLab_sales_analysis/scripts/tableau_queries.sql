-- Current performance metrics (2012)
SELECT SUM(CAST(sales as BIGINT)) as total_sales, COUNT(order_status) as total_transactions, COUNT(DISTINCT customer) as total_customers
FROM DQLab_Sales_Database..dqlab_sales_data
WHERE YEAR(order_date) = 2012 AND order_status = 'Order Finished'

-- Year on year total sales
SELECT YEAR(order_date) as years, SUM(CAST(sales as bigint)) as total_sales
FROM DQLab_Sales_Database..dqlab_sales_data
WHERE order_status = 'Order Finished'
GROUP BY YEAR(order_date)
ORDER BY years;

-- Break down of each sub category item sale vs total sales for year 2012
WITH Total_sales (total_sales)
AS 
(
	SELECT SUM(CAST(sales as BIGINT))
	FROM DQLab_Sales_Database..dqlab_sales_data
	WHERE YEAR(order_date) = 2012
)

SELECT db.product_sub_category, SUM(CAST(db.sales as BIGINT) * 1.0 / ts.total_sales) * 100 as percentage_sale
FROM DQLab_Sales_Database..dqlab_sales_data as db, Total_sales as ts
WHERE YEAR(db.order_date) = 2012
GROUP BY db.product_sub_category
ORDER BY 2 DESC;

-- Overall sale growth rate per product sub category
SELECT product_sub_category,
	   ROUND((sales_2012 - sales_2009) / CAST(sales_2009 as float), 4) * 100 as 'Overall growth_rate (%)'
FROM
(
	SELECT product_sub_category,
			SUM (CASE
				WHEN YEAR(order_date) = 2009 THEN sales
				ELSE 0
				END) AS sales_2009,
			SUM (CASE
				WHEN YEAR(order_date) = 2012 THEN sales
				ELSE 0
				END) AS sales_2012
	FROM DQLab_Sales_Database..dqlab_sales_data
	GROUP BY product_sub_category
) as sub_category
ORDER BY 2 DESC;

-- Year on year new customer growth
SELECT YEAR(date_first_transaction) as years, COUNT(DISTINCT customer) as new_customers
FROM (
	SELECT customer, MIN(order_date) AS date_first_transaction
	FROM DQLab_Sales_Database..dqlab_sales_data
	WHERE order_status = 'Order Finished'
	GROUP BY customer
	) as customer_first_trans_tab
GROUP BY YEAR(date_first_transaction)
ORDER BY 1;