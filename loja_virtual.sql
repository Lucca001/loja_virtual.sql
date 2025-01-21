-- Criação do banco de dados
CREATE DATABASE LojaVirtual;
USE LojaVirtual;

-- Tabela de clientes
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de produtos
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL
);

-- Tabela de pedidos
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Tabela de itens do pedido
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Inserção de dados fictícios
INSERT INTO customers (name, email, phone) VALUES
('João Silva', 'joao.silva@example.com', '111-222-3333'),
('Maria Oliveira', 'maria.oliveira@example.com', '444-555-6666'),
('Carlos Souza', 'carlos.souza@example.com', '777-888-9999');

INSERT INTO products (name, price, stock) VALUES
('Notebook', 2500.00, 10),
('Smartphone', 1500.00, 20),
('Headphone', 200.00, 50);

INSERT INTO orders (customer_id, total_amount) VALUES
(1, 2700.00),
(2, 1500.00);

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 2500.00),
(1, 3, 1, 200.00),
(2, 2, 1, 1500.00);

-- Consultas de exemplo
-- 1. Total de pedidos por cliente
SELECT c.name AS cliente, COUNT(o.order_id) AS total_pedidos
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name;

-- 2. Produtos mais vendidos
SELECT p.name AS produto, SUM(oi.quantity) AS quantidade_vendida
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.name
ORDER BY quantidade_vendida DESC;

-- 3. Valor total de cada pedido
SELECT o.order_id, c.name AS cliente, o.total_amount AS valor_total
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;
