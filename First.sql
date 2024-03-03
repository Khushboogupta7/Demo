CREATE DATABASE ASSIGNMENT
USE ASSIGNMENT;
CREATE TABLE EmployeeDetails (
	Emp_id int primary key,
    FullName varchar(30),
    Manager_id int NOT NULL,
    Dateofjoining DATE,
    City char(20)
);
CREATE TABLE Employeesalary(
	Emp_id int primary key,
    Project char(10),
    Salary int,
    Variable int
);

SELECT * FROM EmployeeDetails
-- query 
SELECT FullName
FROM EmployeeDetails 
JOIN Employeesalary
ON EmployeeDetails.Emp_id = Employeesalary.Emp_id
WHERE Salary> 50000;

-- Inserting Values Into Table.
INSERT INTO EmployeeDetails
VALUES
	(121, 'John Snow', 321, '2019-01-31' , 'Toronto'),
	(321, 'Walter White', 986, '2020-01-30' , 'California'),
	(421, 'Kuldeep Rana', 876, '2021-11-27' , 'New Delhi');

INSERT INTO Employeesalary
VALUES
	(121, 'P1', 8000 , 500),
	(321, 'P2' , 10000 , 1000),
	(421, 'P1', 12000 , 0);
    
-- 1. Write an SQL query to fetch the EmpId and FullName of 
-- all the employees working under the Manager with id – ‘986’.

SELECT Emp_id, Fullname 
FROM EmployeeDetails
WHERE Manager_id =986;


-- 2. Write an SQL query to fetch the different projects 
-- available from the EmployeeSalary table. 
SELECT DISTINCT( Project)
FROM Employeesalary

-- 3. Write an SQL query to fetch the count of employees working in project ‘P1’. 
SELECT COUNT(Emp_id)
FROM Employeesalary
WHERE Project = 'P1';





