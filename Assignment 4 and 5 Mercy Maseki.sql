CREATE DATABASE company_db;
USE company_db;
 
 
-- create a table
CREATE TABLE employees (
   employee_id INT PRIMARY KEY,
   first_name VARCHAR(50),
   last_name VARCHAR(50),
   department_id INT,
   salary DECIMAL(10, 2)
);
 
-- create department table
CREATE TABLE departments (
   department_id INT PRIMARY KEY,
   department_name VARCHAR(100)
);
 
 
-- create sales table
CREATE TABLE sales (
   sale_id INT PRIMARY KEY,
   department_id INT,
   sales DECIMAL(10, 2)
);
 
 
-- create higher earners table
CREATE TABLE high_earners (
   employee_id INT PRIMARY KEY,
   name VARCHAR(100)
);
 
-- insert data into the table
 
INSERT INTO departments (department_id, department_name)
VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Sales'),
(5, 'Marketing');
 
 -- data verification --
 SELECT *FROM employees;
 
 -- insert values into the employee table
INSERT INTO employees (employee_id, first_name, last_name, department_id, salary)
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
 
-- insert values in the sales table
INSERT INTO sales (sale_id, department_id, sales)
VALUES
(1, 1, 2000.00),
(2, 2, 5000.00),
(3, 3, 10000.00),
(4, 4, 15000.00),
(5, 5, 8000.00),
(6, 4, 12000.00),
(7, 1, 3000.00);
 
-- data verification
 
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM sales;

-- 25th Sep 2024 -- Class Work-- 
-- use where clause --
-- to retrieve employees whose salary is --
-- Higher than the average salary in the company -- 

SELECT employee_id,first_name,last_name,salary
FROM employees
WHERE salary > (SELECT AVG (salary)FROM employees);
-- use the sub query to select the total sales for each departmentand then get the department with sales greater than 1000 --

SELECT *From sales;
SELECT *From departments;
SELECT * FROM employees;

SELECT department_id, total_sales
FROM ( SELECT department_id, SUM(sales) AS total_sales
FROM sales
GROUP BY department_id) AS Mercy_Billion_Dollar
WHERE total_sales > 1000;

-- Subquery with IN operator --
-- list all employees in HR department-- 
-- find all employees who work in the same department as employee 101 --

SELECT employee_id,first_name,last_name
FROM employees
WHERE department_id IN (SELECT department_id FROM employees WHERE employee_id=101);

-- list all employees in Finance department-- 
SELECT employee_id,first_name,last_name,salary
FROM employees
WHERE department_id IN (SELECT department_id FROM employees WHERE employee_id=102);

 -- Subquery in HAVING Clause --
 -- The HAVING Clause in SQL is used to filter records based on a condition that applies to aggregated results --
 -- (such as the result of SUM(), COUNT(), AVG(), etc.).
 -- It is similar to the WHERE clause, but the key difference is that WHERE filters rows before aggregation,
-- whereas HAVING filters groups after aggregation --

-- Find departments where the average salary is greater than 5000.

SELECT department_id,AVG(salary) AS Avg_salary
FROM employees
GROUP BY department_id
HAVING  AVG(salary) > (SELECT AVG(salary) FROM employees WHERE employee_id>=105); 

-- Subquery with EXISTS Operator --
-- check if there are any employees with in the sales department --
SELECT department_name
FROM departments
WHERE EXISTS (SELECT 1
FROM employees
WHERE employees.department_id = departments.department_id
AND department_name = 'sales');

-- Subquery with  UPDATE --
-- Increase the salary of all employees whose department has more than 10 employees --

UPDATE employees
SET salary = salary * 1.1
WHERE department_id IN(SELECT department_id
FROM employees
GROUP BY department_id
HAVING COUNT(employee_id)>10);

-- Subquery with  DELETE --
-- Delete employees who are in departments with fewer than 5 employees --

DELETE FROM employees
WHERE department_id IN(SELECT department_id
FROM employees
GROUP BY department_id
HAVING COUNT(employee_id)>5);

-- Corrected Version --
DELETE FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM (
        SELECT department_id
        FROM employees
        GROUP BY department_id
        HAVING COUNT(employee_id) > 5
    ) AS dept_subquery
);


-- Subquery with INSERT --
INSERT INTO high_earners (employee_id,name)
SELECT employee_id,first_name||''||last_name
FROM employees
WHERE salary > (SELECT AVG(salary)FROM employees);

-- 26th Sep 2024 --
-- Short Notes on the Differences --
-- Differences between the Clauses --
-- Group By Vs Order By --
-- GROUP BY is used for grouping rows into sets based on a common value in one or more columns.Its mostly used when working with aggregate functions.
-- ORDER BY is used for sorting the final result set in a specific order (ascending or descending). It doesn't change the underlying dat, it just reorders the output-
-- GROUP BY vs HAVING:
-- GROUP BY creates grouped sets of data (e.g.grouping all employees by department).
-- HAVING is used to filter the grouped sets created by GROUP BY. You cannot use HAVING without first using Group By --
-- WHERE vs HAVING:
-- WHERE filters rows before the grouping occurs, and is used to filter data on individual row conditions--
-- HAVING filters the result after the grouping is done. It is applied on aggregate conditions (like sum, average,max, min etc)

-- Group by clause is used to group rows that have the same values in the specific columns --
-- It is typically used when you want to aggregate data across multiple records based on common values --
-- often combined with aggregate functions like SUM(), COUNT(), AVG(), MIN(), MAX().
-- syntax --
SELECT column_name, AGGREGATE_FUNCTION(column_name)
FROM table_name
GROUP BY column_name;

-- Calculate Total Sales per Department --

SELECT department_id,SUM(sales) AS total_sales
FROM sales
GROUP BY department_id

-- Calculate the Employee Average Salary Per Department--
SELECT department_id,AVG(salary) AS Average_Salary
FROM employees
GROUP BY department_id;

-- Calculate the minimum salary per department in the Employee table --
SELECT department_id,MIN(salary) AS Min_Salary
FROM employees
GROUP BY department_id

-- Calculate the maximum salary per department in the employee table.--
SELECT department_id, MAX(salary) AS Max_Salary
FROM employees
GROUP BY department_id

-- Combine Example: Using AVG(), MIN(), MAX() Together
-- Calculate average, minimum, and maximum salary per department
-- summary table for all the functions --
SELECT department_id,
AVG(salary) AS Average_Salary,
MIN(salary) AS Min_Salary,
MAX(salary) AS Max_Salary,
COUNT(employee_id) AS Total_Employees
FROM employees
GROUP BY department_id;

-- HAVING clause --
-- The HAVING clause is used to filter groups of data created by the GROUP BY clause.
-- It’s similar to the WHERE clause, but while WHERE filters individual rows before grouping,HAVING filters Groups after aggregation--

-- syntax
SELECT column_name, AGGREGATE_FUNCTION(column_name)
FROM table_name
GROUP BY column_name
HAVING AGGREGATE_FUNCTION(column_name) > condition;
-- example 1 --
-- Group sales by department and filter departments with total sales > 20,000

SELECT department_id,SUM(sales) AS total_sales
FROM sales
GROUP BY department_id
HAVING total_sales>20000;

-- example --
-- Group employees by department and filter departments with more than 1 employee
SELECT department_id, COUNT(employee_id) AS total_employee
FROM employees
GROUP BY department_id
HAVING total_employee > 1;

-- use WHERE CLAUSE in the example above --
SELECT department_id, COUNT(employee_id) AS total_employee
FROM employees
WHERE department_id>=1
GROUP BY department_id
HAVING total_employee>1;

-- without having clause --
SELECT department_id, COUNT(employee_id) AS total_employee
FROM employees
WHERE department_id>1
GROUP BY department_id

-- ORDER BY clause --
-- it is used to sort the results set by one of the clauses in a ascending descending order
-- (ASC) , -- (DESC)

-- Syntax --
SELECT column_name ( multiple columns) the columns you want to view
FROM table_name
ORDER BY column_name [ASC|DESC];

-- example --
-- select all employee and order them by salary in DESC
SELECT employee_id, first_name, last_name, salary
FROM employees
ORDER BY salary DESC 

-- combine all the clause --
-- Select departments with more than 2 employees and total sales above 10,000, ordered by sales

SELECT employees.department_id, SUM(sales.sales) AS total_sales,
COUNT(employees.employee_id) AS num_employees
FROM employees
JOIN sales ON employees.department_id = sales.department_id
GROUP BY employees.department_id
HAVING num_employees > 2 AND total_sales > 10000
ORDER BY total_sales DESC;

SELECT department_id, COUNT(employee_id) AS total_employee
FROM employees
GROUP BY department_id
HAVING total_employee >1;

-- 30th Sep 2024 --Class Work-------

-- CROSS JOIN , INNER JOIN , RIGHT OUTER JOIN , LEFT OUTER JOIN ETEC--- 

select *from sales;
SELECT * FROM departments;
SELECT * FROM employees;


-- CROSS JOIN -
-- NOTES -- 
-- cross join, which is also known as a cross product or a cartesian product.
-- A cross join is the result of combining every row from the left table with every row from the right
-- table
-- syntax -- 
SELECT *
FROM table1
CROSS JOIN table2;

SELECT *
FROM sales, employees;

-- syntax 2 
SELECT *
FROM courses , enrollment ;
 
 -- example 1 onn syntax 1  --
 
SELECT *
FROM sales 
CROSS JOIN departments;
-- introduce the where clause to give more condtions 

-- syntax 
SELECT *
FROM sales , departments
WHERE num = cnum;




-- change the column name of the department table to dep_id
ALTER TABLE departments
RENAME COLUMN department_id TO dep_id;

SELECT *FROM departments;

-- example 
SELECT *
FROM sales, departments
WHERE dep_id = department_id;
-- cross can make loose data if the table rows do not match .
-- only apply cross join when the rows in the tables  matches with  each
-- others


-- INNER JOIN and introduce ON clause --
-- syntax 
SELECT *
FROM  table1 INNER JOIN table2
ON table1_column_name = table2_column_name;

-- example 1 
SELECT *
FROM sales INNER JOIN departments
ON department_id = dep_id;

-- syntax of the LEFT OUTER JOIN-- 

SELECT *
FROM table1 LEFT OUTER JOIN table2
ON column1_table1 = column2_table2;

-- eaxmple 
SELECT *
FROM sales LEFT OUTER JOIN departments
ON department_id = dep_id;

-- TIGHT OUTER JOIN 
SELECT *
FROM sales RIGHT OUTER JOIN departments
ON department_id = dep_id;

-- FULL OUTER JOIN  CLAUSE --

 -- syntax  
SELECT *
FROM table1  FULL OUTER JOIN table2
ON column1_table1 = column2_table2;

-- SELECT *
-- FROM sales 
-- FULL OUTER JOIN departments
-- ON department_id = dep_id;
 
 
 -- subqueries 
 -- syntax 
SELECT column_table1
FROM table1
WHERE table2 >= (
SELECT AVG(table2)
FROM table1
);

select * from employees;
-- example 
 SELECT employee_id, first_name, salary
 FROM employees 
 WHERE salary >= (
 SELECT AVG(salary)
 FROM employees
 );


 -- correlated subquery 
 -- syntax
SELECT *
FROM table1
WHERE EXISTS (
SELECT *
FROM table2
WHERE table1.column1 = table2.column2
) ;
 
-- example 1 

SELECT employee_id, first_name, salary 
FROM employees e -- outer join aliases
WHERE salary > (

SELECT AVG(salary)
FROM employees e2 -- inner join aliases
WHERE e2.department_id = e.department_id
);
 

 
 -- Exercise:
-- 1 Write a query using FULL OUTER JOIN to display all departments and their corresponding employees (including departments without employees and employees without departments).
-- 2 Use a LEFT JOIN to find all employees and their sales (including those without any sales records).
-- 3 **Create a correlated subquery to find employees earning more than the average salary of their department.

-- 30th Sep 2024 --Assignment 4
-- Question 1 ---
-- Write a query to retrieve the first and last names of employees along with their corresponding department names --
--  An INNER JOIN retrieves records that have matching values in both tables.In this case,we will join the employees table with the departments table based on the department_id to get the names of the employees and their departments

SELECT employees.first_name, employees.last_name, departments.department_name
FROM employees
INNER JOIN departments ON employees.department_id = departments.department_id;

-- Question 2 --
-- LEFT JOIN Question --
-- Task: Create a query that lists all employees and their total sales amounts. Include employees who do not have any sales records
-- Explanation:A LEFT JOIN returns all records from the left table (in this case,employees) and the matched records from the right table (sales).--
-- If there is no match,the result is NULL for the sales fields.This helps us see which employees sales and which ones do not--

SELECT employees.first_name, employees.last_name, sales.sales
FROM employees
LEFT JOIN sales ON employees.department_id = sales.department_id;

-- Question 3 --
-- RIGHT JOIN Question --
-- Task: Write a query to display all departments and their employees. Include departments that do not have any employees --
-- Explanation: A RIGHT JOIN returns all records from the right table (departments) and matched records from the left table empliyees--
-- If a department has no employees, the employee fields will show NULL,allowing us to see all departments regardless of employee presence --

SELECT employees.first_name, employees.last_name, departments.department_name
FROM employees
RIGHT JOIN departments ON employees.department_id = departments.department_id;

-- Question 4 --
-- FULL OUTER JOIN Question--
-- Task: Write a query using FULL OUTER JOIN to find all employees and departments ensuring that you include employees without departments and departments without employees--
-- Explanation: A FULL OUTER JOIN combines the results of both LEFT JOIN and RIGHT JOIN,returning all records from both tables and filling in NULLS where there are no matches.--
-- This allows us to see every employee and every department, even if they are unmatched.--

SELECT employees.first_name, employees.last_name, departments.department_name
FROM employees
FULL OUTER JOIN departments ON employees.department_id = departments.department_id;

-- Question 5 --
-- Subquery Question --
-- Task: Create a query to find all employees whose salaries are above the average salary of all employees in the company --
-- Explanation: A subquery is a query nested inside another query. Here, we first calculate the average salary from the employees table, and then use that result to filter employees whose salaries exceed the average--

SELECT first_name,last_name,salary
FROM employees
WHERE salary>(SELECT AVG(salary)FROM employees);

-- Question 6 --
-- Correlated Subquery Question --
-- Task: Write a query that lists employees who earn more than the average salary of their respective departments.--
-- Explanation: A correlated subquery refers to the outer query in its execution. In this example, we will calculate the average salary for each department within the subquery and compare each employee's salary to that average

SELECT first_name,last_name,salary
FROM employees
WHERE salary>(SELECT AVG(salary)
FROM employees 
WHERE employees.department_id = employees.department_id);

-- Question 7 --
-- NATURAL JOIN Question --
-- Task: Create a query that uses a NATURAL JOIN to combine the employees and departments tables and displays the first name,last name and department name.
-- Explanation: A NATURAL JOIN automatically joins tables based on columns with the same name.In this case,it will match based on department_id.It simplifies queries when you know that tables share common columns--

SELECT *
FROM employees
NATURAL JOIN departments;

-- Question 8 --
-- Name Conflict Question:--(Use of aliases)
-- Task: Write a query to retrieve the first name and last name of employees along with their department names.Ensure that you handle any potential name conflicts using aliases.
-- Explanation: When columns have the same name in both tables (like department_id,we need to use aliases to avoid ambiguity.This make it clear which table each column is coming from

SELECT e.first_name AS EmployeeFirstName, e.last_name AS EmployeeLastName,d.department_name AS DepartmentName
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

-- 1st Oct 2024 --
-- SQL Nested Queries (Subqueries) - Notes for Beginners--
-- What are Nested Queries? --
-- A nested query, also called a subquery, is an SQL query that is embedded within another SQL query. The result of the nested query is used by the outer query to complete the overall task. Subqueries are often used to return data that will be used to filter or compute in the outer query.
-- Types of Nested Queries --
-- 1.	Single-row subquery:--
-- A subquery that returns only one row as the result--
-- It is typically used with comparison operators like =, >, <, etc.--

-- Example: Find the employees whose salary is higher than the average salary.--

SELECT employee_id,first_name,last_name
FROM employees
WHERE salary>(SELECT AVG(salary) FROM employees);

-- employees  with salaries less than the average salary --
SELECT employee_id,first_name,last_name
FROM employees
WHERE salary<(SELECT AVG(salary) FROM employees);

-- employees  with salaries equal to  the average salary --
SELECT employee_id,first_name,last_name
FROM employees
WHERE salary=(SELECT AVG(salary) FROM employees); 

-- MULTIPLE ROW SUBQUERY --
-- A subquery that returns multiple rows as the result.--
-- It is typically used with operators like IN, ANY, ALL, etc.

-- Example: Find all employees who work in the same department as 'Brown'.--
SELECT employee_id, first_name, last_name, department_id
FROM employees
WHERE department_id IN (
   SELECT department_id
   FROM employees
   WHERE last_name = 'Brown'
);

-- Correlated subquery:--
-- A subquery that references columns from the outer query.The subquery is executed once for each row processed by the outer query.--
-- Example: Find employees who earn more than the average salary in their department.

SELECT first_name,last_name,salary,department_id
FROM employees e
WHERE salary=(SELECT AVG(salary)
FROM employees f
WHERE e.department_id=f.department_id);

-- 2nd Oct 2024 --
 
-- Where Can You Use Subqueries? --
-- You can use a subquery to compute a value for each row.--
 
-- 1.​In the SELECT clause:--
-- Example: Retrieve each employee's name and the average salary of their department.--
SELECT first_name, last_name,
      (SELECT AVG(salary)
       FROM employees Justo
       WHERE James.department_id = Justo.department_id) AS department_avg_salary
FROM employees James;
-- the output returns a table with all employees and their avg salary within their department --

 --  2.​In the WHERE clause:--
-- ​Subqueries can be used to filter data based on the results of another query.
-- Example: Find employees who work in departments where the average salary is higher than $5000.
SELECT  first_name,last_name
FROM employees
WHERE department_id IN (
   SELECT department_id
   FROM employees
   GROUP BY department_id
   HAVING AVG(salary) >= 5000
);
-- Assignment 5 ---
 -- 3. In the FROM clause:--
-- Subqueries in the FROM clause act like temporary tables for the main query.--
-- Example: Find the highest-paid employee in each department.--

SELECT department_id, MAX(salary)
FROM (SELECT department_id, salary FROM employees) AS dept_salaries
GROUP BY department_id;
 
-- Key Operators with Subqueries--
-- 1. IN:--
-- Used to check if a value exists in a list returned by a subquery.--
-- Example: Find employees who belong to departments that have more than 5 employees--
SELECT first_name,last_name
FROM employees
WHERE department_id IN(
SELECT department_id
FROM employees
GROUP BY department_id
HAVING COUNT(*)=5
);

-- 2. ANY/ALL:--
-- Used to compare a value to each value in a list or subquery result.--
-- ANY Example: Find employees whose salary is higher than the salary of any employee in department 10.--
SELECT first_name,last_name
FROM employees
WHERE salary > ANY(
SELECT salary
FROM  employees
WHERE department_id=10); 

-- ALL Example: Find employees whose salary is higher than all employees in department 10.--
SELECT first_name,last_name
FROM employees
WHERE salary > ALL(
  SELECT salary
  FROM employees
  WHERE department_id=10); 
  
 -- 3. EXISTS:--
-- Used to check whether a subquery returns any rows.--
-- Example: Find employees who work in departments where at least one employee has a salary over $10,000.--
SELECT first_name,last_name
FROM employees e
WHERE salary> EXISTS(
   SELECT 1
   FROM employees f
   WHERE e.department_id=f.department_id AND salary>10000);
   
   
-- Common Use Cases for Subqueries-- 
-- 1. Find records that meet complex conditions: Subqueries can be useful when the criteria for selecting data are complex and depend on the results of another query.--
-- Example: Find employees who have the second-highest salary in the company.--
SELECT first_name,last_name
FROM employees
WHERE salary =(
  SELECT MAX(salary)
  FROM employees
  WHERE salary<(SELECT MAX(salary)FROM employees)
  );


-- 3rd October 2024 --
 -- Common Table Expressions (CTEs) in SQL for Beginners--
-- What is a CTE?--
-- A Common Table Expression (CTE) is a temporary result set that you can reference within a SELECT, INSERT, UPDATE, or DELETE statement. It is defined using the WITH keyword and exists only for the duration of the query. CTEs help break down complex queries into more manageable parts and improve code readability.
WITH cte_name AS (
   -- The query for your CTE
   SELECT column1, column2
   FROM table_name
   WHERE condition
)
-- Main query that uses the CTE
SELECT *
FROM cte_name;

-- cte_name is the name you give to the CTE.--
-- The CTE is defined inside the parentheses ().--
-- After the CTE is defined, you can use it like a temporary table in the main query.--
-- Why Use a CTE?--
-- 1. Code Readability: It simplifies complex queries by breaking them into smaller, understandable parts.--
-- 2. Reusability: You can use the CTE multiple times within the same query.--
-- 3. Recursion: CTEs support recursive queries, allowing for operations like traversing hierarchical data (e.g., employee-manager relationships). --

-- example 1 --
-- This example selects employees who earn a salary greater than the average salary across all employees.
   WITH May_earners AS (
   SELECT first_name, last_name, salary
   FROM employees -- Outer Query --    -- The query for your CTE
   WHERE salary > (
       SELECT AVG(salary) FROM employees -- Inner Query , -- Main query that uses the CTE              
   )
 
)
SELECT * FROM May_earners;

--  part 2 -- count  how many employee earn above avg
-- reusing of the CTE functions--
-- use m letter as an aliases of cte first columns--

SELECT  m.first_name, m.last_name,m.salary,
-- count the no of employee earning above avg salary
(SELECT COUNT(*) FROM May_earners) AS total_above_avg;
 
-- Part 3--
-- diffrence between the highest earners salary and the average salary of the CTE--
(SELECT MAX(salary) FROM May_earners) - (SELECT AVG(salary)  FROM May_earners) AS salary_difference
FROM May_earners m;

-- 2. CTE with JOIN Example--
-- This CTE selects employee details along with their department name by joining employees and departments tables.--

select *from departments;
WITH Emp_Dep AS (
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
)
SELECT * FROM Emp_Dep;

select * from sales;
-- 3. CTE to calculate Total Sales --
--  CTE calculates the total sales for each department in the sales table and displays it with department details.
WITH Dep_sales AS (
SELECT department_id , SUM(sales) AS total_sales
FROM sales
GROUP BY department_id
)
SELECT d.department_name, ds.total_sales
FROM departments d
INNER JOIN Dep_sales ds ON d.department_id = ds.department_id;

-- 4.CTE find amployees by Department--
-- This CTE filters employees working in the "Engineering" department.--

WITH Eng_dep AS (
SELECT first_name,last_name,department_id
FROM employees
WHERE department_id = (
       SELECT department_id FROM departments WHERE department_name = 'Engineering'
   )
)
 SELECT * FROM Eng_dep;
 
 -- 5. CTE With Aggregation --
 -- This CTE calculates the average sales of employees in each department.--
 WITH AvesalesByDepartment AS (
 SELECT department_id,AVG(sales)AS avg_sales
 FROM employees
 GROUP BY department_id
 )
 SELECT d.department_name,a.avg_sales
 FROM departments d
 INNER JOIN AvesalesByDepartment a ON d.department_id=a.department_id;
 
 -- 6. Using CTE with UPDATE--
-- This CTE identifies employees with a salary below a certain threshold and increases their salary.--
WITH LowSalaryEmployees AS (
SELECT employee_id,salary
FROM employees
WHERE salary<3000
)
UPDATE employees
SET salary = salary * 1.1
WHERE employee_id IN ( SELECT employee_id FROM LowSalaryEmployees);

-- identify employees with a salary below a certain threshold and increases their salary.
-- < 2500 , 10%

WITH Threshold AS (
SELECT employee_id,salary
FROM employees
WHERE salary<2500
)
UPDATE employees
SET salary=salary * 1.1
WHERE employee_id IN (SELECT employee_id FROM Threshold);

select *from employees;

-- 7. CTE to Rank Employees by Salary --
-- This CTE assigns a rank to each employee based on their salary within the same department.--
 
WITH SalaryRanking AS (
   SELECT first_name, last_name, department_id, salary,
          RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rank
   FROM employees
)
SELECT * FROM SalaryRanking;

-- 8. CTE to Calculate Department Budget --
-- This CTE calculates the total budget for each department by summing the salaries of employees.--

WITH DepartmentBudget AS (
   SELECT department_id, SUM(salary) AS total_budget
   FROM employees
   GROUP BY department_id
)
SELECT d.department_name, db.total_budget
FROM departments d
INNER JOIN DepartmentBudget db ON d.department_id = db.department_id;

-- 9. CTE with DELETE Operation-- 
-- This CTE selects employees who have been with the company for more than 10 years and deletes them.--
WITH LongTermEmployees AS (
   SELECT employee_id
   FROM employees
   WHERE DATEDIFF(CURDATE(), hire_date) > 3650  -- Employees hired more than 10 years ago
)
DELETE FROM employees
WHERE employee_id IN (SELECT employee_id FROM LongTermEmployees);


 