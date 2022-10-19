-- 1. Order numbers and total sales from 2009 until 2012 which order status is finished
SELECT YEAR(order_date) as years, SUM(CAST(sales as bigint)) as total_sales, COUNT(order_status) as number_of_orders
FROM DQLab_Sales_Database..dqlab_sales_data
WHERE order_status = 'Order Finished'
GROUP BY YEAR(order_date)
ORDER BY years;

-- Generally, number of orders have not changed much from 2009 - 2012, although there was a sharp drop in orders in 2011

-- 2. Total sales for each sub-category of product on 2011 and 2012, and growth rate of sales between 2011 and 2012
SELECT *, ROUND((sales_2012 - sales_2011) / CAST(sales_2011 as float), 4) * 100 as 'growth_rate (%)'
FROM
(
	SELECT product_sub_category,
			SUM (CASE
				WHEN YEAR(order_date) = 2011 THEN sales
				ELSE 0
				END) AS sales_2011,
			SUM (CASE
				WHEN YEAR(order_date) = 2012 THEN sales
				ELSE 0
				END) AS sales_2012
	FROM DQLab_Sales_Database..dqlab_sales_data
	GROUP BY product_sub_category
) as sub_category
ORDER BY 4 DESC;

-- Scissors, Rulers & Trimmers had the best overall growth rate from 2011-2012, while labels had the worst growth rate, where sales
-- declined by 26.33%

-- 3. The effectiveness and efficiency of promotions carried out so far, by calculating the burn rate of the overall promotions by year
-- Formula for burn rate is (total_discount / total sales) * 100. The higher the burn rate, the less effective promotions/discounts are
-- at improving sales

SELECT YEAR(order_date) as years, 
		SUM(CAST(sales as BIGINT)) as total_sales, 
		SUM(CAST(discount_value as BIGINT)) as total_discount,
		ROUND((SUM(CAST(discount_value as BIGINT)) / SUM(CAST(sales as float))) * 100, 2) as burn_rate
FROM DQLab_Sales_Database..dqlab_sales_data
GROUP BY YEAR(order_date)
ORDER BY 1;

-- Burn rate is generally increasing over time, which suggests that promotions/discounts are getting less effective at boosting sales

-- 4. The effectiveness and efficiency of promotions carried out so far, by calculating the burn rate of the overall promotions by sub-category of product on 2012
SELECT product_sub_category,
		product_category,
		SUM(CAST(sales as BIGINT)) as total_sales, 
		SUM(CAST(discount_value as BIGINT)) as total_discount,
		ROUND((SUM(CAST(discount_value as BIGINT)) / SUM(CAST(sales as float))) * 100, 2) as burn_rate
FROM DQLab_Sales_Database..dqlab_sales_data
WHERE YEAR(order_date) = 2012
GROUP BY product_sub_category, product_category
ORDER BY 5;

-- Scissors, Rulers & Trimmers had the worst burn rate at 6.35%, while Rubber Bands had the lowest burn rate of 2.93%

-- 5. The number of customers transactions for each year
SELECT YEAR(order_date) as years, 
		SUM(CAST(sales as BIGINT)) as total_sales, 
		COUNT(DISTINCT customer) as number_of_customers
FROM DQLab_Sales_Database..dqlab_sales_data
GROUP BY YEAR(order_date)
ORDER BY 1;

-- Generally, number of distinct customers have not changed much from 2009 - 2012, which means the company's consumer base is
-- pretty much stagnant. In addition, there was a sharp drop in total sales during 2010 and 2011 as compared to 2009. This suggests
-- that although the number of customers has not changed, the customers are buying less overall

-- 6. The number of new customers for each year
SELECT YEAR(date_first_transaction) as years, COUNT(DISTINCT customer) as new_customers
FROM (
	SELECT customer, MIN(order_date) AS date_first_transaction
	FROM DQLab_Sales_Database..dqlab_sales_data
	WHERE order_status = 'Order Finished'
	GROUP BY customer
	) as customer_first_trans_tab
GROUP BY YEAR(date_first_transaction)
ORDER BY 1;

-- The results paint a very worrying picture for the company. In 2009, the company had 585 new customers, but this has dropped drastically
-- over the years to only 11 new customers in 2012. That is almost a 98% decrease from the all-time high in 2009. This suggests that
-- the company is failing to attract new customers; possible reasons for this could be lack of innovation/new products or rise of
-- competitors. Furthermore, from this results we can also know that most of the sales stem from existing customers.

-- CONCLUSION
-- Overall, the results show that the company is more or less stagnant over the past 4 years from 2009-2012. This is evident from the
-- total amount of sales and number of new customers per year. 