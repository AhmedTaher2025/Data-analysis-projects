create database e_commerce;
CREATE TABLE Suppliers (
  Supplier_ID int primary key,
  Supplier_name varchar(150) not null ,
  City varchar(50) ,
  Country varchar(50),
  phone varchar(50)
);
CREATE TABLE Product (
  Product_ID int primary key,
  Product_name varchar(100) not null unique,
  Category varchar(50),
  Supplier_ID int, FOREIGN KEY (Supplier_ID)
    REFERENCES Suppliers (Supplier_ID) ,
  Stock_Quantity int,
  Unit_price decimal(10,4)
);

DROP DATABASE IF EXISTS NovaRetail;
CREATE DATABASE NovaRetail; 
USE NovaRetail;
Set SqL_SAFE_UPDATES= 0;
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO departments (dept_id, dept_name)
VALUES
(10, 'Sales'),
(20, 'Marketing'),
(30, 'IT'),
(40, 'HR'),
(50, 'Finance'),
(60, 'Research');

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    country VARCHAR(50),
    phone VARCHAR(30)
);
INSERT INTO suppliers
(supplier_id, supplier_name, city, country, phone)
VALUES
(1, 'TechWorld Supplies', 'Cairo', 'Egypt', '01010000001'),
(2, 'Global Electronics', 'Alexandria', 'Egypt', '01010000002'),
(3, 'Smart Office Ltd', 'Giza', 'Egypt', '01010000003'),
(4, 'Digital Market', 'Cairo', 'Egypt', '01010000004'),
(5, 'Future Devices', 'Cairo', 'Egypt', '01010000005'),
(6, 'Prime Systems', 'Mansoura', 'Egypt', '01010000006'),
(7, 'Modern Solutions', 'Tanta', 'Egypt', '01010000007'),
(8, 'Alpha Trading', 'Cairo', 'Egypt', '01010000008'),
(9, 'Beta Technologies', 'Giza', 'Egypt', '01010000009'),
(10, 'Omega Supplies', 'Alexandria', 'Egypt', '01010000010');

CREATE TABLE Product (
  Product_ID int primary key,
  Product_name varchar(100) not null unique,
  Category varchar(50),
  Supplier_ID int, FOREIGN KEY (Supplier_ID)
    REFERENCES Suppliers (Supplier_ID) ,
  Stock_Quantity int,
  Unit_price decimal(10,4)
);
INSERT INTO Product 
( Product_ID,Product_name,Category,Supplier_ID,Unit_price,Stock_Quantity) 
VALUES 
(101, 'Laptop Pro', 'Computers', 1, 25000, 50),
(102, 'Laptop Basic', 'Computers', 2, 15000, 80),
(103, 'Desktop Pro', 'Computers', 1, 18000, 40),
(104, 'Monitor 24', 'Accessories', 3, 5000, 100),
(105, 'Monitor 27', 'Accessories', 3, 7500, 70),
(106, 'Keyboard', 'Accessories', 4, 800, 200),
(107, 'Mouse', 'Accessories', 4, 500, 250),
(108, 'Printer', 'Office', 5, 6000, 60),
(109, 'Scanner', 'Office', 5, 4500, 40),
(110, 'Projector', 'Office', 6, 12000, 30),
(111, 'Tablet', 'Mobile', 7, 9000, 90),
(112, 'Smart Phone', 'Mobile', 8, 14000, 100),
(113, 'Headset', 'Accessories', 9, 1200, 150),
(114, 'Webcam', 'Accessories', 9, 1800, 120),
(115, 'Router', 'Networking', 10, 2500, 80),
(116, 'Switch', 'Networking', 10, 3500, 60),
(117, 'Hard Disk', 'Storage', 2, 3000, 100),
(118, 'SSD', 'Storage', 2, 4500, 90),
(119, 'USB Drive', 'Storage', 4, 600, 300),
(120, 'UPS', 'Power', 6, 5500, 50);


SELECT * FROM product;

 
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(50),
    dept_id int ,FOREIGN KEY (dept_id)
    REFERENCES departments (dept_id),
    job_title VARCHAR(30),
    salary decimal(10,5),
    hire_date varchar (50),
    manager_id int,
    email  VARCHAR(100)
);
UPDATE employees SET salary =null WHERE emp_id IN (4,14,24);
 alter table employees modify salary decimal(10,5);
INSERT INTO  employees (emp_id, first_name, last_name, dept_id, job_title,
 salary, hire_date, manager_id, email) values (1,'Ahmed','Hassan',10,'Sales_Manager',14000,'2020-01-10',NULL,'ahmed.hassan@novaretail.com'),
(2,'Mohamed','Ali',10,'Sales_Rep',7500,'2021-02-15',1,'mohamed.ali@novaretail.com'),
(3,'Omar','Khaled',10,'Sales_Rep',7200,'2021-03-20',1,'omar.khaled@novaretail.com'),
(4,'Youssef','Mahmoud',10,'Sales_Rep',6800,'2022-04-11',1,'youssef.mahmoud@novaretail.com'),
(5,'James','Santos',10,'Sales_Manager',21702.99,'2019-05-15',NULL,'james.santos@novaretail.com'),
(6,'Sara','Ibrahim',20,'Marketing_Manager',15000,'2019-06-10',NULL,'sara.ibrahim@novaretail.com'),
(7,'Mona','Samir',20,'Marketing_Specialist',8000,'2021-07-01',6,'mona.samir@novaretail.com'),
(8,'Nour','Tarek',20,'Marketing_Specialist',8200,'2022-08-11',6,'nour.tarek@novaretail.com'),
(9,'Hana','Adel',20,'Marketing_Analyst',9000,'2022-09-15',6,'hana.adel@novaretail.com'),
(10,'Laila','Mostafa',20,'Marketing_Analyst',9500,'2023-01-10',6,'laila.mostafa@novaretail.com'),
(11,'Stacey','Miller',30,'IT_Manager',22788.14,'2018-02-12',NULL,'stacey.miller@novaretail.com'),
(12,'Gregory','Estes',30,'IT_Prog',16000,'2020-03-15',11,'gregory.estes@novaretail.com'),
(13,'James','Murphy',30,'IT_Prog',14500,'2021-04-20',11,'james.murphy@novaretail.com'),
(14,'Joseph','Cobb',30,'IT_Support',8500,'2022-05-15',11,'joseph.cobb@novaretail.com'),
(15,'Danielle','Hawkins',30,'IT_Support',7800,'2022-06-10',11,'danielle.hawkins@novaretail.com'),
(16,'Andrea','Williams',40,'HR_Manager',14534.36,'2019-07-01',NULL,'andrea.williams@novaretail.com'),
(17,'Mariam','Omar',40,'HR_Specialist',8500,'2020-08-12',16,'mariam.omar@novaretail.com'),
(18,'Hassan','Said',40,'HR_Specialist',8200,'2021-09-20',16,'hassan.said@novaretail.com'),
(19,'Reem','Ayman',40,'HR_Analyst',9000,'2022-10-15',16,'reem.ayman@novaretail.com'),
(20,'Ali','Fathy',40,'HR_Analyst',3000,'2023-01-15',16,'ali.fathy@novaretail.com'),
(21,'Khaled','Younis',50,'Finance_Manager',17000,'2018-03-01',NULL,'khaled.younis@novaretail.com'),
(22,'Mai','Ahmed',50,'Finance_Analyst',10500,'2020-04-11',21,'mai.ahmed@novaretail.com'),
(23,'Karim','Taha',50,'Finance_Analyst',11000,'2021-05-12',21,'karim.taha@novaretail.com'),
(24,'Dina','Hany',50,'Accountant',9000,'2022-06-15',21,'dina.hany@novaretail.com'),
(25,'Mostafa','Reda',50,'Accountant',8700,'2022-07-20',21,'mostafa.reda@novaretail.com'),
(26,'Jill','Rhodes',60,'Research_Manager',19032.09,'2018-08-01',NULL,'jill.rhodes@novaretail.com'),
(27,'Angel','Hill',60,'Research_Analyst',14000,'2019-09-10',NULL,'angel.hill@novaretail.com'),
(28,'Maya','George',60,'Research_Analyst',12500,'2020-10-12',26,'maya.george@novaretail.com'),
(29,'Adam','Fouad',60,'Research_Analyst',11800,'2021-11-15',26,'adam.fouad@novaretail.com'),
(30,'Rana','Wael',60,'Research_Assistant',9000,'2022-12-10',26,'rana.wael@novaretail.com');

select * from employees;

DROP TABLE customer;
CREATE TABLE customer (
    cust_id INT PRIMARY KEY,
    cust_name VARCHAR(100) NOT NULL,
    region VARCHAR(30),
     city VARCHAR(30),
    email  VARCHAR(100)
);

INSERT INTO  customer
(cust_id, cust_name, region, city, email)
VALUES
(1,'Kristy Robinson','Rural','Fayoum','kristy@example.com'),
(2,'John Carter','Urban','Cairo','john@example.com'),
(3,'Michael Brown','Urban','Giza','michael@example.com'),
(4,'Emma Wilson','Rural','Minya','emma@example.com'),
(5,'David Smith','Urban','Cairo','david@example.com'),
(6,'Sophia Taylor','Urban','Alexandria','sophia@example.com'),
(7,'Daniel Anderson','Rural','Sohag','daniel@example.com'),
(8,'Olivia Thomas','Urban','Cairo','olivia@example.com'),
(9,'William Jackson','Rural','Qena','william@example.com'),
(10,'Ava White','Urban','Giza','ava@example.com'),
(11,'George Harris','Urban','Cairo','george@example.com'),
(12,'Isabella Martin','Rural','Assiut','isabella@example.com'),
(13,'Henry Thompson','Urban','Cairo','henry@example.com'),
(14,'Mia Garcia','Rural','Luxor','mia@example.com'),
(15,'Lucas Martinez','Urban','Giza','lucas@example.com'),
(16,'Amelia Robinson','Urban','Cairo','amelia@example.com'),
(17,'Benjamin Clark','Rural','Beni Suef','benjamin@example.com'),
(18,'Charlotte Rodriguez','Urban','Alexandria','charlotte@example.com'),
(19,'Elijah Lewis','Rural','Suez','elijah@example.com'),
(20,'Harper Lee','Urban','Cairo','harper@example.com');


select * from customer;


-- 1. Customers
CREATE TABLE dim_customer (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_name VARCHAR(100),
    segment VARCHAR(50)
);

-- 2. Products
CREATE TABLE dim_product (
    product_id VARCHAR(50) PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(50),
    sub_category VARCHAR(50)
);

-- 3. Locations
CREATE TABLE dim_location (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(50),
    state VARCHAR(50),
    city VARCHAR(50),
    postal_code VARCHAR(20),
    region VARCHAR(50)
);

-- 4. Dates
CREATE TABLE dim_date (
    date_id INT PRIMARY KEY, -- Format: YYYYMMDD
    full_date DATE,
    month INT,
    month_name VARCHAR(15),
    quarter INT,
    year INT
);

-- 5. Core Sales Fact Table
CREATE TABLE fact_sales (
    fact_id INT AUTO_INCREMENT PRIMARY KEY,
    row_id VARCHAR(50),
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    product_id VARCHAR(50),
    location_id INT,
    order_date_id INT,
    ship_date_id INT,
    ship_mode VARCHAR(50),
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(4,2),
    profit DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (location_id) REFERENCES dim_location(location_id),
    FOREIGN KEY (order_date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (ship_date_id) REFERENCES dim_date(date_id)
);

