# SQL DQLab Sales Analysis

This is a simple SQL project to analyze sales performance of a company. It also helps beginners that are looking to start their first SQL project as it teaches basic SQL technical concepts such as importing data and SQL coding.

## Clone repository
Clone the repository to your local machine using
```bash
git clone 
```

## Data and Importing Data
The dataset used contains transactions from 2009 to 2012 with a total 5500 data points. The raw data is provided as an Excel file `clean-data.csv`.

The dataset contains the following fields:
1. OrderID
2. Order Status
3. Customer
4. Order Date
5. Order Quantity
6. Sales
7. Discount %
8. Discount
9. Product Category
10. Product Sub-Category

Import the data accordignly depending on the IDE you are using. 

## Tasks
Through the data has given, the manager of DQLab Store wants to know :

1. Order numbers and total sales from 2009 until 2012 which order status is finished
2. Total sales for each sub-category of product on 2011 and 2012, and growth rate of sales between 2011 and 2012
3. The effectiveness and efficiency of promotions carried out so far, by calculating the burn rate of the overall promotions by year
4. The effectiveness and efficiency of promotions carried out so far, by calculating the burn rate of the overall promotions by sub-category of product on 2012
5. The number of customers transactions for each year
6. The number of new customers for each year

## Run Scripts
The SQL script is located in `dqlab_sales_analysis/scripts/scripts.sql`. Open the sql file in your SQL IDE and execute the query lines accordingly.

Another SQL script for Tableau queries is located in `dqlab_sales_analysis/scripts/tableau_queries.sql`. These are executed to produce the necessary Excel files for visualization in Tableau.