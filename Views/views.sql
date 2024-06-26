/* Nermina Jasarevic */
/* IT 3380 */
/* Views in MySQL */

/* 1. Write a query to create a view named "SFEmployees" for those salespeople who work in the San Francisco office. Include the employee name (first, last), number, email, and job title. */
CREATE VIEW SFEmployees AS SELECT emp.firstName, emp.lastName, emp.employeeNumber, emp.email, emp.jobTitle
FROM employees emp
INNER JOIN offices o ON emp.officeCode = o.officeCode
WHERE o.city = 'San Francisco';

/* 1. Query the SFEmployees view to count the number of employees in the San Francisco office. */
SELECT COUNT(*) AS NumberOfEmployees FROM SFEmployees; 

/* 2. Write a query to create a view named "managers" to display all the managers. Include the manager’s name (first, last), number, email,  job title, and office city. */
CREATE VIEW managers AS SELECT emp.firstName, emp.lastName, emp.employeeNumber, emp.email, emp.jobTitle, o.city
FROM employees emp
INNER JOIN offices o ON emp.officeCode = o.officeCode
WHERE emp.jobTitle LIKE '%Manager%';

/* 2. Query the managers view to show the number of managers in each city. */
SELECT city, COUNT(*) AS NumberOfManagers FROM managers GROUP BY city;

/* 3. Write a query to create a view named "custByCity" to get a count of how many customers there are in each city. */
CREATE VIEW custByCity AS SELECT cust.city, COUNT(cust.customerNumber) AS NumberOfCustomers
FROM customers cust
GROUP BY cust.city;

/* 3. Query the custByCity view to show the number of customers in Singapore. */
SELECT city, NumberOfCustomers FROM custByCity WHERE city = 'Singapore';

/* 4. Write a query to create a view named "paymentsByMonth" that calculates payments per month. You will have to group by multiple columns for this query: month and year because payments from January 2004 and January 2005 should not be grouped together. Remember the SQL month() and year() functions. */
CREATE VIEW paymentsByMonth AS SELECT month(pay.paymentDate) AS Month, year(pay.paymentDate) AS Year, SUM(pay.amount) AS Payments
FROM payments pay
GROUP BY month(pay.paymentDate), year(pay.paymentDate);

/* 4. Query the paymentsByMonth view to show payments in November 2004 */
SELECT * FROM paymentsByMonth WHERE Month = 11 AND Year = 2004;

/* 5. Write a query to create a view named "orderTotalsByMonth" to calculate order totals (in dollars) per month. */
CREATE VIEW orderTotalsByMonth AS SELECT month(ord.orderDate) AS Month, year(ord.orderDate) AS Year, SUM(od.quantityOrdered * od.priceEach) AS orderTotals
FROM orders ord
INNER JOIN orderdetails od ON ord.orderNumber = od.orderNumber
GROUP BY month(ord.orderDate), year(ord.orderDate);

/* 5. Query the orderTotalsByMonth view to show the order total in August 2004. */
SELECT * FROM orderTotalsByMonth WHERE Month = 8 AND Year = 2004;

/* 6. Write a query to create a view named "salesPerLine" that calculates sales per product line. */
CREATE VIEW salesPerLine AS SELECT pl.productLine, SUM(od.quantityOrdered * od.priceEach) AS SalesTotal
FROM products prod
INNER JOIN productlines pl ON prod.productLine = pl.productLine
INNER JOIN orderdetails od ON prod.productCode = od.productCode
GROUP BY pl.productLine;    

/* 6. Query the salesPerLine view to show the total sales for the "Classic Cars" line. */
SELECT * FROM salesPerLine WHERE productLine = 'Classic Cars';

/* 7. Write a query to create a view named "productSalesYear" that calculates sales per product per year. Include the product name, sales total, and year. */
CREATE VIEW productSalesYear AS SELECT prod.productName, SUM(od.quantityOrdered * od.priceEach) AS SalesTotal, year(ord.orderDate) AS Year
FROM products prod
INNER JOIN orderdetails od ON prod.productCode = od.productCode
INNER JOIN orders ord ON od.orderNumber = ord.orderNumber
GROUP BY prod.productName, year(ord.orderDate);

/* 7. Query the productSalesYear view to show the sales per year for the "2001 Ferrari Enzo" in 2004. */
SELECT * FROM productSalesYear WHERE productName = '2001 Ferrari Enzo' AND Year = 2004;

/* 8. Write a query to create a view named "orderTotals" that displays the order total for each order. Include order number, customer name, and total. */
CREATE VIEW orderTotals AS SELECT ord.orderNumber, cust.customerName, SUM(od.quantityOrdered * od.priceEach) AS OrderTotal
FROM orders ord
INNER JOIN customers cust ON ord.customerNumber = cust.customerNumber
INNER JOIN orderdetails od ON ord.orderNumber = od.orderNumber
GROUP BY ord.orderNumber;

/* 8. Query the orderTotals view to select the top 15 orders. */
SELECT * FROM orderTotals ORDER BY OrderTotal DESC LIMIT 15;

/* 9. Write a query to create a view named "salesPerRep" that calculates total sales for each sales rep. */
CREATE VIEW salesPerRep AS SELECT emp.firstName, emp.lastName, SUM(od.quantityOrdered * od.priceEach) AS TotalSales
FROM employees emp
INNER JOIN customers cust ON cust.salesRepEmployeeNumber = emp.employeeNumber
INNER JOIN orders ord ON ord.customerNumber = cust.customerNumber
INNER JOIN orderdetails od ON ord.orderNumber = od.orderNumber
GROUP BY emp.firstName, emp.lastName;

/* 9. Test Query: Shows sales reps by highest to lowest total sales*/
SELECT * FROM salesPerRep ORDER BY TotalSales DESC;

/* 10. Write a query to create a view named "salesPerOffice" that displays sales per office. */
CREATE VIEW salesPerOffice AS SELECT o.city, SUM(od.quantityOrdered * od.priceEach) AS TotalSales
FROM offices o
INNER JOIN employees emp ON emp.officeCode = o.officeCode
INNER JOIN customers cust ON cust.salesRepEmployeeNumber = emp.employeeNumber
INNER JOIN orders ord ON ord.customerNumber = cust.customerNumber
INNER JOIN orderdetails od ON ord.orderNumber = od.orderNumber
GROUP BY o.city;

/* 10. Test Query: Shows offices by highest to lowest total sales*/
SELECT * FROM salesPerOffice ORDER BY TotalSales DESC;