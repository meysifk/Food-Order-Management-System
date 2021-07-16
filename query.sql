CREATE DATABASE food_oms_db;
USE food_oms_db;

CREATE TABLE customers (
	  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE items (
	  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    price INT NOT NULL
);

CREATE TABLE categories (
	  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    category VARCHAR(50) NOT NULL UNIQUE,
);

CREATE TABLE item_categories (
	  category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    item_id INT NOT NULL,
    FOREIGN KEY (item_id) REFERENCES items(id)
);

CREATE TABLE orders (
	  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    order_date DATETIME NOT NULL,
    total INT NOT NULL,
    customer_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE order_details (
	  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,	
    FOREIGN KEY (order_id) REFERENCES orders(id),
    item_id INT NOT NULL,
    FOREIGN KEY (item_id) REFERENCES items(id)
);


INSERT INTO customers (name, phone) VALUES
  ('Agus',    '+6212345678'),
  ('Pertiwi', '+6287654321'),
  ('Delta',   '+6289753124'),
  ('Prabowo', '+6212399678'),
  ('Jokowi',  '+6287654361')
;

INSERT INTO orders (order_date, total, customer_id) VALUES 
  (NOW(), 27000, 1), 
  (NOW(), 55000, 2),
  (NOW(), 53000, 3),
  (NOW(), 31000, 4),
  (NOW(), 40000, 5)
;

-- Agus IDR 27000
INSERT INTO order_details (order_id, item_id) VALUES
(1, 1),
(1, 2);

-- Pertiwi IDR 55000
INSERT INTO order_details (order_id, item_id) VALUES
(2, 3),
(2, 5);

-- Delta IDR 53000
INSERT INTO order_details (order_id, item_id) VALUES
(3, 7),
(3, 5),
(3, 2);

-- Prabowo IDR 31000
INSERT INTO order_details (order_id, item_id) VALUES
(4, 4),
(4, 6);

-- Jokowi IDR 40000
INSERT INTO order_details (order_id, item_id) VALUES
(5, 1),
(5, 5);


SELECT 
	O.id AS `Order ID`,
	DATE_FORMAT(O.order_date, "%W, %M %e %Y %T") AS `Order Date`,
	C.name AS `Customer Name`,
    C.phone AS `Customer Phone`,
    CONCAT('IDR ', O.total) AS `Total`,
    GROUP_CONCAT(I.name) AS `Items Bought`
  FROM
    customers C
  JOIN
    orders O
  ON
    C.id = O.customer_id
  JOIN
    order_details OD
  ON
    O.id = OD.order_id
  JOIN
    items I
  ON
    OD.item_id = I.id
  GROUP BY
    C.id;
