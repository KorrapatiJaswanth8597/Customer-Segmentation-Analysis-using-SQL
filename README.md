# Customer-Segmentation-Analysis-using-SQL

This project focuses on analyzing customer behavior and business performance using **MS SQL Server**. By exploring and querying transactional data, we derive insights related to **customer segmentation, sales trends, profitability, churn detection**, and more.

---

## 📁 Dataset Overview

The dataset used is a retail transactional dataset containing the following columns:
- Order ID
- Order Date
- Customer ID
- Customer Name
- Segment (Consumer, Corporate, Home Office)
- Category & Sub-Category
- Sales, Quantity, Profit
- Shipping Cost
- Ship Mode
- Region, State, City

---

## Project Objective

To perform **Customer Segmentation Analysis** and generate **actionable insights** that help understand:
- Sales and profit trends
- Customer behaviors
- Product performance
- Churn risk
- Segment-wise contributions

---

##  Key SQL Concepts Used

- `CTE` (Common Table Expressions)
- `CASE WHEN` statements
- `LAG()` and other window functions
- Aggregations (`SUM()`, `AVG()`, `COUNT()`)
- Filtering and grouping
- Ranking (`RANK()`, `DENSE_RANK()`)

---

##  Business Questions Solved

1. How many unique customers are in the dataset?
2. What are the total sales and total profit across all orders?
3. How many orders are placed under each customer segment?
4. Which are the top 5 cities with the most customers?
5. What is the total quantity sold per segment?
6. How many orders were shipped under each shipping mode?
7. What is the average discount given to customers in each segment?
8. What are the most frequently purchased sub-categories?
9. What is the monthly sales trend?
10. Which product categories are the most profitable?
11. What is the average shipping cost by ship mode?
12. What is the total sales and profit for each combination of category and sub-category?
13. Which customers have placed the most orders?
14. Calculate the number of days taken to ship each order using DATEDIFF() 
between Order_Date and Ship_Date. Identify orders that took more than 7 days. 
Return order ID, customer name, shipping days, and a status ("Delayed" or "On Time").
15. Write a query to classify each customer based on the number of orders they’ve placed. 
segment them into:
 - "One-Time Buyer" (1 order),
 - "Occasional Buyer" (2–5 orders),
 - "Frequent Buyer" (6–10 orders),
 - "Loyal Customer" (more than 10 orders).
16. Top 3 Most Profitable Products per Category
17. Customer Sales Ranking by Region
18. Customer Churn Detection
19. Monthly Profit Contribution by Customer Segment
20. What is the monthly profit trend?
21. Determine the year-wise total sales and identify which year had the highest overall sales.
22. What are the total sales for each quarter in every year?

---

##  Simple Business Insights

-  Active Customers: **1416**
-  Churned Customers: **174**
-  Most Profitable Category: **Technology**
-  Segment with Highest Sales: **Consumer**
-  High Shipping Costs can negatively impact profits in some categories.
-  Peak sales observed in **Q4 across multiple years**.

---

##  Tools Used

- **MS SQL Server**
- Excel (for initial data exploration)
- GitHub (for publishing)

---

##  How to Use

1. Clone this repository:
   
2. Open the `.sql` files in **SSMS** or any SQL IDE.
3. Run the queries against your SQL Server after importing the dataset.

---

##  Author

**Korrapati Jaswanth**  
Data Science Enthusiast | 23K Followers @Linkedln | Top Machine Learning & Data Analysis Voice on LinkedIn  
Bangalore, India  
Reach out via LinkedIn: [https://www.linkedin.com/in/jaswanth49b057228/]

---

## Don't forget to star this repository if you found it helpful!

