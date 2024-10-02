# SQL: Analyzing and Formatting PostgreSQL Sales Data
## Key Questions
What are the top-performing products in each category based on total sales?
How can sales performance be categorized by salesperson and market?
How can we impute missing data for the quantity of products per order?
## Skills Used
- SQL Queries and Joins
- Window Functions `RANK`
- Conditional Statements `CASE`
- Aggregation Functions `SUM` `COUNT`
- Common Table Expressions(CTEs)
- Data Type Casting
## Project Description
This project involves working with superstore data in PostgreSQL, reformatting and analyzing it to address day-to-day retail business questions. Key areas of focus include identifying top-performing products, categorizing sales performance by salesperson and market, and imputing missing data for product quantities per order.
## Project Instructions
In this project, I embarked on a journey to clean and analyze data from our hypothetical Super Store using SQL. The following methods were implemented to extract meaningful insights:

### 1. Identifying Top Products

I began by determining the top five products from each category based on their highest total sales. The goal was to sort the output by `category` in ascending order and by `sales` in descending order within each category. This approach allowed me to highlight the products with the highest profit margins at the top. I saved this query as `top_five_products_each_category`, including the following columns:
- `category`
- `product_name`
- `product_total_sales` (rounded to two decimal places)
- `product_total_profit` (rounded to two decimal places)
- `product_rank`
#### Output
[Top 5 Products each Category](top5_product_output.csv)

### 2. Categorizing Sales Performance**

Next, I focused on categorizing the sales performance of each salesperson and the markets in which they operate. I analyzed various metrics, such as the total count of `orders`, a categorized column called `sales_bin`, the count of `returned orders`, the sum of `sales` as `total_sales`, and the sum of returned sales as `returned_sales`. To create the `sales_bin`, I categorized sales into bins based on their value: `'0-100'`, `'100-500'`, and `'500+'`, ensuring that the lower range bound was inclusive and the upper bound excluded. The output was sorted by `person`, `market`, and `sales_bin`. This query was saved as `salesperson_market_sales_details`, containing the following columns:
- `person`
- `market`
- `sales_bin`
- `order_counts`
- `returned_orders`
- `total_sales`
- `returned_sales`
#### Output
[Salesperson Market Sales Details](saleperson_sales_output.csv)

### 3. Calculating Missing Quantity Values

Finally, I tackled the challenge of calculating quantities for orders with missing values in the `quantity` column. I first calculated the unit price for each product and then used this information to estimate how many of a given product were ordered for all orders where this information was missing. The output was ordered by `product_id` and saved as `impute_missing_values`, containing the following columns:
- `product_id`
- `discount`
- `market`
- `region`
- `sales`
- `quantity`
- `calculated_quantity` (rounded to zero decimal places)
#### Output
[Impute Missing Values](missing_values_output.csv)

## How I Approached the Project
Throughout this project, I took a structured approach to ensure thorough analysis:
1. I identified the top five products from each category based on the highest profit margins.
2. I categorized sales data by salesperson, market, and returned orders to gain insights into performance.
3. I calculated missing quantity values to ensure the integrity of the sales data.
## Code
The SQL code for this project can be found [here](analysis_formatting.sql)
## Conclusion
This analysis provides valuable insights into sales performance and product profitability within the retail environment. By identifying top-performing products, categorizing sales by individual and market, and estimating missing quantity data, the project demonstrates how SQL can be leveraged to derive actionable business intelligence. The results can assist stakeholders in making informed decisions regarding inventory management, sales strategies, and market focus.
## Analysis
The results obtained from the SQL queries indicate significant trends in sales performance and product popularity. By analyzing the top products in each category, businesses can prioritize inventory and promotional strategies to boost sales further. Additionally, understanding the sales performance by salesperson and market allows for targeted training and resource allocation, enhancing overall sales efficiency. The imputation of missing quantity values is crucial for accurate sales reporting and forecasting, ensuring that businesses have a complete view of their sales performance. Ultimately, this project highlights the importance of data-driven decision-making in retail operations.
