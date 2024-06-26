/* IT 3380 */
/* Module 3 Queries */
/* Nermina Jasarevic */


/* 1. Display the customer name and all of their agent’s information. */
SELECT c.CUST_NAME, a.* FROM customer c, agents a WHERE c.AGENT_CODE = a.AGENT_CODE;
/* 2. For each order, display order number, order date, customer name and agent name. */
SELECT o.ORD_NUM, o.ORD_DATE, c.CUST_NAME, a.AGENT_NAME FROM orders o, customer c, agents a WHERE o.CUST_CODE = c.CUST_CODE AND o.AGENT_CODE = a.AGENT_CODE;
/* 3. Display agent name, customer name, order date, and order amount for customers from Canada. */
SELECT a.AGENT_NAME, c.CUST_NAME, o.ORD_DATE, o.ORD_AMOUNT FROM agents a, customer c, orders o WHERE a.AGENT_CODE = o.AGENT_CODE AND c.CUST_CODE = o.CUST_CODE AND c.CUST_COUNTRY = "Canada";
/* 4. Display customer name, order number, and order amount for customers in New York city. */
SELECT c.CUST_NAME, o.ORD_NUM, o.ORD_AMOUNT from customer c, orders o WHERE c.CUST_CODE = o.CUST_CODE and c.CUST_CITY = "New York";
/* 5. Display agent name, customer name, order number and order amount for orders of more than $1,500. */
SELECT a.AGENT_NAME, c.CUST_NAME, o.ORD_NUM, o.ORD_AMOUNT from agents a, customer c, orders o WHERE a.AGENT_CODE = o.AGENT_CODE AND c.CUST_CODE = o.CUST_CODE AND ORD_AMOUNT > 1500;
/* 6. Display all agent and orders information. */
SELECT agents.*, orders.* FROM agents, orders;
/* 7. Display customer name, customer code, outstanding amount, and agent name for customers with outstanding amounts greater than or equal to $6,000. */
SELECT c.CUST_NAME, c.CUST_CODE, c.OUTSTANDING_AMT, a.AGENT_NAME from customer c, agents a WHERE c.AGENT_CODE = a.AGENT_CODE AND c.OUTSTANDING_AMT >= 6000;
/* 8. Display customer name, order number, order amount, and advance amount if order amount is greater than or equal to $2,500 or advance amount is less than $300. */
SELECT c.CUST_NAME, o.ORD_NUM, o.ORD_AMOUNT, o.ADVANCE_AMOUNT from customer c, orders o WHERE c.CUST_CODE = o.CUST_CODE AND o.ORD_AMOUNT >= 2500 OR o.ADVANCE_AMOUNT < 300;
/* 9. Display agent name, agent working area, customer name, customer working area for customers and agents who have the same working area. */
SELECT a.AGENT_NAME, a.WORKING_AREA, c.CUST_NAME, c.WORKING_AREA from agents a, customer c WHERE a.AGENT_CODE = c.AGENT_CODE AND a.WORKING_AREA = c.WORKING_AREA;
/* 10. Display customer name, agent name, and order number where order amount is less than $1,000 or opening amount is greater than $8000. */
SELECT c.CUST_NAME, a.AGENT_NAME, o.ORD_NUM from customer c, agents a, orders o WHERE c.CUST_CODE = o.CUST_CODE AND a.AGENT_CODE = o.AGENT_CODE AND o.ORD_AMOUNT < 1000 OR c.OPENING_AMT > 8000;