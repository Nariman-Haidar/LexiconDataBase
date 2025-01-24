-- Category Table
CREATE TABLE categories (
                            category_id INT PRIMARY KEY AUTO_INCREMENT,
                            category_name VARCHAR(100) NOT NULL UNIQUE,
                            category_description TEXT
);

-- Manufacturer Table
CREATE TABLE manufacturers (
                               manufacturer_id INT PRIMARY KEY AUTO_INCREMENT,
                               manufacturer_name VARCHAR(100) NOT NULL UNIQUE,
                               contact_email VARCHAR(100),
                               contact_phone VARCHAR(20)
);

-- Product Table
CREATE TABLE products (
                          product_id INT PRIMARY KEY AUTO_INCREMENT,
                          product_name VARCHAR(200) NOT NULL,
                          product_description TEXT,
                          price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
                          stock_balance INT NOT NULL CHECK (stock_balance >= 0),
                          category_id INT NOT NULL,
                          manufacturer_id INT NOT NULL,
                          FOREIGN KEY (category_id) REFERENCES categories(category_id),
                          FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(manufacturer_id)
);

-- Delivery Method Table
CREATE TABLE delivery_methods (
                                  delivery_method_id INT PRIMARY KEY AUTO_INCREMENT,
                                  method_name VARCHAR(100) NOT NULL UNIQUE,
                                  estimated_delivery_time VARCHAR(50)
);

-- Customer Table
CREATE TABLE customers (
                           customer_id INT PRIMARY KEY AUTO_INCREMENT,
                           first_name VARCHAR(100) NOT NULL,
                           last_name VARCHAR(100) NOT NULL,
                           email VARCHAR(100) NOT NULL UNIQUE,
                           phone_number VARCHAR(20),
                           address_street VARCHAR(200),
                           address_city VARCHAR(100),
                           address_postal_code VARCHAR(20),
                           address_country VARCHAR(100)
);

-- Order Table
CREATE TABLE orders (
                        order_id INT PRIMARY KEY AUTO_INCREMENT,
                        customer_id INT NOT NULL,
                        order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        order_status ENUM('New', 'Confirmed', 'Sent', 'Delivered') NOT NULL DEFAULT 'New',
                        delivery_method_id INT NOT NULL,
                        delivery_address_street VARCHAR(200),
                        delivery_address_city VARCHAR(100),
                        delivery_address_postal_code VARCHAR(20),
                        delivery_address_country VARCHAR(100),
                        total_price DECIMAL(10,2) NOT NULL,
                        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
                        FOREIGN KEY (delivery_method_id) REFERENCES delivery_methods(delivery_method_id)
);

-- Order Item Table
CREATE TABLE order_items (
                             order_item_id INT PRIMARY KEY AUTO_INCREMENT,
                             order_id INT NOT NULL,
                             product_id INT NOT NULL,
                             quantity INT NOT NULL CHECK (quantity > 0),
                             price_at_time_of_order DECIMAL(10,2) NOT NULL,
                             FOREIGN KEY (order_id) REFERENCES orders(order_id),
                             FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Review Table
CREATE TABLE reviews (
                         review_id INT PRIMARY KEY AUTO_INCREMENT,
                         customer_id INT NOT NULL,
                         product_id INT NOT NULL,
                         rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
                         review_comment TEXT,
                         review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                         FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
                         FOREIGN KEY (product_id) REFERENCES products(product_id)
);