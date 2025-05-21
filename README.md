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
- Region, State, City, Postal Code

---

## 🎯 Project Objective

To perform **Customer Segmentation Analysis** and generate **actionable insights** that help understand:
- Sales and profit trends
- Customer behaviors
- Product performance
- Churn risk
- Segment-wise contributions

---

## 🧠 Key SQL Concepts Used

- `CTE` (Common Table Expressions)
- `CASE WHEN` statements
- `LAG()` and other window functions
- Aggregations (`SUM()`, `AVG()`, `COUNT()`)
- Filtering and grouping
- Ranking (`RANK()`, `DENSE_RANK()`)

---

## 🔍 Business Questions Solved

###  Beginner Level
1. What is the total sales by segment?
2. What is the average shipping cost by ship mode?
3. What is the total quantity sold per segment?
4. Which product categories are the most profitable?
5. Which customers placed the most orders?

###  Intermediate Level
6. What is the monthly sales trend?
7. What is the profit trend by category (MoM)?
8. What is the total sales and profit for each category and sub-category?
9. Identify customers who haven't placed an order in the last 6 months (Churn Detection).
10. Classify orders as "High Profit", "Low Profit", or "Loss" using `CASE WHEN`.

###  Advanced Level
11. Monthly Profit Contribution by Customer Segment using `SUM()` with `PARTITION BY`
12. Rank top-selling products within each category using `RANK() OVER()`
13. Calculate MoM change in profit per category using `LAG()`
14. Identify top 5 profitable cities in each region
15. Track customer lifetime value by aggregating total sales per customer

---

## 📈 Sample Insight

> "The **Consumer segment** accounts for the highest total sales and order quantity, but the **Corporate segment** shows higher average profit per order. This indicates potential to upsell more in the Corporate segment."

---

## 🛠 Tools Used

- **MS SQL Server**
- **SQL Server Management Studio (SSMS)**
- Excel (for initial data exploration)
- GitHub (for version control and publishing)

---

## 🚀 How to Use

1. Clone this repository:
   
2. Open the `.sql` files in **SSMS** or any SQL IDE.
3. Run the queries against your SQL Server after importing the dataset.

---

## 👤 Author

**Korrapati Jaswanth**  
Data Science Enthusiast | Top Machine Learning & Data Analysis Voice on LinkedIn  
📍 Bangalore, India  
📧 Reach out via LinkedIn: [https://www.linkedin.com/in/jaswanth49b057228/]

---

## ⭐️ Don't forget to star this repository if you found it helpful!

