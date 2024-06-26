--SELECT QUERIES

--1. Write a query to calculate the payments each sales agent is responsible for. 
--Display the agent name and the total payments
SELECT a.AGENT_NAME, SUM(c.PAYMENT_AMT) AS "Total Payments"
FROM customer c, agents a
WHERE a.AGENT_CODE = c.AGENT_CODE
GROUP BY c.AGENT_CODE;

--2. Write a query to calculate payments for each sales agent by country of the sales agent. 
--Display the agent country and total payments.
SELECT c.CUST_COUNTRY, SUM(c.PAYMENT_AMT) AS "Total Payments"
FROM customer c, agents a
WHERE a.AGENT_CODE = c.AGENT_CODE
GROUP BY c.CUST_COUNTRY;

SELECT CUST_COUNTRY, SUM(PAYMENT_AMT)
FROM customer
GROUP BY CUST_COUNTRY
ORDER BY SUM(PAYMENT_AMT) DESC;

--3. 
SELECT o.ORD_NUM, c. CUST_NAME, a.AGENT_NAME, (o.ORD_AMOUNT * a.COMMISSION) AS "Commission"
FROM customer c, agents a, orders o
WHERE a.AGENT_CODE = o.AGENT_CODE AND o.CUST_CODE = c.CUST_CODE;

--UPDATE QUERIES

--1. In the customers table, for customers from New York update the CUST_CITY value to 
--change it from “New York” to “NY”. 

UPDATE customer
SET CUST_CITY = "NY"
WHERE CUST_CITY = "New York";

-- A. Now write an query to select all customers from New York City.
SELECT * 
FROM customer
WHERE CUST_CITY = "NY";

--2. Increase the commission for sales agents from London by 20%. 
UPDATE agents
SET COMMISSION = COMMISSION * 1.2
WHERE WORKING_AREA = "London";


--B. Calculate the commission for each order where the agent is from London. 
--Display order id, customer name, agent name, and commission amount.
SELECT o.ORD_NUM, c. CUST_NAME, a.AGENT_NAME, (o.ORD_AMOUNT * a.COMMISSION) AS "Commission"
FROM customer c, agents a, orders o
WHERE a.AGENT_CODE = o.AGENT_CODE AND o.CUST_CODE = c.CUST_CODE AND a.WORKING_AREA = "London";

--3.Update customers with grade 2 to grade 3.
UPDATE customer
SET GRADE = 3
WHERE GRADE = 2;

--C. Select all customers names and customer codes with grade 3.
SELECT * FROM customer WHERE GRADE = 3;

--DELETE QUERIES

--1.Delete sales agents from Bangalore.
DELETE FROM agents
WHERE WORKING_AREA = "Bangalore";

--E. Write a query to select all columns for all sales agents
SELECT * FROM agents;

--2. Delete customers whose name begins with the letter “S”.
DELETE FROM customer
WHERE CUST_NAME LIKE 'S%';

--F. Select all columns for all customers.
SELECT * FROM customer;


