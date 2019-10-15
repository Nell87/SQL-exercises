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

# 14. Select the names of departments with more than two employees (assuming that all departments have different names)
SELECT COUNT(E.department) AS total_number, E.Department, D.Name
FROM employees E
INNER JOIN departments D 
	ON E.Department = D.Code
GROUP BY E.Department
HAVING total_number >2;

# 15. Select the name and last name of employees working for departments with second lowest budget.
SELECT E.Name, E.LastName, E.Department, D.Code, D.Budget
FROM employees E
INNER JOIN departments D
	ON E.Department = D.Code
WHERE Budget = (SELECT Budget FROM departments 
				ORDER BY Budget ASC LIMIT 1 OFFSET 1);

# 16. Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. 
# Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
INSERT INTO departments(Code, Name, Budget)
VALUES(11, "Quality Assurance", 40000);

INSERT INTO employees(SSN, Name, LastName, Department)
VALUES("847219811", "Mary", "Moore", 11);

# 17. Reduce the budget of all departments by 10%.
UPDATE departments
SET Budget = Budget *0.9;

# 18. Reassign all employees from the Research department (code 77) to the IT department (code 14).
UPDATE employees
SET department = 14
WHERE department = 77;

# 19. Delete from the table all employees in the IT department (code 14).
DELETE FROM employees
WHERE department=14;

# 20. Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
DELETE FROM employees
WHERE Department IN (
					SELECT Code FROM departments 
                    WHERE Budget>=60000
					);

# 21. Delete from the table all employees.
DELETE FROM employees;
