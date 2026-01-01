-- Drop tables if exists (for re-running)
DROP TABLE IF EXISTS order_items, payments, product_reviews, orders, products, 
                     suppliers, categories, customers, employees, departments, regions;

-- 1. regions
CREATE TABLE regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(50) NOT NULL
);

-- 2. departments
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    region_id INT,
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

-- 3. employees (self-referencing for hierarchy)
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE,
    salary DECIMAL(10,2),
    commission_pct DECIMAL(4,2), -- NULLable
    manager_id INT, -- self-reference
    department_id INT,
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- 4. customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    registration_date DATE,
    country VARCHAR(50),
    city VARCHAR(50),
    customer_segment VARCHAR(20) -- Gold, Silver, Bronze, New
);

-- 5. suppliers
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100),
    contact_person VARCHAR(80),
    email VARCHAR(100),
    phone VARCHAR(20),
    country VARCHAR(50)
);

-- 6. categories
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50),
    parent_category_id INT NULL -- for hierarchy (e.g. Electronics > Audio)
);

-- 7. products
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150),
    category_id INT,
    supplier_id INT,
    launch_date DATE,
    list_price DECIMAL(10,2),
    cost_price DECIMAL(10,2),
    units_in_stock INT,
    discontinued BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- 8. orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    employee_id INT NULL, -- sales rep who handled the order (NULL for online-only)
    order_date DATE,
    shipped_date DATE NULL,
    status VARCHAR(20), -- 'Completed', 'Cancelled', 'Shipped', 'Processing'
    total_amount DECIMAL(12,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- 9. order_items
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    discount DECIMAL(4,2) DEFAULT 0,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 10. payments
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    amount DECIMAL(12,2),
    payment_method VARCHAR(30), -- Credit Card, PayPal, Bank Transfer, Gift Card
    status VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 11. product_reviews
CREATE TABLE product_reviews (
    review_id INT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date DATE,
    helpful_votes INT DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);