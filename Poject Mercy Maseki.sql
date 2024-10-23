CREATE DATABASE sales_db; 
USE sales_db; 

-- create employee table --
CREATE TABLE emplyoees(
employee_id INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
department_id INT,
salary DECIMAL(10,2)
);

-- create department table --
CREATE TABLE departments (
department_id INT PRIMARY KEY,
department_name VARCHAR(100)
); 

-- create sales table --
CREATE TABLE sales(
sales_id INT PRIMARY KEY,
department_id INT,
sales DECIMAL(10,2)
); 

-- create higher earners table --
CREATE TABLE high_earners (
employee_id INT PRIMARY KEY,
name VARCHAR(100)
);

-- insert data into the table --
INSERT INTO departments(department_id,department_name)
VALUES
(1,'HR'),
(2,'Finance'),
(3,'IT'),
(4,'Sales'),
(5,'Marketing');

-- insert values into employees table--
INSERT INTO emplyoees(employee_id,first_name,last_name,department_id,salary)
VALUES
(101, 'John', 'Doe', 1, 5000.00),
(102, 'Jane', 'Smith', 2, 6000.00),
(103, 'Bob', 'Brown', 3, 4000.00),
(104, 'Alice', 'Johnson', 4, 7000.00),
(105, 'Charlie', 'Williams', 5, 8000.00),
(106, 'David', 'Jones', 4, 3000.00),
(107, 'Eve', 'Davis', 1, 2000.00),
(108, 'Frank', 'Miller', 2, 9000.00),
(109, 'Grace', 'Wilson', 3, 10000.00);

-- insert vales in the sales table--
INSERT INTO sales(sales_id,department_id,sales)
VALUES
(8, 2, 7000.00),
(9, 3, 11000.00),
(10, 1, 4000.00),
(11, 5, 9000.00),
(12, 2, 6000.00),
(13, 4, 14000.00),
(14, 3, 10500.00),
(15, 1, 3500.00),
(16, 2, 7200.00),
(17, 5, 8200.00),
(18, 3, 9800.00),
(19, 4, 16000.00),
(20, 2, 6500.00);

SELECT * FROM emplyoees;
SELECT * FROM departments;
SELECT * FROM sales;
SELECT * FROM high_earners;

-- Question 1.Update Employee Salaries--
-- Instruction: Update the salary of employees in the IT department by increasing it by 10%.--
-- For this query we shall use the update, set , where concepts learned in class--

SET SQL_SAFE_UPDATES = 0; -- set it false - disabling the safe mode 
UPDATE emplyoees
SET salary = salary * 1.1
WHERE department_id=3;
SET SQL_SAFE_UPDATES = 1; -- enabling the safe mode

UPDATE emplyoees
SET salary = salary * 1.1
WHERE employee_id IN (103,109);
-- The output is Bob Brown salary increased from 4000 to 4400 and Grace Wilson from 10000 to 11000

-- Question 2 . Select Employees with Specific Salary Range-- 
-- Instruction: Write a query to select all employees with a salary between 4000 and 8000.---
-- For this query we shall use Concepts Covered: SELECT, WHERE, BETWEEN.--

SELECT employee_id,first_name,last_name,salary
FROM emplyoees
WHERE salary BETWEEN 4000 AND 8000;
-- The output is employee_id 101,102,103,104 and 105 had salaries between that range --

-- Question 3. Group by Department and Calculate Average Salary--
-- Instruction: Group employees by department and calculate the average salary in each department.Sort the result by the average in descending order--
-- For this query we use Concepts Covered: GROUP BY , AVG(), ORDER BY .

SELECT department_id,AVG(salary)AS Avg_salary
FROM emplyoees
GROUP BY department_id
ORDER BY Avg_salary DESC;
-- The output is average salary for department_id 1 =3500, 4=5000,2=7500,5=8000,3=10248. IT department has the highest average salary--

SHOW TABLES;
SELECT * FROM emplyoees; 
SELECT * FROM departments;

-- Question 4.Filter Groups Using the HAVING Clause --
-- Instruction: Modify the previous query to only include departments where the average salary is greater than 5000--
-- For this query we use Concepts Covered: HAVING, GROUP BY , AVG().

SELECT department_id,AVG(salary)AS Avg_salary
FROM emplyoees
GROUP BY department_id
HAVING Avg_salary > 5000;
-- The out put is the department_id that have average salary above 5000 are 2,3,5 namely Finance,IT and Marketing--


-- Question 5. Common Table Expression (CTE) for High Earners --
-- Instruction: Use a CTE to create a list of employees earning more than 7000. Display their full names and salaries --
-- For this query we use  Concepts Covered: WITH, CTE, SELECT.

WITH Sep_earners AS (
SELECT first_name,last_name,salary
FROM emplyoees
WHERE salary > 7000
)
SELECT * FROM Sep_earners;
-- The out put is Charlie Williams earns 8000,Frank Miller 9000 and Grace Wilson 14,641 which are higher than 7000--


WITH high_earners AS (
SELECT CONCAT (first_name,' ',last_name)AS full_name,salary
FROM emplyoees
WHERE salary > 7000
)
SELECT * FROM high_earners

-- 6.Join Employees and Departments --
-- Instruction: Write a query that joins the employees and departments tables to display the employee's full name and their department name --
-- For this query we use Concepts Covered: JOIN, ON, SELECT --

SELECT emplyoees.first_name,emplyoees.last_name,departments.department_name
FROM emplyoees
INNER JOIN  departments ON emplyoees.department_id=departments.department_id;
-- The out put we have joined 9 emlpoyees to the 5 departments,HR we have 2,Finance 2,IT we have 2,Sales we have 2,Marketing we have 1--

-- 7. Left Join Employees and Sales --
-- Instruction: Write a query that retrieves the employee names and their respective sales (if any) from the sales table.Include employees if they have no sales.--
-- For this Query we use Concepts Covered: LEFT JOIN, COALESCE, NULL.

SELECT DISTINCT emplyoees.first_name,emplyoees.last_name,sales,COALESCE (sales.department_id,'No Department')AS department_id
FROM emplyoees 
LEFT JOIN  sales  ON emplyoees .department_id=sales.department_id;
-- The out put is John Doe department _id 1 has 7500 sales,Eve Davis deprtment _id 1 has 7500 sales,Jane Smith from department_id 2 has 26700sales,Frank Miller from department_id 2 has 26700 sales,Bob Brown from department_id 3 has 31300 sales,Grace Wilson from department_id has 31300 sales--
-- Alice Johnson from department_id 4 has 30000 sales,David Jones from department_id 4 has 30000 sales,Charlie Williams from department_id 5 has 17200 sales ---

SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name,COALESCE(s.sales, 0) AS sales
FROM emplyoees e 
LEFT JOIN sales s ON e.employee_id = s.sale_id;  -- Assuming employee_id relates to sale_id

-- 8.Find the Employee(s) with the Highest Salary--
-- Instruction: Write a query to find the employee(s) with the highest salary using a subquery.--
-- For this Query we use Concepts Covered: MAX(), Subqueries.

SELECT first_name,last_name,salary
FROM emplyoees
WHERE salary =(
  SELECT MAX(salary)
  FROM emplyoees
  );
  -- The out putis  Grace Wilson has the highest salary 14641--
  
  
-- 9. Calculate Total Sales by Department --
-- Instruction: Write a query to calculate the total sales for each department. Group the result by department and order by total sales in descending order --
-- For this  Query we use Concepts Covered: GROUP BY , SUM(), ORDER BY .

WITH Dep_sales AS (
SELECT department_id,SUM(sales) AS total_sales
FROM sales
GROUP BY department_id
)
SELECT d.department_name,ds.total_sales
FROM departments d
INNER JOIN Dep_sales ds ON d.department_id= ds.department_id
ORDER BY ds.total_sales DESC;
-- The output for total sales by each department is IT 31300, Sales 30000,Finance 26700,Marketing 17200 and HR 7500--

-- 10. Join and Group by with HAVING -- 
-- Instruction: Write a query that joins the departments and sales tables, then groups the result by department name.Only include departments that have total sales greater than 10000.--
-- For this Query we use Concepts Covered: JOIN, GROUP BY , HAVING, SUM().


SELECT d.department_name,SUM(sales) AS total_sales
FROM departments d
JOIN sales s  ON d.department_id= s.department_id
GROUP BY d.department_name
HAVING total_sales > 10000;
-- The output for the department that has total sales greater than 10000 is IT with 31300,Sales 30000,Finance with 26700 and marketing with 17200--


