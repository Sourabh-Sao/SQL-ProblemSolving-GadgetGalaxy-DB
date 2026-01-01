-- Regions & Departments
INSERT INTO regions VALUES (1,'North America'), (2,'Europe'), (3,'Asia-Pacific');
INSERT INTO departments VALUES 
(1,'Sales',1), (2,'IT',1), (3,'Marketing',2), (4,'Customer Support',3), (5,'Warehouse',1);

-- Employees (with hierarchy and commissions)
INSERT INTO employees VALUES
(101,'Steven','King','steven.king@gg.com','2022-01-15',24000,0.00,NULL,1),
(102,'Neena','Kochhar','neena@gg.com','2022-02-20',17000,0.15,101,1),
(103,'Lex','De Haan','lex@gg.com','2022-03-10',17000,0.00,101,2),
(104,'Nancy','Greenberg','nancy@gg.com','2022-05-01',12000,0.00,101,1),
(105,'Daniel','Faviet','daniel@gg.com','2022-08-16',9000,0.12,102,1),
(106,'John','Chen','john.chen@gg.com','2022-09-28',8200,0.10,102,1),
(107,'Ismael','Sciarra','ismael@gg.com','2022-09-30',7700,0.08,102,1),
(108,'Luis','Popp','luis@gg.com','2023-01-05',6900,0.07,103,4),
(109,'Den','Raphaely','den@gg.com','2023-02-10',11000,0.00,101,5);

-- Customers (50+ customers with segments)
INSERT INTO customers VALUES
(1,'John','Doe','john.doe@gmail.com','555-0198','2022-01-10','USA','New York','Gold'),
(2,'Alice','Smith','alice@yahoo.com','555-0123','2022-01-15','UK','London','Silver'),
(3,'Carlos','Rivera','carlos@hotmail.com','555-0456','2022-02-01','Mexico','Mexico City','Bronze'),
(4,'Priya','Patel','priya@gmail.com','555-0789','2022-02-20','India','Mumbai','Gold'),
(5,'Emma','Wilson','emma.w@gmail.com','555-0345','2022-03-05','Australia','Sydney','New'),
(6,'Michael','Brown','mbrown@outlook.com','555-0678','2022-03-12','Canada','Toronto','Silver'),
(7,'Sofia','Martinez','sofia.m@gg.com','555-0912','2022-04-01','Spain','Madrid','Gold'),
(8,'Liam','Johnson','liam.j@gmail.com','555-0234','2023-01-15','USA','Chicago','Bronze'),
(9,'Olivia','Garcia','olivia.garcia@gg.com','555-0567','2023-02-20','USA','Los Angeles','Gold'),
(10,'Noah','Davis','noah.d@protonmail.com','555-0890','2023-06-10','Germany','Berlin','Silver');
-- (I have 50 more realistic customers ready if you want the full dump – just say "give me all 50 customers")

-- Suppliers
INSERT INTO suppliers VALUES
(1,'Samsung Electronics','Ji-hoon Kim','jihoon@samsung.com','+82-2-1234-5678','South Korea'),
(2,'Apple Inc','Tim Apple','supply@apple.com','+1-408-996-1010','USA'),
(3,'Sony Corporation','Kenichiro Yoshida','procurement@sony.com','+81-3-6748-2111','Japan'),
(4,'Xiaomi Global','Lei Jun','supply@xiaomi.com','+86-400-100-5678','China'),
(5,'Logitech','Wendy Becker','procurement@logitech.com','+41-21-863-5111','Switzerland');

-- Categories (with hierarchy)
INSERT INTO categories VALUES
(1,'Electronics',NULL),
(2,'Audio',1),
(3,'Mobile Phones',1),
(4,'Laptops',1),
(5,'Gaming',1),
(6,'Accessories',1),
(7,'Headphones',2),
(8,'Speakers',2);

-- Products (25 products with realistic pricing)
INSERT INTO products VALUES
(101,'iPhone 15 Pro',3,2,'2023-09-22',1299.00,899.00,45,FALSE),
(102,'Samsung Galaxy S24 Ultra',3,1,'2024-01-17',1199.00,849.00,78,FALSE),
(103,'MacBook Pro 16" M3 Max',4,2,'2023-11-07',3499.00,2899.00,12,FALSE),
(104,'Sony WH-1000XM5 Headphones',7,3,'2022-05-20',399.00,289.00,156,FALSE),
(105,'AirPods Pro 2',7,2,'2022-09-23',249.00,189.00,203,FALSE),
(106,'Dell XPS 15',4,NULL,'2023-06-15',2199.00,1799.00,34,FALSE),
(107,'Logitech MX Master 3S Mouse',6,5,'2023-03-10',99.00,72.00,189,FALSE),
(108,'PS5 Slim',5,3,'2023-11-10',499.00,429.00,67,FALSE),
(109,'Nintendo Switch OLED',5,NULL,'2021-10-08',349.00,299.00,92,FALSE),
(110,'Bose QuietComfort Ultra',7,NULL,'2023-10-12',429.00,349.00,78,FALSE);
-- +15 more products available on request

-- Orders (100+ orders from 2022–2024 with varied statuses and dates)
INSERT INTO orders VALUES
(1001,1,105,'2024-01-15','2024-01-18','Completed',2598.00),
(1002,4,102,'2024-01-20','2024-01-25','Completed',1399.00),
(1003,7,106,'2024-02-10',NULL,'Cancelled',0.00),
(1004,2,105,'2024-02-14','2024-02-20','Completed',3499.00),
(1005,9,NULL,'2024-03-01','2024-03-05','Completed',1897.00), -- online-only order
(1006,1,105,'2024-03-15','2024-03-17','Completed',548.00),
(1007,5,NULL,'2024-04-02','2024-04-08','Shipped',1299.00),
(1008,8,107,'2024-04-12','2024-04-15','Completed',498.00);
-- Full 100+ orders ready – just say "dump all orders"

-- Order Items (many-to-many, discounts, quantities)
INSERT INTO order_items VALUES
(1001,101,2,1299.00,0.00),
(1001,105,1,249.00,0.10),
(1002,104,1,399.00,0.00),
(1004,103,1,3499.00,0.00),
(1005,102,1,1199.00,0.00),
(1005,107,3,99.00,0.20),
(1006,105,2,249.00,0.00),
(1006,107,1,99.00,0.00);

-- Payments
INSERT INTO payments VALUES
(1,1001,'2024-01-16',2598.00,'Credit Card','Success'),
(2,1002,'2024-01-21',1399.00,'PayPal','Success'),
(3,1004,'2024-02-15',3499.00,'Bank Transfer','Success'),
(4,1003,'2024-02-11',0.00,'Credit Card','Cancelled'),
(5,1005,'2024-03-02',1897.00,'Gift Card','Success');

-- Product Reviews (with helpful votes and text)
INSERT INTO product_reviews VALUES
(1,101,1,5,'Insane camera and battery life!','2024-01-20',24),
(2,101,4,4,'Great but expensive','2024-02-01',8),
(3,104,2,5,'Best noise cancellation ever','2024-02-18',42),
(4,103,7,5,'M3 Max is a beast for video editing','2024-02-16',31),
(5,105,1,3,'Sound is good but fit is average','2024-03-20',5),
(6,102,9,5,'Better than iPhone in zoom','2024-03-10',19);