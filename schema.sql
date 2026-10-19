-- ============================================================
-- Retail Sales Analysis | Schema (SQL Server)
-- Step 1: run this file, then data.sql, then analysis.sql
-- ============================================================

IF DB_ID('RetailSalesDB') IS NULL
    CREATE DATABASE RetailSalesDB;
GO

USE RetailSalesDB;
GO

-- Drop tables if they already exist (orders first, because it references the others)
IF OBJECT_ID('orders', 'U')    IS NOT NULL DROP TABLE orders;
IF OBJECT_ID('customers', 'U') IS NOT NULL DROP TABLE customers;
IF OBJECT_ID('products', 'U')  IS NOT NULL DROP TABLE products;
GO

CREATE TABLE customers (
    customer_id    INT            PRIMARY KEY,
    customer_name  NVARCHAR(100)  NOT NULL,
    city           NVARCHAR(50)   NOT NULL,
    signup_date    DATE           NOT NULL
);

CREATE TABLE products (
    product_id     INT            PRIMARY KEY,
    product_name   NVARCHAR(100)  NOT NULL,
    category       NVARCHAR(50)   NOT NULL,
    price          DECIMAL(10,2)  NOT NULL      -- price in EGP
);

CREATE TABLE orders (
    order_id       INT            PRIMARY KEY,
    customer_id    INT            NOT NULL  REFERENCES customers(customer_id),
    product_id     INT            NOT NULL  REFERENCES products(product_id),
    quantity       INT            NOT NULL  CHECK (quantity > 0),
    order_date     DATE           NOT NULL
);
GO
