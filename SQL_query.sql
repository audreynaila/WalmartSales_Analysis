-- Create table
CREATE TABLE IF NOT EXISTS `sqlqueries-427408.ordersMarkets.orders` (
    `Order Id` STRING,
    `Order Date` DATE,
    `Ship Mode` STRING,
    Segment STRING,
    Country STRING,
    City STRING,
    State STRING,
    `Postal Code` INT64,
    Region STRING,
    Category STRING,
    `Sub Category` STRING,
    `Product Id` STRING,
    `cost price` FLOAT64,
    `List Price` FLOAT64,
    Quantity INT64,
    `Discount Percent` FLOAT64
);

-- Data cleaning
SELECT
	*
FROM `sqlqueries-427408.ordersMarkets.orders`;

-- Add the time_of_day column
ALTER TABLE `sqlqueries-427408.ordersMarkets.orders` 
ADD COLUMN time_of_day STRING;

UPDATE `sqlqueries-427408.ordersMarkets.orders`
SET time_of_day = (
	CASE
		WHEN FORMAT_TIMESTAMP('%H:%M:%S', PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', `Order Date`)) BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN FORMAT_TIMESTAMP('%H:%M:%S', PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', `Order Date`)) BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END
);

-- Add day_name column
ALTER TABLE `sqlqueries-427408.ordersMarkets.orders` 
ADD COLUMN day_name STRING;

UPDATE `sqlqueries-427408.ordersMarkets.orders`
SET day_name = FORMAT_TIMESTAMP('%A', PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', `Order Date`));

-- Add month_name column
ALTER TABLE `sqlqueries-427408.ordersMarkets.orders` 
ADD COLUMN month_name STRING;

UPDATE `sqlqueries-427408.ordersMarkets.orders`
SET month_name = FORMAT_TIMESTAMP('%B', PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', `Order Date`));

-- --------------------------------------------------------------------
-- ---------------------------- Generic ------------------------------
-- --------------------------------------------------------------------
-- How many unique cities does the data have?
SELECT 
	DISTINCT City
FROM `sqlqueries-427408.ordersMarkets.orders`;

-- In which city is each branch?
SELECT 
	DISTINCT City,
    State
FROM `sqlqueries-427408.ordersMarkets.orders`;

-- --------------------------------------------------------------------
-- ---------------------------- Product -------------------------------
-- --------------------------------------------------------------------

-- How many unique product lines does the data have?
SELECT
	DISTINCT Category
FROM `sqlqueries-427408.ordersMarkets.orders`;

-- What is the most selling product line
SELECT
	SUM(Quantity) as qty,
    Category
FROM `sqlqueries-427408.ordersMarkets.orders`
GROUP BY Category
ORDER BY qty DESC;

-- What is the total revenue by month
SELECT
	month_name AS month,
	SUM(`List Price` * Quantity) AS total_revenue
FROM `sqlqueries-427408.ordersMarkets.orders`
GROUP BY month_name 
ORDER BY total_revenue;

-- What month had the largest COGS?
SELECT
	month_name AS month,
	SUM(`cost price` * Quantity) AS cogs
FROM `sqlqueries-427408.ordersMarkets.orders`
GROUP BY month_name 
ORDER BY cogs DESC;

-- What product line had the largest revenue?
SELECT
	Category,
	SUM(`List Price` * Quantity) as total_revenue
FROM `sqlqueries-427408.ordersMarkets.orders`
GROUP BY Category
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue?
SELECT
	State,
	City,
	SUM(`List Price` * Quantity) AS total_revenue
FROM `sqlqueries-427408.ordersMarkets.orders`
GROUP BY City, State 
ORDER BY total_revenue DESC;

-- What product line had the largest VAT?
SELECT
	Category,
	AVG(`Discount Percent`) as avg_discount
FROM `sqlqueries-427408.ordersMarkets.orders`
GROUP BY Category
ORDER BY avg_discount DESC;

-- Fetch each product line and add a column to those product 
-- line showing "Good", "Bad". Good if its greater than average sales

SELECT 
	AVG(Quantity) AS avg_qty
FROM `sqlqueries-427408.ordersMarkets.orders`;

SELECT
	Category,
	CASE
		WHEN AVG(Quantity) > 6 THEN 'Good'
        ELSE 'Bad'
    END AS remark
FROM `sqlqueries-427408.ordersMarkets.orders`
GROUP BY Category;

-- Which State sold more products than average product sold?
SELECT 
	State, 
    SUM(Quantity) AS qty
FROM `sqlqueries-427408.ordersMarkets.orders`
GROUP BY State
HAVING SUM(Quantity) > (SELECT AVG(Quantity) FROM `sqlqueries-427408.ordersMarkets.orders`);

-- What is the most common product line by gender
-- (Note: Assuming a gender column exists, adjust accordingly)
SELECT
	Segment AS gender,
    Category,
    COUNT(Segment) AS total_cnt
FROM `sqlqueries-427408.ordersMarkets.orders`
GROUP BY gender, Category
ORDER BY total_cnt DESC;

-- What is the average rating of each product line
-- (Note: Assuming a rating column exists, adjust accordingly)
SELECT
	ROUND(AVG(`List Price`), 2) as avg_rating,
    Category
FROM `sqlqueries-427408.ordersMarkets.orders`
GROUP BY Category
ORDER BY avg_rating DESC;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

-- --------------------------------------------------------------------
-- -------------------------- Customers -------------------------------
-- --------------------------------------------------------------------

-- How many unique customer types does the data have?
SELECT
	DISTINCT Segment
FROM `sqlqueries-427408.ordersMarkets.orders`;

-- How many unique payment methods does the data have?
-- (Note: Assuming a payment column exists, adjust accordingly)
SELECT
	DISTINCT `Ship Mode` AS payment
FROM `sqlqueries-427408.ordersMarkets.orders`;

-- What is the most common customer type?
SELECT
	Segment AS customer_type,
	count(*) as count
FROM `sqlqueries-427408.ordersMarkets.orders`
GROUP BY customer_type
ORDER BY count DESC;

-- Which customer type buys the most?
SELECT
	Segment AS customer_type,
    COUNT(*)
FROM `sqlqueries-427408.ordersMarkets.orders`
GROUP BY customer_type;

-- What is the gender of most of the customers?
-- (Note: Assuming a gender column exists, adjust accordingly)
SELECT
	Segment AS gender,
	COUNT(*) as gender_cnt
FROM `sqlqueries-427408.ordersMarkets.orders`
GROUP BY gender
ORDER BY gender_cnt DESC;

-- What is the gender distribution per State?
-- (Note: Assuming a gender column exists, adjust accordingly)
SELECT
	Segment AS gender,
	COUNT(*) as gender_cnt
FROM `sqlqueries-427408.ordersMarkets.orders`
WHERE State = 'C'
GROUP BY gender
ORDER BY gender_cnt DESC;

-- Which time of the day do customers give most ratings?
-- (Note: Assuming a rating column exists, adjust accordingly)
SELECT
	time_of_day,
	AVG(`List Price`) AS avg_rating
FROM `sqlqueries-427408.ordersMarkets.orders`
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which time of the day do customers give most ratings per State?
-- (Note: Assuming a rating column exists, adjust accordingly)
SELECT
	time_of_day,
	AVG(`List Price`) AS avg_rating
FROM `sqlqueries-427408.ordersMarkets.orders`
WHERE State = 'A'
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which day of the week has the best avg ratings?
-- (Note: Assuming a rating column exists, adjust accordingly)
SELECT
	day_name,
	AVG(`List Price`) AS avg_rating
FROM `sqlqueries-427408.ordersMarkets.orders`
GROUP BY day_name 
ORDER BY avg_rating DESC;

-- Which day of the week has the best average ratings per State?
-- (Note: Assuming a rating column exists, adjust accordingly)
SELECT 
	day_name,
	COUNT(day_name) total_sales
FROM `sqlqueries-427408.ordersMarkets.orders`
WHERE State = 'C'
GROUP BY day_name
ORDER BY total_sales DESC;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

-- --------------------------------------------------------------------
-- ---------------------------- Sales ---------------------------------
-- --------------------------------------------------------------------

-- Number of sales made in each time of the day per weekday 
SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM `sqlqueries-427408.ordersMarkets.orders`
WHERE day_name = 'Sunday'
GROUP BY time_of_day 
ORDER BY total_sales DESC;

-- Which of the customer types brings the most revenue?
SELECT
	Segment AS customer_type,
	SUM(`List Price` * Quantity) AS total_revenue
FROM `sqlqueries-427408.ordersMarkets.orders`
GROUP BY customer_type
ORDER BY total_revenue DESC;

-- Which city has the largest tax/VAT percent?
SELECT
	City,
    ROUND(AVG(`Discount Percent`), 2) AS avg_tax_pct
FROM `sqlqueries-427408.ordersMarkets.orders`
GROUP BY City 
ORDER BY avg_tax_pct DESC;

-- Which customer type pays the most in VAT?
SELECT
	Segment AS customer_type,
	AVG(`Discount Percent`) AS total_tax
FROM `sqlqueries-427408.ordersMarkets.orders`
GROUP BY customer_type
ORDER BY total_tax DESC;