-- Product category translation lookup table (Portuguese -> English)
CREATE TABLE product_category_name_translation (
    product_category_name VARCHAR(100) PRIMARY KEY,
    product_category_name_english VARCHAR(100) NOT NULL
);

-- Customer master data
CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50) NOT NULL,
    customer_zip_code_prefix INT NOT NULL,
    customer_city VARCHAR(100) NOT NULL,
    customer_state VARCHAR(10) NOT NULL
);

-- Geographic lookup table used for location-based analysis
CREATE TABLE geolocation (
    geolocation_zip_code_prefix INT PRIMARY KEY,
    geolocation_lat DECIMAL(10,8) NOT NULL,
    geolocation_lng DECIMAL(11,8) NOT NULL,
    geolocation_city VARCHAR(100) NOT NULL,
    geolocation_state VARCHAR(10) NOT NULL
);

-- Order line-item details containing product-level revenue information
CREATE TABLE order_items (
    order_id VARCHAR(50) NOT NULL,
    order_item_id INT NOT NULL,
    product_id VARCHAR(50) NOT NULL,
    seller_id VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    freight_value DECIMAL(10,2) NOT NULL,
    total_value DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, order_item_id)
);

-- Order header table containing order lifecycle information
CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50) NOT NULL,
    order_status VARCHAR(30) NOT NULL,
    order_purchase_timestamp TIMESTAMP NOT NULL,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    delivery_days DECIMAL(10,2),
    approval_time DECIMAL(10,2),
    delivery_delay DECIMAL(10,2),
    late_days DECIMAL(10,2) NOT NULL,
    early_days DECIMAL(10,2) NOT NULL,
    delivery_status VARCHAR(20) NOT NULL
);

-- Payment information for each order
CREATE TABLE order_payments (
    order_id VARCHAR(50) NOT NULL,
    payment_sequential INT NOT NULL,
    payment_type VARCHAR(30) NOT NULL,
    payment_installments INT NOT NULL,
    payment_value DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, payment_sequential)
);

-- Product master data
CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100) NOT NULL
);

-- Customer review and satisfaction data
CREATE TABLE order_reviews (
    review_id VARCHAR(50) NOT NULL,
    order_id VARCHAR(50) PRIMARY KEY,
    review_score INT NOT NULL,
    review_creation_date TIMESTAMP NOT NULL,
    review_answer_timestamp TIMESTAMP NOT NULL,
    response_time_hours DECIMAL(10,2) NOT NULL
);

-- Seller master data
CREATE TABLE sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix VARCHAR(10) NOT NULL,
    seller_city VARCHAR(100) NOT NULL,
    seller_state VARCHAR(10) NOT NULL
);

-- Clickstream user behavior data used for funnel analysis
CREATE TABLE clickstream (
    event_order INT NOT NULL,
    country VARCHAR(50) NOT NULL,
    session_id INT NOT NULL,
    page_1_main_category VARCHAR(30) NOT NULL,
    page_2_clothing_model VARCHAR(20) NOT NULL,
    colour VARCHAR(30) NOT NULL,
    location VARCHAR(30) NOT NULL,
    model_photography VARCHAR(20) NOT NULL,
    price INT NOT NULL,
    price_2 VARCHAR(10) NOT NULL,
    page INT NOT NULL,
    stage VARCHAR(10) NOT NULL,
    date DATE NOT NULL,
    month_year VARCHAR(7) NOT NULL,
    day_of_week VARCHAR(15) NOT NULL,
    is_sale_page INT NOT NULL
);

-- Mapping table connecting clickstream categories to Olist product categories
CREATE TABLE product_mapping (
    page_1_main_category VARCHAR(30) PRIMARY KEY,
    product_category_name VARCHAR(100) NOT NULL
);

-- Verify all tables created successfully
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;