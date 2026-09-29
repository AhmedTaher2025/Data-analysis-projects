create database titanic;

use titanic;

SELECT * 
FROM titanic.`titanic csv`;


# Display only the first 10 records

SELECT *
FROM titanic.`titanic csv`
LIMIT 20;


# Count the total number of records

SELECT
count(*) As Total_Passengers
FROM titanic.`titanic csv`;


# Display the structure of the table

DESCRIBE titanic.`titanic csv`;

SHOW COLUMNS
FROM titanic.`titanic csv`;

# Data Validation
# Display the columns using SHOW COLUMNS
# PART 3 - DATA VALIDATION
# 3.1 - Check Passenger IDs
SELECT
    PassengerId
FROM titanic.`titanic csv`
LIMIT 20;



# 3.2 - Check duplicate Passenger IDs


# PassengerId should normally be unique.

SELECT
    PassengerId,
    COUNT(*) AS Number_of_Rows
FROM titanic.`titanic csv`
group by PassengerId
Having count(*) > 1
;


#Where
#having 


Select * from titanic.`titanic csv` 
where Sex ='male';

# 3.3 - Check Survived values
# Survived:
# 0 = Did not survive
# 1 = Survived

SELECT
    Survived,
    COUNT(*) AS Number_of_Passengers
FROM titanic.`titanic csv`
GROUP BY Survived;


# 3.4 - Check passenger classes

SELECT
    Pclass,
    COUNT(*) AS Number_of_Passengers
FROM titanic.`titanic csv`
GROUP BY Pclass
ORDER BY Pclass;
# 3.5 - Check gender
SELECT
    Sex,
    COUNT(*) AS Number_of_Passengers
FROM titanic.`titanic csv`
GROUP BY Sex;
# 3.6 - Check Embarked values
# C = Cherbourg
# Q = Queenstown
# S = Southampton

SELECT
    Embarked,
    COUNT(*) AS Number_of_Passengers
FROM titanic.`titanic csv`
GROUP BY Embarked;



# 3.7 - Check missing values


SELECT

    SUM(PassengerId IS NULL or  trim(PassengerId)='') AS Missing_PassengerId,

    SUM(Survived IS NULL or trim(Survived)='') AS Missing_Survived,

    SUM(Pclass IS NULL or trim(Pclass)='') AS Missing_Pclass,

    SUM(Name IS NULL or trim(Name)='') AS Missing_Name,

    SUM(Sex IS NULL or trim(Sex)='') AS Missing_Sex,

    SUM(Age IS NULL or trim(Age)='') AS Missing_Age,

    SUM(SibSp IS NULL or trim(SibSp)='') AS Missing_SibSp,

    SUM(Parch IS NULL or trim(Parch)='') AS Missing_Parch,

    SUM(Ticket IS NULL or trim(Ticket)='') AS Missing_Ticket,

    SUM(Fare IS NULL or trim(Fare)='') AS Missing_Fare,

    SUM(Cabin IS NULL or trim(Cabin)='') AS Missing_Cabin,

    SUM(Embarked IS NULL or trim(Embarked)='') AS Missing_Embarked

FROM titanic.`titanic csv`;


# PART 4 - BASIC DATA ANALYSIS
# 4.1 - Total passengers

Select count(*) as Total_Passengers 
from titanic.`titanic csv`;


# 4.2 - Total survivors
Select Sum(Survived) as total_survivors from titanic.`titanic csv`;


Select count(*)- sum(Survived) as total_not from titanic.`titanic csv`;


# Survival rate
Select round(avg(Survived)*100, 2) as Survival_rate from titanic.`titanic csv`;



SELECT
    SUM(Survived) AS Total_Survivors
FROM titanic.`titanic csv`;


# 4.3 - Total non-survivors
SELECT
    COUNT(*) - SUM(Survived) AS Total_Non_Survivors
FROM titanic.`titanic csv`;
# 4.4 - Overall survival rate
SELECT

    ROUND(
        AVG(Survived) * 100,
        2
    ) AS Survival_Rate

FROM titanic.`titanic csv`;
# 4.5 - Average age
SELECT

    ROUND(
        AVG(Age),
        2
    ) AS Average_Age

FROM titanic.`titanic csv`;
# 4.6 - Average fare

SELECT ROUND(
        AVG(Fare),
        2
    ) AS Average_Fare

FROM titanic.`titanic csv`;


###### Session 2
# PART 5 :  Data Cleaning 
#CASE STATEMENTS

# 5.1 - Convert Pclass into meaningful class names
SELECT PassengerId,   Pclass, CASE 
      WHEN Pclass = 1 THEN 'First Class'
      WHEN Pclass = 2 THEN 'Second Class'
      WHEN Pclass = 3 THEN 'Third Class'
      ELSE 'Unknown'
      END
      AS Class_Name
FROM titanic.`titanic csv`;

# 5.2 - Create Age Groups

SELECT PassengerId, Age, CASE
WHEN Age IS NULL THEN 'Unknown'
WHEN Age < 13  THEN 'Child'
WHEN Age < 20 THEN 'Teenager'
WHEN Age < 60  THEN 'Adult'
ELSE 'Senior'
END AS Age_Group
FROM titanic.`titanic csv`;

# 5.3 - Create survival status

SELECT PassengerId, Survived, CASE
WHEN Survived = 1 THEN 'Survived'
WHEN Survived = 0 THEN 'Did Not Survive'
ELSE 'Unknown'
END AS Survival_Status
FROM titanic.`titanic csv`;

# PART 6 - NORMALIZATION (This creates a Star Schema)
# transform the original flat table into:
# 1. dim_passenger
# 2. dim_class
# 3. dim_ticket
# 4. dim_embarked
# 5. fact_passenger

# PART 7 - DELETE OLD TABLES
# We delete the analytical tables if they already exist:
# This allows us to run the project again without errors.


DROP TABLE IF EXISTS fact_passenger;

DROP TABLE IF EXISTS dim_passenger;

DROP TABLE IF EXISTS dim_pclass;

DROP TABLE IF EXISTS dim_tickets;

DROP TABLE IF EXISTS dim_emarked;


# PART 8 - CREATE PASSENGER DIMENSION

create table dim_passenger(
Passenger_key int auto_increment primary key,
Passenger_ID int not null unique,
Name varchar(200),
Sex varchar(25)
);







CREATE TABLE dim_passenger ( 
Passenger_Key INT AUTO_INCREMENT PRIMARY KEY,
PassengerId INT NOT NULL UNIQUE,
Name VARCHAR(255),
Sex VARCHAR(20)
);

# Check the table
DESCRIBE dim_passenger;


# PART 9 - CREATE CLASS DIMENSION
CREATE TABLE dim_class (
Class_Key INT AUTO_INCREMENT PRIMARY KEY,
Pclass INT NOT NULL UNIQUE,
Class_Name VARCHAR(50)
);
# Check the table
DESCRIBE dim_class;

# PART 10 - CREATE TICKET DIMENSION
CREATE TABLE dim_ticket (
Ticket_Key INT AUTO_INCREMENT PRIMARY KEY,
Ticket VARCHAR(100) NOT NULL UNIQUE
);

# Check the table
DESCRIBE dim_ticket;

# PART 11 - CREATE EMBARKED DIMENSION
CREATE TABLE dim_embarked (
Embarked_Key INT AUTO_INCREMENT PRIMARY KEY,
Embarked VARCHAR(100) NOT NULL UNIQUE,
Port_Name VARCHAR(100)
);
ALTER TABLE dim_embarked
drop COLUMN Port_Name ;

# Check the table
DESCRIBE dim_embarked;
 
# PART 12 - INSERT DATA INTO PASSENGER DIMENSION
INSERT INTO dim_passenger
(Passenger_ID, Name, Sex)
SELECT DISTINCT
PassengerId, Name, Sex
FROM titanic.`titanic csv`
WHERE PassengerId IS NOT NULL;


# Check passenger dimension
SELECT * FROM dim_passenger  LIMIT 20;


# Count passengers

SELECT
    COUNT(*) AS Passenger_Dimension_Rows
FROM dim_passenger;

# PART 13 - INSERT DATA INTO CLASS DIMENSION
insert into dim_class (pclass, class_name)
select distinct pclass, case 
when pclass=1 then 'first class'
when pclass=2 then 'second class'
when pclass=3 then 'third class'
else 'unknown'
end as class_name
from titanic.`titanic csv`
where pclass is not null;

Select * from titanic.dim_class;



INSERT INTO dim_class
( class, Class_Name)
SELECT DISTINCT
Pclass,
CASE  WHEN Pclass = 1 THEN 'First Class'
      WHEN Pclass = 2 THEN 'Second Class'
      WHEN Pclass = 3  THEN 'Third Class'
      ELSE 'Unknown'
END AS Class_Name
FROM titanic.`titanic csv`
WHERE Pclass IS NOT NULL;


# Check class dimension

SELECT * FROM dim_class;

# PART 14 - INSERT DATA INTO TICKET DIMENSION
INSERT INTO dim_ticket
(Ticket)
SELECT DISTINCT
Ticket
FROM titanic.`titanic csv`
WHERE Ticket IS NOT NULL;

set  foreign_key_checks =1;

truncate table `dim_ticket` ;
# Check ticket dimension
SELECT * FROM dim_ticket LIMIT 5;

# PART 15 - INSERT DATA INTO EMBARKED DIMENSION
INSERT INTO dim_embarked
( Embarked)
SELECT DISTINCT
Embarked
FROM titanic.`titanic csv`
WHERE Embarked IS NOT NULL;
set  foreign_key_checks =1;

truncate table dim_embarked ;

# Check embarked dimension
SELECT * FROM dim_embarked;


CREATE TABLE fact_passenger (
    Passenger_ID INT NOT NULL,             -- FK to dim_passenger
    Class_Key INT NOT NULL,                -- FK to dim_class
    Ticket_Key INT NOT NULL,               -- FK to dim_ticket
    Embarked_Key INT NOT NULL,             -- FK to dim_embarked
    
    Survived BIT,                          -- fact: survival outcome
    Fare DECIMAL(10,2),                    -- fact: fare paid
    Age INT,                               -- fact: age of passenger
    
    PRIMARY KEY (Passenger_ID),
    CONSTRAINT fk_passenger FOREIGN KEY (Passenger_ID) REFERENCES dim_passenger(Passenger_ID),
    CONSTRAINT fk_class FOREIGN KEY (Class_Key) REFERENCES dim_class(Class_Key),
    CONSTRAINT fk_ticket FOREIGN KEY (Ticket_Key) REFERENCES dim_ticket(Ticket_Key),
    CONSTRAINT fk_embarked FOREIGN KEY (Embarked_Key) REFERENCES dim_embarked(Embarked_Key)
);



INSERT INTO fact_passenger (
    Passenger_ID,
    Class_Key,
    Ticket_Key,
    Embarked_Key,
    Survived,
    Fare,
    Age
)
SELECT
    p.Passenger_ID,
    c.Class_Key,
    t.Ticket_Key,
    e.Embarked_Key,
    raw.Survived,
    raw.Fare,
    raw.Age
FROM titanic.`titanic csv` raw
INNER JOIN dim_passenger p
        ON raw.PassengerId = p.Passenger_ID
INNER JOIN dim_class c
        ON raw.Pclass = c.Pclass
INNER JOIN dim_ticket t
        ON raw.Ticket = t.Ticket
INNER JOIN dim_embarked e
        ON raw.Embarked = e.Embarked;


-- Preview first 20 rows from fact table
SELECT * 
FROM fact_passenger 
LIMIT 20;


-- Count rows in fact table
SELECT COUNT(*) AS fact_rows 
FROM fact_passenger;

-- Compare row counts across all tables
SELECT 'original csv table' AS table_name, COUNT(*) AS number_of_rows 
FROM titanic.`titanic csv`
UNION ALL
SELECT 'dim_passenger', COUNT(*) 
FROM dim_passenger
UNION ALL
SELECT 'dim_ticket', COUNT(*) 
FROM dim_ticket
UNION ALL
SELECT 'dim_embarked', COUNT(*) 
FROM dim_embarked
UNION ALL
SELECT 'dim_class', COUNT(*) 
FROM dim_class
UNION ALL
SELECT 'fact_passenger', COUNT(*) 
FROM fact_passenger;



SELECT  
    p.Sex,
    COUNT(*) AS total_passenger,
    SUM(f.Survived) AS Survivors,
    COUNT(*) - SUM(f.Survived) AS non_survivors,
    ROUND(AVG(f.Survived) * 100, 2) AS survival_rate
FROM    fact_passenger f
INNER JOIN dim_passenger p
        ON f.Passenger_ID = p.Passenger_ID
GROUP BY p.Sex
ORDER BY survival_rate DESC;


SELECT  
    c.Class_Name,
    COUNT(*) AS total_passenger,
    SUM(f.Survived) AS Survivors,
    COUNT(*) - SUM(f.Survived) AS non_survivors,
    ROUND(AVG(f.Survived) * 100, 2) AS survival_rate
FROM    fact_passenger f
INNER JOIN dim_class c
        ON f.Class_Key = c.Class_Key
GROUP BY c.Class_Name
ORDER BY survival_rate DESC;


-- Age Analysis
-- Age Category Analysis View
CREATE VIEW age_category_analysis_view AS
WITH Age_Category AS (
    SELECT  
        CASE 
            WHEN f.Age BETWEEN 0 AND 12 THEN 'Child'
            WHEN f.Age BETWEEN 13 AND 19 THEN 'Teen'
            WHEN f.Age BETWEEN 20 AND 39 THEN 'Adult'
            WHEN f.Age BETWEEN 40 AND 59 THEN 'Middle-Aged'
            WHEN f.Age >= 60 THEN 'Senior'
            ELSE 'Unknown'
        END AS Age_Group,
        COUNT(*) AS total_passenger,
        SUM(f.Survived) AS Survivors,
        COUNT(*) - SUM(f.Survived) AS non_survivors,
        ROUND(AVG(f.Survived) * 100, 2) AS survival_rate
    FROM fact_passenger f
    GROUP BY Age_Group
)
SELECT  
    Age_Group,
    total_passenger,
    Survivors,
    survival_rate
FROM Age_Category
ORDER BY survival_rate DESC;



-- Class Analysis
CREATE VIEW Class_Analysis_view AS
WITH Class_Analysis AS (
    SELECT  
        c.`Class_Name`,
        COUNT(*) AS total_passenger,
        SUM(f.Survived) AS Survivors,
        COUNT(*) - SUM(f.Survived) AS non_survivors,
        ROUND(AVG(f.Survived) * 100, 2) AS survival_rate
    FROM fact_passenger f
    INNER JOIN dim_class c 
        ON f.Class_Key = c.Class_Key
    GROUP BY c.Pclass
)
SELECT  
    `Class_Name`,
    total_passenger,
    Survivors,
    survival_rate
FROM Class_Analysis
ORDER BY survival_rate DESC;

-- Gender Analysis View
CREATE VIEW gender_analysis_view AS
WITH Gender_Analysis AS (
    SELECT  
        p.Sex,
        COUNT(*) AS total_passenger,
        SUM(f.Survived) AS Survivors,
        COUNT(*) - SUM(f.Survived) AS non_survivors,
        ROUND(AVG(f.Survived) * 100, 2) AS survival_rate
    FROM fact_passenger f
    INNER JOIN dim_passenger p 
        ON f.Passenger_ID = p.Passenger_ID
    GROUP BY p.Sex
)
SELECT  
    Sex,
    total_passenger,
    Survivors,
    survival_rate
FROM Gender_Analysis
ORDER BY survival_rate DESC;


delimiter //
CREATE PROCEDURE GetSurvivalBySex(IN p_sex VARCHAR(20))
BEGIN
    SELECT
        Class_name,
        Sex,
        COUNT(*) AS total_passengers,
        SUM(Survived) AS survivors,
        ROUND(AVG(Survived) * 100, 1) AS survival_pct
    FROM fact_passenger F
    WHERE Sex = p_sex
    GROUP BY Pclass, Sex;
END //
delimiter ;
