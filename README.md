# Retail Sales Analysis (SQL Server)

Analysis of two years of sales data (2024–2025) for an Egyptian retail store, answering 10 business questions with SQL.

## Business Problem
Management wants to understand where revenue comes from: which products and categories sell best, who the most valuable customers are, and how sales behave over time.

## Dataset
Three related tables (sample data, 500 orders):

| Table | Rows | Columns |
|-------|------|---------|
| `customers` | 60 | customer_id, customer_name, city, signup_date |
| `products` | 20 | product_id, product_name, category, price (EGP) |
| `orders` | 500 | order_id, customer_id, product_id, quantity, order_date |

`orders` links to `customers` and `products` through foreign keys.

## Tools & SQL Skills
- **Microsoft SQL Server** (SSMS)
- `SELECT`, `WHERE`, `JOIN` (INNER / LEFT), `GROUP BY`, `ORDER BY`, `TOP`
- Aggregations: `SUM`, `COUNT`, `AVG`
- `CASE` statements for segmentation
- Date functions: `YEAR`, `MONTH`, `DATENAME`
- Subqueries

## Business Questions
1. What is the total revenue?
2. How many orders were placed each month?
3. What are the top 5 best-selling products by quantity?
4. Which category brings in the most revenue?
5. Which city has the most customers?
6. Who are the top 10 customers by total spending?
7. What is the average order value?
8. Which products have never been ordered?
9. How do sales compare between weekdays and weekends?
10. How many customers fall into each spending segment?

## Key Findings
- **Total revenue:** 2,325,850 EGP from 500 orders; **average order value** is about 4,652 EGP.
- **Electronics** is the top category with 1.10M EGP, **47%** of all revenue.
- The **T-Shirt** is the best seller by units (123), but low-priced items bring little revenue; volume and value come from different products.
- **Cairo** has the most customers (26 of 60), followed by Giza (14).
- **Notebook Pack** was never ordered and is a candidate for removal or promotion.
- **Weekdays** account for 71% of revenue; weekends (Fri–Sat) account for 29%.
- Customers split evenly into segments: **19 High**, **22 Medium**, **19 Low** spenders.
- Orders grew from 232 in 2024 to 268 in 2025 (**+15.5%**), with December 2024 as the busiest month.

## How to Run
1. Open SQL Server Management Studio (SSMS).
2. Run `schema.sql` to create the database and tables.
3. Run `data.sql` to insert the sample data.
4. Run `analysis.sql` to answer the 10 questions.

## Repository Structure
```
retail-sales-sql-analysis/
├── README.md
├── schema.sql      → creates database and tables
├── data.sql        → inserts the sample data
├── analysis.sql    → 10 business queries with comments
└── data/           → the same data as CSV files
    ├── customers.csv
    ├── products.csv
    └── orders.csv
```

## Author
**Ahmed** · Data Analyst
