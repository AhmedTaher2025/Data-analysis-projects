Create database UniversityDB;
use UniversityDB;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL UNIQUE
);

insert into departments (department_id,department_name)
values
(10,"Statistics"),
(20,"Computer Science"),
(30,"Business"),
(40,"Mathematics"),
(50,"Information Systems");

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(50) not null,
    age int,
    gender varchar(10),
    department_id int, foreign key  (department_id)
    REFERENCES departments (department_id),
    GPA dec (3,2)
);
insert into students(student_id,first_name,last_name,age,gender,department_id,GPA)
values
(1,"Ahmed","Hassan",20,"Male",10,3.50),
(2,"sara","Ali",21,"Female",20,3.80),
(3,"Omar","Khaled",22,"Male",30,2.90),
(4,"Mona","Ibrahim",20,"Female",10,3.70),
(5,"Youssef","Mahmoud",23,"Male",20,3.20),
(6,"Nour","Tarek",21,"Female",40,3.90),
(7,"Karim","Samir",22,"Male",20,2.80),
(8,"Hana","Adel",20,"Female",30,3.60),
(9,"Mohamed","Fathy",24,"Male",50,3.10),
(10,"Laila","Mostafa",21,"Female",10,3.95)
;
select * from students;