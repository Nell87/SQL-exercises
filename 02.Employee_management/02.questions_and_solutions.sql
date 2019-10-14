# 1. Select the last name of all employees.
SELECT LastName
FROM employees;

# 2. Select the last name of all employees, without duplicates.
SELECT DISTINCT LastName
FROM employees;

# 3. Select all the data of employees whose last name is "Smith".
SELECT *
FROM employees
WHERE LastName = "Smith";

# 4. Select all the data of employees whose last name is "Smith" or "Doe".
SELECT *
FROM employees
WHERE LastName = "Smith" OR LastName ="Doe";

# 5. Select all the data of employees that work in department 14.
SELECT *
FROM employees
WHERE Department = 14;

# 6. Select all the data of employees that work in department 37 or department 77.
SELECT *
FROM employees
WHERE Department = 14 OR Department = 77;

# 7. Select all the data of employees whose last name begins with an "S".
SELECT *
FROM employees
WHERE LastName LIKE "S%";

# 8. Select the sum of all the departments' budgets.
SELECT SUM(Budget) AS sum_budget
FROM departments;

# 9. Select the number of employees in each department (you only need to show the department code and the number of employees).
SELECT E.department, COUNT(*) AS employees
FROM employees E
GROUP BY E.department;

# 10. Select all the data of employees, including each employee's department's data.
SELECT *
FROM employees E
INNER JOIN departments D
	ON E.Department = D.Code;
    
# 11. Select the name and last name of each employee, along with the name and budget of the employee's department.
SELECT E.Name, E.LastName, D.Name, D.Budget
FROM employees E
INNER JOIN departments D
	ON E.Department = D.Code;

# 12. Select the name and last name of employees working for departments with a budget greater than $60,000.
SELECT E.Name, E.LastName, Budget
FROM employees E
INNER JOIN departments D
	ON E.Department = D.Code
WHERE Budget > 60000;

# 13. Select the departments with a budget larger than the average budget of all the departments.
SELECT DISTINCT *
FROM departments D
INNER JOIN employees E
	ON E.Department = D.Code
 WHERE Budget > (SELECT AVG(Budget) FROM departments);   
