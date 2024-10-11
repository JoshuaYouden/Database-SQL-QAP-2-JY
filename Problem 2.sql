CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name TEXT,
    price DECIMAL(10, 2),
    stock_quantity INT
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE
);

CREATE TABLE order_items (
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    PRIMARY KEY (order_id, product_id);
);

INSERT INTO products (product_name, price, stock_quantity) VALUES
('Watch', 399.99, 25),
('Phone', 299.99, 50),
('Smart TV', 599.99, 10),
('Headset', 59.99, 100),
('Headphones', 99.99, 50)

INSERT INTO customers (first_name, last_name, email) VALUES
('George', 'Omar', 'george.omar@example.com'),
('Katie', 'Ross', 'katie.ross@example.com'),
('Leah', 'Anderson', 'leah.anderson@example.com'),
('Matthew', 'Butt', 'matthew.butt@example.com')

INSERT INTO orders (customer_id, order_date) VALUES
((SELECT customer_id FROM customers WHERE first_name = 'George' AND last_name = 'Omar'), '2024-02-20'),
((SELECT customer_id FROM customers WHERE first_name = 'Katie' AND last_name = 'Ross'), '2024-11-26'),
((SELECT customer_id FROM customers WHERE first_name = 'Leah' AND last_name = 'Anderson'), '2024-12-15'),
((SELECT customer_id FROM customers WHERE first_name = 'Matthew' AND last_name = 'Butt'), '2024-06-12'),
((SELECT customer_id FROM customers WHERE first_name = 'George' AND last_name = 'Omar'), '2024-08-17')

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 1),
(3, 4, 1),
(3, 5, 1),
(4, 1, 1),
(4, 2, 1),
(5, 3, 1),
(5, 4, 1),
(5, 5, 1)