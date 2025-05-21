CREATE DATABASE Customer_Segmentation;

USE Customer_Segmentation;

/*
Customer Segmentation is the process of dividing customers into groups
based on their behavior, preferences
*/

CREATE TABLE Customer_Segmentation (
    Row_ID INT, Order_ID VARCHAR(20), Order_Date DATE,
    Ship_Date DATE, Ship_Mode VARCHAR(50), Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100), Segment VARCHAR(50), City VARCHAR(100),
    State VARCHAR(100), Country VARCHAR(100),
    Market VARCHAR(50),
    Region VARCHAR(50), Product_ID VARCHAR(20),
    Category VARCHAR(50), Sub_Category VARCHAR(50),
    Product_Name VARCHAR(150), Sales FLOAT,
    Quantity INT, Discount FLOAT,
    Profit FLOAT, Shipping_Cost FLOAT, Order_Priority VARCHAR(50)
);


SELECT * FROM Customer_Segmentation;


ALTER TABLE Customer_Segmentation
DROP COLUMN Postal_Code; 

SELECT Profit FROM Customer_Segmentation
WHERE Profit IS NULL;


DELETE FROM Customer_Segmentation
WHERE profit IS NULL;

SELECT * FROM Customer_Segmentation;

 

-- 1) How many unique customers are in the dataset?

SELECT COUNT(DISTINCT Customer_ID) AS Unique_Customers
FROM Customer_Segmentation;

-----------------------------------------------------------------

-- 2) What are the total sales and total profit across all orders?

SELECT CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
CAST(SUM(profit) AS DECIMAL(10,2)) AS Total_Profit
FROM Customer_Segmentation;

------------------------------------------------------------------

-- 3) How many orders are placed under each customer segment?

SELECT segment, COUNT(1) AS Order_Count
FROM Customer_Segmentation
GROUP BY Segment
ORDER BY Order_Count DESC;


SELECT segment, SUM(Sales) AS Total_Sales
FROM Customer_Segmentation
GROUP BY Segment
ORDER BY Total_Sales DESC;
--------------------------------------------------------------------------

-- 4) Which are the top 5 cities with the most customers?

SELECT TOP 5 city, COUNT(DISTINCT Customer_ID) AS Customer_Count                
FROM Customer_Segmentation
GROUP BY City
ORDER BY Customer_Count DESC;

------------------------------------------------------------------------------------
  
-- 5) What is the total quantity sold per segment?

SELECT segment, SUM(Quantity) AS Total_Quantity_Sold 
FROM Customer_Segmentation
GROUP BY Segment;


----------------------------------------------------------------------------------

--- 6) How many orders were shipped under each shipping mode?

SELECT Ship_Mode, Count(1) AS Orders_Count
FROM Customer_Segmentation
GROUP BY Ship_Mode
ORDER BY Orders_Count DESC;

 

SELECT Ship_Mode, SUM(shipping_Cost) AS total_cost 
FROM Customer_Segmentation
GROUP BY Ship_Mode
ORDER BY total_cost DESC;



---------------------------------------------------------------------------------

-- 7) What is the average discount given to customers in each segment?

SELECT Segment, CAST(AVG(Discount) AS DECIMAL(10,2)) AS avg_discount
FROM Customer_Segmentation
GROUP BY Segment;

-----------------------------------------------------------------------------------

-- 8) What are the most frequently purchased sub-categories?
SELECT TOP 5 sub_category, COUNT(1) AS Purchase_Count
FROM Customer_Segmentation
GROUP BY Sub_Category
ORDER BY Purchase_Count DESC;

-----------------------------------------------------------------------------------
SELECT * FROM Customer_Segmentation;

-- 9) What is the monthly sales trend?

WITH MonthlySales AS (
SELECT DATEPART(YEAR, Order_Date) AS SalesYear,
DATEPART(MONTH, Order_Date) AS SalesMonth,
CAST(SUM(sales) AS DECIMAL(10,2)) AS MonthlyTotalSales
FROM Customer_Segmentation
GROUP BY DATEPART(YEAR, Order_Date), DATEPART(MONTH, Order_Date)  ),

MonthlyTrends AS (
SELECT SalesYear, SalesMonth, MonthlyTotalSales AS CurrentMonthSales,
LAG(MonthlyTotalSales) OVER(PARTITION BY SalesYear ORDER BY SalesMonth) AS PreviousMonthSales
FROM MonthlySales )

SELECT SalesYear, SalesMonth, CurrentMonthSales, PreviousMonthSales, 
(CurrentMonthSales - PreviousMonthSales) AS SalesDifference,
CASE WHEN PreviousMonthSales IS NULL THEN 0 
ELSE 
CAST((CurrentMonthSales - PreviousMonthSales)*100/PreviousMonthSales AS DECIMAL(10,2)) 
                           END AS PercentageChange 
FROM MonthlyTrends
ORDER BY SalesYear, SalesMonth;

-------------------------------------------------------------------------

-- 10) Which product categories are the most profitable?

SELECT * FROM Customer_Segmentation;

SELECT TOP 1 Category, CAST(SUM(Profit) AS DECIMAL(10,2))  AS Total_Profit 
FROM Customer_Segmentation 
GROUP BY Category
ORDER BY Total_Profit DESC;

----------------------------------------------------------------------------------

-- 11) What is the average shipping cost by ship mode?

SELECT Ship_Mode, CAST(AVG(Shipping_Cost) AS DECIMAL(10,2)) AS Avg_Shipping_Cost 
FROM Customer_Segmentation
GROUP BY Ship_Mode
ORDER BY Avg_Shipping_Cost DESC;

------------------------------------------------------------------------------------

-- 12) What is the total sales and profit for each combination of category and sub-category?

SELECT Category, Sub_Category, 
CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
CAST(SUM(profit) AS DECIMAL(10,2)) AS Total_Profit 
FROM Customer_Segmentation
GROUP BY Category, Sub_Category
ORDER BY Category;

-----------------------------------------------------------------------------------

-- 13) Which customers have placed the most orders?

SELECT TOP 5 Customer_ID, Count(Order_ID) AS Order_Count 
FROM Customer_Segmentation
GROUP BY Customer_ID 
ORDER BY Order_Count DESC;
--------------------------------------------------------------------------
/*
14) 
Calculate the number of days taken to ship each order using DATEDIFF() 
between Order_Date and Ship_Date. Identify orders that took more than 7 days. 
Return order ID, customer name, shipping days, and a status ("Delayed" or "On Time").
*/

SELECT * FROM Customer_Segmentation;

WITH cte AS (
SELECT Order_ID, Customer_Name, Order_Date, Ship_Date, 
DATEDIFF(DAY, Order_Date, Ship_Date) AS Shipping_Days
FROM Customer_Segmentation)

SELECT Order_ID, Customer_Name,Shipping_Days,
CASE WHEN Shipping_Days>=7 THEN 'Delayed'
ELSE 'On_Time' END AS Delivery_Status
FROM cte;

------------------------------------------------------------------------------------------

/* 15) Customer Purchase Frequency Classification

Write a query to classify each customer based on the number of orders they’ve placed. 
segment them into:
 - "One-Time Buyer" (1 order),
 - "Occasional Buyer" (2–5 orders),
 - "Frequent Buyer" (6–10 orders),
 - "Loyal Customer" (more than 10 orders).
*/

SELECT * FROM Customer_Segmentation
WHERE Customer_ID = 'AB-10015'

WITH cte AS (
SELECT Customer_ID, Count(Order_ID) AS Order_Count 
FROM Customer_Segmentation
GROUP BY Customer_ID  )

SELECT Customer_ID, Order_Count,
CASE WHEN Order_Count = 1 THEN 'One-Time Buyer'
WHEN Order_Count BETWEEN 2 AND 5 THEN 'Occasional Buyer'
WHEN Order_Count BETWEEN 6 AND 10 THEN 'Frequent Buyer'
ELSE 'Loyal Customer' END AS classification
FROM cte;

----------------------------------------------------------------------------

/*
16 Top 3 Most Profitable Products per Category

For each product category, rank products by total profit using RANK() or DENSE_RANK().
Return only the top 3 products from each category along with their profit and rank.
*/

SELECT * FROM Customer_Segmentation;

WITH cte AS (
SELECT Category, Sub_Category, Product_Name, SUM(profit) AS Total_Profit 
FROM Customer_Segmentation
GROUP BY Category, Sub_Category, Product_Name),

cte_2 AS (
SELECT Category, Sub_Category,  Product_Name, Total_Profit,
DENSE_RANK() OVER(PARTITION BY Category, Sub_Category ORDER BY Total_Profit DESC) AS rnk 
FROM cte)

SELECT Category, Sub_Category,  Product_Name, Total_Profit, rnk
FROM cte_2 
WHERE rnk<=3
ORDER BY Category, 
Sub_Category, rnk;

---------------------------------------------------------------------------------

/* 17.
Customer Sales Ranking by Region

Within each region Top 10 Customers, rank customers based on their total sales
using RANK . Return region, customer ID, total sales, and their rank.
*/

SELECT * FROM Customer_Segmentation;

WITH cte AS (
SELECT Customer_ID, Region, SUM(sales) AS Total_Sales 
FROM Customer_Segmentation
GROUP BY Customer_ID, Region),

cte_2 AS (
SELECT Customer_ID, Region, Total_Sales,
DENSE_RANK() OVER(PARTITION BY Region ORDER BY Total_Sales DESC) AS rnk 
FROM cte)

SELECT Customer_ID, Region, Total_Sales
FROM cte_2 
WHERE rnk<=10;

-----------------------------------------------------------------------------------

/* 18.
Customer Churn Detection
Identify customers who have not placed an order in the last 6 months 
from the most recent order date in the dataset. Return customer ID, 
last order date, and churn status ("Active", "Churned").
*/

SELECT * FROM Customer_Segmentation;

WITH Customer_Last_Order AS (
SELECT Customer_ID,MAX(Order_Date) AS Latest_Order 
FROM Customer_Segmentation
GROUP BY Customer_ID ),

Churn_Check AS (
SELECT Customer_ID,  Latest_Order, 
DATEDIFF(MONTH, Latest_Order, '2014-12-31') AS Month_Diff
FROM Customer_Last_Order)

 
SELECT Customer_ID,  Latest_Order,
CASE WHEN Month_Diff<=6 THEN 'Active'
ELSE 'Churned' END AS Churn_Status
FROM Churn_Check;



/*
SELECT Churn_Status, COUNT(1) AS cnt 
FROM cte_3 
GROUP BY Churn_Status
*/
----------------------------------------------------------------------------------------------

/* 19.
Monthly Profit Contribution by Customer Segment
Calculate the percentage contribution of each customer segment 
(e.g., Consumer, Corporate, Home Office) to the total monthly profit. 
*/

SELECT * FROM Customer_Segmentation;

WITH Monthly_Segment_Profit AS (
SELECT FORMAT(Order_Date, 'yyyy-MM') AS OrderMonth, Segment, 
SUM(Profit) AS Total_Profit
FROM Customer_Segmentation
GROUP BY FORMAT(Order_Date, 'yyyy-MM'),
Segment),

Monthly_Total_Profit AS (
SELECT OrderMonth, Segment, Total_Profit, SUM(Total_Profit)
OVER(PARTITION BY OrderMonth) AS Total_Monthly_Profit
FROM Monthly_Segment_Profit)

SELECT OrderMonth, Segment, Total_Profit, Total_Monthly_Profit,
CAST((Total_Profit*100/Total_Monthly_Profit) AS DECIMAL(10,2)) AS Percentage_Contribution
FROM Monthly_Total_Profit
ORDER BY OrderMonth, Segment;

---------------------------------------------------------------------------------------

-- 20) What is the monthly profit trend?

SELECT * FROM Customer_Segmentation;

With cte AS (
SELECT DATEPART(YEAR, Order_Date) AS Sales_Year,
DATEPART(MONTH, Order_Date) AS Sales_Month,
SUM(Profit) AS Monthly_Total_Profit
FROM Customer_Segmentation
GROUP BY DATEPART(YEAR, Order_Date), DATEPART(MONTH, Order_Date) ),

cte_2 AS (
SELECT Sales_Year, Sales_Month, Monthly_Total_Profit AS Current_Month_Profit,
LAG(Monthly_Total_Profit) OVER(PARTITION BY Sales_Year ORDER BY Sales_Month) 
                                         AS Previous_Month_Profit
FROM cte)

SELECT Sales_Year, Sales_Month, Current_Month_Profit,Previous_Month_Profit,
(Current_Month_Profit - Previous_Month_Profit) AS Profit_Diff,
CASE WHEN Previous_Month_Profit IS NULL THEN 0 
ELSE (Current_Month_Profit - Previous_Month_Profit)*100/Previous_Month_Profit END AS PercentageChange 
FROM cte_2;

---------------------------------------------------------------------------------------

-- 23) Determine the year-wise total sales and identify which year
-- had the highest overall sales.

SELECT DATEPART(YEAR, Order_Date) AS Sales_Year,
SUM(sales) AS Total_Sales
FROM Customer_Segmentation
GROUP BY DATEPART(YEAR, Order_Date)
ORDER BY Sales_Year DESC;

------------------------------------------------------------------------------

-- 24) What are the total sales for each quarter in every year?
SELECT DATEPART(YEAR, Order_Date) AS Sales_Year, DATEPART(QUARTER, Order_Date) AS Sales_Quarter,
CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales 
FROM Customer_Segmentation 
GROUP BY DATEPART(YEAR, Order_Date), DATEPART(QUARTER, Order_Date)
ORDER BY Sales_Year, Sales_Quarter;

---------------------------------------------------------------------------

---              *** Simple Insights *** 

/*
1) Top Segment by Sales
 - The Consumer segment generated the highest total sales compared to Corporate and Home Office.

2) Most Profitable Category
 - The Technology category contributed the most to overall profit.

3) Top Customers by Orders
 - A few key customers (e.g., those with frequent purchases) placed significantly more 
   orders than the rest.

4) Monthly Sales Trend
  - Sales peaked during Q4 (October to December), indicating higher demand 
    during year-end seasons.

5) Shipping Mode Preference
  - Standard Class is the most frequently used shipping mode among customers.

6) Churn Analysis
  - 1,416 customers are Active (placed an order within the last 6 months),
  - 174 customers are Churned (haven’t placed an order in the last 6 months).
  - This indicates that approximately 89% of customers are retained, while around 11% 
  are at risk of churn.
  - These churned customers can be targeted with re-engagement strategies or offers.

7) High Shipping Cost Impact
 - Higher shipping costs are mostly associated with First Class and Same Day shipping.

8) City-wise Profit
 - Some cities (e.g., New York, Los Angeles) consistently generate higher profits.

9) Product Performance
 - Certain sub-categories like Phones and Chairs show high sales but varying profit margins.

*/ 
----------------------------------------------------------------------------------------------------

