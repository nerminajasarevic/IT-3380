/* Nermina Jasarevic */
/* IT 3380 */
/* Subqueries & Wildcards in MySQL */

/* SUBQUERIES */

/* 1. Write a query to show the customer number, name, payment date, and payment amount for payments greater than the average payment. (134 rows returned) */
SELECT cust.customerNumber, cust.customerName, pay.paymentDate, AVG(pay.amount)
FROM customers cust, payments pay
WHERE cust.customerNumber = pay.customerNumber
GROUP BY pay.paymentDate, cust.customerNumber
HAVING AVG(pay.amount) > (SELECT AVG(pay.amount)FROM payments pay);

/* 2. Create a query to generate a list of managers. Show their employee number, first name, and last name. */
SELECT employeeNumber, firstName, lastName
FROM employees
WHERE employeeNumber IN (SELECT reportsTo FROM employees);

/* 3. Which offices have the same number of employees as the London office? Show the city, office code and number of employees. */
SELECT emp.officeCode, o.city, COUNT(emp.employeeNumber) AS "Number of Employees"
FROM employees emp, offices o
WHERE emp.officeCode = o.officeCode
GROUP BY emp.officeCode
HAVING COUNT(emp.employeeNumber) = (SELECT COUNT(emp.employeeNumber) FROM employees emp, offices o WHERE o.city = "London" AND  emp.officeCode = o.officeCode);

/* 4. Which product(s) have a higher quantity ordered than “1940s Ford truck”? Show the product names and quantity ordered. */
SELECT prod.productName, SUM(od.quantityOrdered) AS "Quantity Ordered"
FROM orderdetails od, products prod
WHERE od.productCode = prod.productCode
GROUP BY productName
HAVING SUM(od.quantityOrdered) > (SELECT SUM(od.quantityOrdered) FROM orderdetails od, products prod WHERE prod.productName = '1940s Ford truck' AND od.productCode = prod.productCode)
ORDER BY SUM(od.quantityOrdered) DESC;

/* 5. Show the products that have a lower dollar value in orders than the “1957 Corvette Convertible”. Show the product name and total value. (23 rows) */
SELECT prod.productName, SUM(quantityOrdered*priceEach) AS "Total Value"
FROM products prod, orderdetails od, orders ord
WHERE od.orderNumber = ord.orderNumber
GROUP BY prod.productName
HAVING SUM(quantityOrdered * priceEach) < (SELECT SUM(quantityOrdered * priceEach) FROM products WHERE productName = "1957 Corvette Convertible");

/* 6. Show the order number, customer number, and order total for orders with a larger order total than order number 10222. */
SELECT od.orderNumber, ord.customerNumber, SUM(quantityOrdered*priceEach) AS "Order Total"
FROM orderdetails od, orders ord
WHERE od.orderNumber = ord.orderNumber
GROUP BY od.orderNumber
HAVING SUM(quantityOrdered*priceEach) > (SELECT SUM(quantityOrdered*priceEach) FROM orderdetails od WHERE orderNumber = 10222)
ORDER BY SUM(quantityOrdered*priceEach) DESC;

/* WILDCARDS */

/* 1. Show the customer name and total payments for companies whose name ends in “Ltd”. */
SELECT cust.customerName, SUM(pay.amount) AS "Total Payments" 
FROM customers cust, payments pay
WHERE cust.customerName LIKE '%Ltd'
AND cust.customerNumber = pay.customerNumber
GROUP BY cust.customerName;

/* 2. How many employees have a three digit extension? A three digit extension looks like xXXX. */
SELECT COUNT(extension) AS 'numEmployees'
FROM employees
WHERE extension LIKE 'x___';

/* 3. Show the product code, name, vendor, and buy price for products from the 1950s (1950 - 1959). The year appears is in the name. */
SELECT productCode, productName, productVendor, buyPrice
FROM products
WHERE productName LIKE '%195_%';

/* 4. Show all office information for offices in the 212 area code. Hint. Look at the phone number. (1 row returned) */
SELECT *
FROM offices
WHERE phone LIKE '%212%';

/* 5. Show first name, last name, employee number and email for the sales managers. */
SELECT firstName, lastName, employeeNumber, jobTitle, email
FROM employees
WHERE jobTitle LIKE '%Manager%';

/* 6. Show the name, product code, quantity in stock, and buy price for products with “Chevy” in the name. */
SELECT productName, productCode, quantityInStock, buyPrice
FROM products
WHERE productName LIKE '%Chevy%';