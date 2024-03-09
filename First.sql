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






-- 4. Write an SQL query to find the maximum, minimum, and average salary of the employees. 
SELECT   MAX(Salary), MIN(Salary), AVG(Salary)
FROM Employeesalary;

-- 5. Write an SQL query to find the employee id whose salary lies in the range of 9000 and 15000. 
SELECT Emp_id, Salary
FROM Employeesalary
WHERE Salary>=9000 AND SALARY <=15000;

-- 6. Write an SQL query to fetch those employees who live in Toronto and work under the manager with ManagerId – 321. 
SELECT Emp_id, City, Manager_id
FROM EmployeeDetails
WHERE City='Toronto' AND Manager_id='321';

-- 7. Write an SQL query to fetch all the employees who either live in California or work under a manager with ManagerId – 321.  
SELECT Emp_id, City, Manager_id
FROM EmployeeDetails
WHERE City='California' OR Manager_id='321';

 -- 8. Write an SQL query to fetch all those employees who work on Projects other than P1. 
SELECT Emp_id 
FROM Employeesalary
WHERE NOT Project = 'P1';

