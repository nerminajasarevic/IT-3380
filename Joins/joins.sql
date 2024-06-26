/* Nermina Jasarevic */
/* IT 3380 */
/* Joins in MySQL */

/* 2A */

/* 1. Display the customer name, customer number, along with their sales rep’s number, first name, and last name. */
SELECT cust.customerName, cust.customerNumber, cust.salesRepEmployeeNumber, emp.firstName, emp.lastName
FROM customers cust
JOIN employees emp ON cust.salesRepEmployeeNumber = emp.employeeNumber;

SELECT cust.customerName, cust.customerNumber, cust.salesRepEmployeeNumber, emp.firstName, emp.lastName
FROM customers cust
LEFT JOIN employees emp ON cust.salesRepEmployeeNumber = emp.employeeNumber;

SELECT cust.customerName, cust.customerNumber, cust.salesRepEmployeeNumber, emp.firstName, emp.lastName
FROM customers cust
RIGHT JOIN employees emp ON cust.salesRepEmployeeNumber = emp.employeeNumber;

/* 2. Display each employee’s first and last name and their office code, city, and phone. */
SELECT emp.firstName, emp.lastName, emp.officeCode, o.city, o.phone
FROM employees emp
JOIN offices o ON emp.officeCode = o.officeCode;

SELECT emp.firstName, emp.lastName, emp.officeCode, o.city, o.phone
FROM employees emp
LEFT JOIN offices o ON emp.officeCode = o.officeCode;

SELECT emp.firstName, emp.lastName, emp.officeCode, o.city, o.phone
FROM employees emp
RIGHT JOIN offices o ON emp.officeCode = o.officeCode;

/* 3. Display the customer’s name, and number along with the order number order date, product name, quantity, and price for each of the customer’s orders. */
SELECT cust.customerName, cust.customerNumber, ord.orderNumber, ord.orderDate, prod.productName, od.quantityOrdered, od.priceEach
FROM customers cust
JOIN orders ord ON cust.customerNumber = ord.customerNumber
JOIN orderdetails od ON ord.orderNumber = od.orderNumber
JOIN products prod ON od.productCode = prod.productCode;

SELECT cust.customerName, cust.customerNumber, ord.orderNumber, ord.orderDate, prod.productName, od.quantityOrdered, od.priceEach
FROM customers cust
LEFT JOIN orders ord ON cust.customerNumber = ord.customerNumber
LEFT JOIN orderdetails od ON ord.orderNumber = od.orderNumber
LEFT JOIN products prod ON od.productCode = prod.productCode;

SELECT cust.customerName, cust.customerNumber, ord.orderNumber, ord.orderDate, prod.productName, od.quantityOrdered, od.priceEach
FROM customers cust
RIGHT JOIN orders ord ON cust.customerNumber = ord.customerNumber
RIGHT JOIN orderdetails od ON ord.orderNumber = od.orderNumber
RIGHT JOIN products prod ON od.productCode = prod.productCode;

/* 4. Display the customer name and customer number along with the payment date, check number, and amount for each payment */
SELECT cust.customerName, cust.customerNumber, pay.paymentDate, pay.checkNumber, pay.amount
FROM customers cust
JOIN payments pay ON cust.customerNumber = pay.customerNumber;

SELECT cust.customerName, cust.customerNumber, pay.paymentDate, pay.checkNumber, pay.amount
FROM customers cust
LEFT JOIN payments pay ON cust.customerNumber = pay.customerNumber;

SELECT cust.customerName, cust.customerNumber, pay.paymentDate, pay.checkNumber, pay.amount
FROM customers cust
RIGHT JOIN payments pay ON cust.customerNumber = pay.customerNumber;

/* 5. Display the product line, description, and product name for all products */
SELECT pl.productLine, prod.productDescription, prod.productName
FROM products prod
JOIN productlines pl ON prod.productLine = pl.productLine;

SELECT pl.productLine, prod.productDescription, prod.productName
FROM products prod
LEFT JOIN productlines pl ON prod.productLine = pl.productLine;

SELECT pl.productLine, prod.productDescription, prod.productName
FROM products prod
RIGHT JOIN productlines pl ON prod.productLine = pl.productLine;

/* 2B */

/* 1. Show the customer name, order number and order date only for customers who have placed orders. */
SELECT cust.customerName, ord.orderNumber, ord.orderDate
FROM customers cust
JOIN orders ord ON cust.customerNumber = ord.customerNumber;

/* 2. Show the order number, and order total for all orders. Include orders with no order details. */
SELECT ord.orderNumber, SUM(od.quantityOrdered * od.priceEach) AS "Order Total"
FROM orders ord
LEFT JOIN orderdetails od ON ord.orderNumber = od.orderNumber
GROUP BY ord.orderNumber;

/* 3. Show the employee name (first, last) and office address (address line 1, state and country) for all employees. */
SELECT emp.firstName, emp.lastName, o.addressLine1, o.state, o.country
FROM employees emp
JOIN offices o ON emp.officeCode = o.officeCode;

/* 4. Show the customer, number, payment date, check number, and amount for each payment. Include customers who have not made any payments. */
SELECT cust.customerName, cust.customerNumber, pay.paymentDate, pay.checkNumber, pay.amount
FROM customers cust
LEFT JOIN payments pay ON cust.customerNumber = pay.customerNumber;

/* 5. Show the employee name, customer name and the total sales for that customer. The results should include employees even if they have do not have customers. */
SELECT emp.firstName, emp.lastName, cust.customerName, SUM(od.quantityOrdered * od.priceEach) AS "Total Sales"
FROM employees emp
LEFT JOIN customers cust ON emp.employeeNumber = cust.salesRepEmployeeNumber
LEFT JOIN orders ord ON cust.customerNumber = ord.customerNumber
LEFT JOIN orderdetails od ON ord.orderNumber = od.orderNumber
GROUP BY emp.firstName, emp.lastName, cust.customerName;