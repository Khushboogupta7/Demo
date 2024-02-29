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