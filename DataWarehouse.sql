DROP DATABASE IF EXISTS warehouse_db;
CREATE DATABASE warehouse_db;
USE warehouse_db;

--  DIMENSION TABLES 

CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,  -- YYYYMMDD format
    date DATE NOT NULL,
    year INT,
    quarter INT,
    month INT,
    day INT,
    weekday VARCHAR(10)
);

CREATE TABLE dim_customer (
    customer_key INT PRIMARY KEY AUTO_INCREMENT,
    customer_id VARCHAR(20) UNIQUE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    gender CHAR(1),
    birth_date DATE
);

CREATE TABLE dim_product (
    product_key INT PRIMARY KEY AUTO_INCREMENT,
    product_id VARCHAR(20) UNIQUE,
    product_name VARCHAR(100),
    category VARCHAR(50),
    brand VARCHAR(50),
    price DECIMAL(10, 2)
);

CREATE TABLE dim_store (
    store_key INT PRIMARY KEY AUTO_INCREMENT,
    store_id VARCHAR(20) UNIQUE,
    store_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE dim_salesperson (
    salesperson_key INT PRIMARY KEY AUTO_INCREMENT,
    salesperson_id VARCHAR(20) UNIQUE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    region VARCHAR(50)
);

CREATE TABLE dim_promotion (
    promotion_key INT PRIMARY KEY AUTO_INCREMENT,
    promotion_name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    discount_percent DECIMAL(5,2)
);

CREATE TABLE dim_supplier (
    supplier_key INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100),
    contact_name VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE dim_product_category (
    category_key INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50),
    description VARCHAR(255)
);

CREATE TABLE fact_sales (
    sales_key BIGINT PRIMARY KEY AUTO_INCREMENT,
    date_key INT,
    customer_key INT,
    product_key INT,
    store_key INT,
    salesperson_key INT,
    promotion_key INT,
    supplier_key INT,
    category_key INT,
    units_sold INT,
    revenue DECIMAL(15, 2),

    FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key),
    FOREIGN KEY (product_key) REFERENCES dim_product(product_key),
    FOREIGN KEY (store_key) REFERENCES dim_store(store_key),
    FOREIGN KEY (salesperson_key) REFERENCES dim_salesperson(salesperson_key),
    FOREIGN KEY (promotion_key) REFERENCES dim_promotion(promotion_key),
    FOREIGN KEY (supplier_key) REFERENCES dim_supplier(supplier_key),
    FOREIGN KEY (category_key) REFERENCES dim_product_category(category_key)
);

--  INSERT DATA 

-- dim_date 
INSERT INTO dim_date VALUES
(20250101, '2025-01-01', 2025, 1, 1, 1, 'Wednesday'),
(20250615, '2025-06-15', 2025, 2, 6, 15, 'Sunday'),
(20250910, '2025-09-10', 2025, 3, 9, 10, 'Wednesday'),
(20251225, '2025-12-25', 2025, 4, 12, 25, 'Thursday'),
(20250704, '2025-07-04', 2025, 3, 7, 4, 'Friday');

-- dim_customer 
INSERT INTO dim_customer (customer_id, first_name, last_name, email, city, state, country, gender, birth_date) VALUES
('IND001', 'Amit', 'Sharma', 'amit.sharma@gmail.com', 'Mumbai', 'Maharashtra', 'India', 'M', '1985-07-15'),
('CAN002', 'Emily', 'Johnson', 'emily.johnson@gmail.com', 'Toronto', 'Ontario', 'Canada', 'F', '1990-03-22'),
('IND003', 'Priya', 'Kumar', 'priya.kumar@gmail.com', 'Delhi', 'Delhi', 'India', 'F', '1992-11-08'),
('CAN004', 'Liam', 'Smith', 'liam.smith@gmail.com', 'Vancouver', 'British Columbia', 'Canada', 'M', '1988-01-30'),
('IND005', 'Raj', 'Patel', 'raj.patel@gmail.com', 'Ahmedabad', 'Gujarat', 'India', 'M', '1980-05-19');

-- dim_product
INSERT INTO dim_product (product_id, product_name, category, brand, price) VALUES
('P001', 'Smartphone X', 'Electronics', 'TechBrand', 799.99),
('P002', 'Running Shoes', 'Apparel', 'RunFast', 120.00),
('P003', 'Coffee Maker', 'Home Appliances', 'BrewMaster', 85.50),
('P004', 'LED TV 55 inch', 'Electronics', 'VisionPlus', 1200.00),
('P005', 'Winter Jacket', 'Apparel', 'WarmWear', 250.00);

-- dim_store
INSERT INTO dim_store (store_id, store_name, city, state, country) VALUES
('S001', 'Mumbai Mega Store', 'Mumbai', 'Maharashtra', 'India'),
('S002', 'Toronto Central', 'Toronto', 'Ontario', 'Canada'),
('S003', 'Delhi Outlet', 'Delhi', 'Delhi', 'India'),
('S004', 'Vancouver Mall', 'Vancouver', 'British Columbia', 'Canada'),
('S005', 'Ahmedabad Plaza', 'Ahmedabad', 'Gujarat', 'India');

-- dim_salesperson
INSERT INTO dim_salesperson (salesperson_id, first_name, last_name, region) VALUES
('SP001', 'Neha', 'Singh', 'West India'),
('SP002', 'Oliver', 'Brown', 'Ontario'),
('SP003', 'Suresh', 'Desai', 'North India'),
('SP004', 'Sophia', 'Wilson', 'British Columbia'),
('SP005', 'Karan', 'Gupta', 'West India');

-- dim_promotion
INSERT INTO dim_promotion (promotion_name, start_date, end_date, discount_percent) VALUES
('New Year Sale', '2025-01-01', '2025-01-15', 10.00),
('Summer Bonanza', '2025-06-01', '2025-06-30', 15.00),
('Back to School', '2025-09-01', '2025-09-15', 12.50),
('Winter Clearance', '2025-12-01', '2025-12-31', 20.00),
('Independence Day Offer', '2025-07-01', '2025-07-07', 18.00);

-- dim_supplier
INSERT INTO dim_supplier (supplier_name, contact_name, city, country) VALUES
('Global Tech Supplies', 'Ravi Kumar', 'Bangalore', 'India'),
('Northern Apparel Inc.', 'Michael Lee', 'Toronto', 'Canada'),
('Home Goods Ltd.', 'Sunita Patel', 'Ahmedabad', 'India'),
('Vision Electronics', 'Emily Clark', 'Vancouver', 'Canada'),
('Winter Wear Co.', 'Rajiv Sharma', 'Delhi', 'India');

-- dim_product_category
INSERT INTO dim_product_category (category_name, description) VALUES
('Electronics', 'Devices and gadgets like phones, TVs, etc.'),
('Apparel', 'Clothing and footwear'),
('Home Appliances', 'Appliances for home use'),
('Sports Equipment', 'Gear for sports and fitness'),
('Books', 'Printed and digital books');

--  fact_sales 

INSERT INTO fact_sales (date_key, customer_key, product_key, store_key, salesperson_key, promotion_key, supplier_key, category_key, units_sold, revenue) VALUES
(20250101, 1, 1, 1, 1, 1, 1, 1, 2, 1599.98),
(20250615, 2, 2, 2, 2, 2, 2, 2, 1, 120.00),
(20250910, 3, 3, 3, 3, 3, 3, 3, 3, 256.50),
(20251225, 4, 4, 4, 4, 4, 4, 1, 1, 1200.00),
(20250704, 5, 5, 5, 5, 5, 5, 2, 2, 500.00);


USE warehouse_db;

-- 1. Total revenue by product category and year
SELECT
    c.category_name,
    d.year,
    SUM(f.revenue) AS total_revenue
FROM fact_sales f
JOIN dim_product_category c ON f.category_key = c.category_key
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY c.category_name, d.year
ORDER BY d.year, total_revenue DESC;

-- 2. Average units sold and revenue per store in each country
SELECT
    s.country,
    s.store_name,
    AVG(f.units_sold) AS avg_units_sold,
    AVG(f.revenue) AS avg_revenue
FROM fact_sales f
JOIN dim_store s ON f.store_key = s.store_key
GROUP BY s.country, s.store_name
ORDER BY s.country, avg_revenue DESC;

-- 3. Top 5 customers by total revenue with their location and gender
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    c.country,
    c.gender,
    SUM(f.revenue) AS total_revenue
FROM fact_sales f
JOIN dim_customer c ON f.customer_key = c.customer_key
GROUP BY c.customer_id, c.first_name, c.last_name, c.city, c.country, c.gender
ORDER BY total_revenue DESC
LIMIT 5;

-- 4. Revenue and units sold by salesperson and region for last year (2025)
SELECT
    sp.first_name,
    sp.last_name,
    sp.region,
    SUM(f.units_sold) AS total_units,
    SUM(f.revenue) AS total_revenue
FROM fact_sales f
JOIN dim_salesperson sp ON f.salesperson_key = sp.salesperson_key
JOIN dim_date d ON f.date_key = d.date_key
WHERE d.year = 2025
GROUP BY sp.first_name, sp.last_name, sp.region
ORDER BY total_revenue DESC;

-- 5. Monthly revenue trend for a specific product 
SELECT
    d.year,
    d.month,
    SUM(f.revenue) AS monthly_revenue
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
JOIN dim_date d ON f.date_key = d.date_key
WHERE p.product_name = 'Smartphone X'
GROUP BY d.year, d.month
ORDER BY d.year, d.month;

-- 6. Promotion effectiveness: total revenue and avg discount per promotion
SELECT
    pr.promotion_name,
    COUNT(f.sales_key) AS total_sales,
    SUM(f.revenue) AS total_revenue,
    AVG(pr.discount_percent) AS avg_discount_percent
FROM fact_sales f
JOIN dim_promotion pr ON f.promotion_key = pr.promotion_key
GROUP BY pr.promotion_name
ORDER BY total_revenue DESC;

-- 7. Supplier sales volume and revenue in different countries
SELECT
    sup.supplier_name,
    sup.country,
    SUM(f.units_sold) AS total_units_sold,
    SUM(f.revenue) AS total_revenue
FROM fact_sales f
JOIN dim_supplier sup ON f.supplier_key = sup.supplier_key
GROUP BY sup.supplier_name, sup.country
ORDER BY total_revenue DESC;

-- 8. Customer purchasing patterns by gender and product category
SELECT
    c.gender,
    pc.category_name,
    COUNT(f.sales_key) AS purchase_count,
    SUM(f.units_sold) AS total_units,
    SUM(f.revenue) AS total_revenue
FROM fact_sales f
JOIN dim_customer c ON f.customer_key = c.customer_key
JOIN dim_product_category pc ON f.category_key = pc.category_key
GROUP BY c.gender, pc.category_name
ORDER BY c.gender, total_revenue DESC;

-- 9. Stores with declining revenue month over month in 2025 
WITH monthly_revenue AS (
    SELECT
        s.store_key,
        s.store_name,
        d.year,
        d.month,
        SUM(f.revenue) AS revenue
    FROM fact_sales f
    JOIN dim_store s ON f.store_key = s.store_key
    JOIN dim_date d ON f.date_key = d.date_key
    WHERE d.year = 202
    GROUP BY s.store_key, s.store_name, d.year, d.month
),
ranked AS (
    SELECT
        store_key,
        store_name,
        month,
        revenue,
        LAG(revenue) OVER (PARTITION BY store_key ORDER BY month) AS prev_revenue
    FROM monthly_revenue
)
SELECT
    store_name,
    month,
    revenue,
    prev_revenue
FROM ranked
WHERE revenue < prev_revenue
ORDER BY store_name, month;
