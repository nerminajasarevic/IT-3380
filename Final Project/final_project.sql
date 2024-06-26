/* Nermina Jasarevic */
/* IT 3380 */
/* Final Project */

/* 1. Write a query to create a view named “EmployeesPerCountry” that shows the country_name and the number of employees from that country in a column called “Number of Employees”. Display your results in descending order of number of employees. */
CREATE VIEW EmployeesPerCountry AS
SELECT c.country_name, COUNT(e.employee_id) AS "Number of Employees"
FROM countries c, locations l, departments d, employees e
WHERE e.department_id = d.department_id AND d.location_id = l.location_id AND l.country_id = c.country_id
GROUP BY c.country_name
ORDER BY COUNT(e.employee_id) DESC;

/* A. Query the EmployeesPerCountry to show the number of employees from the United Kingdom. */
SELECT * FROM EmployeesPerCountry WHERE country_name = "United Kingdom" GROUP BY country_name;

/* 2. Write a query to create a view named “managers” to display all the managers. Include the manager’s name (first, last), phone number, email, job title, and department name. */
CREATE VIEW managers AS
SELECT e.first_name, e.last_name, e.phone_number, e.email, j.job_title, d.department_name
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id AND e.job_id = j.job_id AND e.employee_Id 
IN (SELECT manager_id FROM employees GROUP BY manager_id);

/* B. Query the managers view to show the number of managers in each department. */
SELECT department_name, COUNT(*) AS 'Number of Managers'
FROM managers
GROUP BY department_name
ORDER BY COUNT(*) DESC;

/* 3. Write a query to create a view named DependentsByJobTitle to get a count of how many dependents there are for each job title. Show job titles even if they do not have dependents. Place the number of dependents in a column called "Number of Dependents". HINT: Remember directional Joins (LEFT & RIGHT), you will have to use one of those. */
CREATE VIEW DependentsByJobTitle AS
SELECT j.job_title, COUNT(d.dependent_id) AS NumberOfDependents
FROM jobs j
LEFT JOIN employees e ON j.job_id = e.job_id
LEFT JOIN dependents d ON e.employee_id = d.employee_id
GROUP BY j.job_title;

/* C. Query the DependentsByJobTitle view to show the job titles(s) with the largest number of dependents. This should show the job title and the number of dependents. HINT: Think about using a nested query for this because there are multiple job titles with the max number of dependents. */
SELECT job_title, NumberOfDependents
FROM DependentsByJobTitle
WHERE NumberOfDependents = (SELECT MAX(NumberOfDependents)FROM DependentsByJobTitle);

/* 4. Write a query to create a view named DepartmentHiresByYear that calculates the number of employees hired each year in each department, Order results by department name. HINT: Remember the SQL $year function, and you will have to group by two columns (year and department name). You separate the column names by a comma in the GROUP BY clause. */
CREATE VIEW DepartmentHiresByYear AS
SELECT YEAR(e.hire_date) AS "Year", d.department_name, COUNT(e.employee_id) AS "Employees Hired"
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY YEAR(e.hire_date), d.department_name
ORDER BY d.department_name, YEAR(e.hire_date);

/* D. Query the DepartmentHiresByYear view to show department hires in 1998. */
SELECT * FROM DepartmentHiresByYear WHERE Year = 1998;

/* 5. Write a query to create a view named “AvgSalaryByJobTitle” to calculate the average salary for each job title. Display the job title, average salary in a column named "Average salary", and number of employees with that title in a column called "Number of Employees". Display results in descending order by average salary. HINT: You can use both the AVG() and COUNT() functions in the Select clause of your query. */
CREATE VIEW AvgSalaryByJobTitle AS
SELECT j.job_title, AVG(e.salary) AS AverageSalary, COUNT(e.employee_id) AS NumberofEmployees
FROM employees e
JOIN jobs j ON j.job_id = e.job_id
GROUP BY j.job_title
ORDER BY AverageSalary DESC;

/* E. Query the AvgSalaryByJobTitle view to show the average salary for the Programmers. */
SELECT job_title, AverageSalary, NumberofEmployees
FROM AvgSalaryByJobTitle
WHERE job_title = 'Programmer';

/* 6. Write a query to create a view named “AvgSalaryByDepartment” to calculate average salaries for each department. Display the department name, average salary in a column named "Average salary", and number of employees with that title in a column called "Number of Employees" */
CREATE VIEW AvgSalaryByDepartment AS
SELECT d.department_name, AVG(e.salary) AS AverageSalary, COUNT(e.employee_id) AS NumberofEmployees
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
ORDER BY AverageSalary DESC;

/* F. Query the AvgSalaryByDepartment view to show the department name and average salary for the department with the lowest average salary. */
SELECT department_name, AverageSalary, NumberofEmployees
FROM AvgSalaryByDepartment
WHERE AverageSalary = (
    SELECT MIN(AverageSalary)
    FROM AvgSalaryByDepartment
);

/* 7. Write a query to create a view named “EmployeeDependents” that calculates the number of dependents each employees has. This query should show employees even if they have 0 dependents. Display the employee name (first, last), email, phone number, and number of dependents. Hint: You will have to use left or right join. */
CREATE VIEW EmployeeDependents AS
SELECT e.first_name, e.last_name, e.email, e.phone_number, COUNT(d.dependent_id) AS NumberOfDependents
FROM employees e
LEFT JOIN dependents d ON d.employee_id = e.employee_id
GROUP BY e.employee_id;

/* G. Query the EmployeeDependents view to show employees with no children". Show employee name (first, last), email, phone number, and number of dependents. */
SELECT * FROM EmployeeDependents WHERE NumberOfDependents = 0;

/* 8. Write a query to create a view named “CountryLocation” that calculates the number of locations in each region. This query should show regions even if they have 0 locations. Display the region name and number of locations in descending order by number of locations. HINT: Remember directional Joins (LEFT & RIGHT), you will have to use one of those. */
CREATE VIEW CountryLocation AS
SELECT r.region_name, COUNT(l.location_id) AS NumberOfLocations
FROM regions r
LEFT JOIN countries c ON r.region_id = c.region_id
LEFT JOIN locations l ON c.country_id = l.country_id
GROUP BY r.region_name
ORDER BY NumberOfLocations DESC;

/* H. Query the LocationByRegion view to show regions with no locations". Show region name and number of locations. */ 
SELECT * FROM CountryLocation WHERE NumberOfLocations = 0;