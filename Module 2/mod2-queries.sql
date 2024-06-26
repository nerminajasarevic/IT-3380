/* IT 3380 */
/* Module 2 Queries */
/* Nermina Jasarevic */

/* 1. Display all of the customer data */
select * from customer;
/* 2. Display all of the agent data */
select * from agents;
/* 3. Display customer names and grades */
select CUST_NAME, GRADE from customer;
/* 4. Display agent code, name, and working area */
select AGENT_CODE, AGENT_NAME, WORKING_AREA from agents;
/* 5. Display order number, order amount, and order date */
select ORD_NUM, ORD_AMOUNT, ORD_DATE from orders;
/* 6. Show all customer code, name, country, and phone number, for all customers from the United States */
select CUST_CODE, CUST_NAME, CUST_COUNTRY, PHONE_NO from customer where CUST_COUNTRY = "USA";
/* 7. Show agent names and phone numbers for agents from Bangalore */
select AGENT_NAME, PHONE_NO from agents where WORKING_AREA = "Bangalore";
/* 8. Show orders with advance amounts of $100 */
select * from orders where ADVANCE_AMOUNT = 100;
/* 9. Show the names of grade 2 customers */
select CUST_NAME from customer where GRADE = "2";
/* 10. Show all customer information for customers from New York */
select * from customer where WORKING_AREA = "New York";
/* 11. Show all agent information for agents who work in London with commission rates greater than 0.12 */
select * from agents where WORKING_AREA = "London" and COMMISSION > 0.12;
/* 12. Show order number, agent code, and customer code for orders with advance amount less than or equal to $500, and order amount greater than or equal to $1500. */
select ORD_NUM, AGENT_CODE, CUST_CODE from orders where ADVANCE_AMOUNT <= 500 and ORD_AMOUNT >= 1500;
/* 13. Show customer code, customer name, agent code, and outstanding amount for customers with outstanding amounts greater than $6000 and pay amount less than or equal to $3000 */
select CUST_CODE, CUST_NAME, AGENT_CODE, OUTSTANDING_AMT from customer where OUTSTANDING_AMT > 6000 and PAYMENT_AMT <= 3000;
/* 14. Show order numbers for order amounts less than $1000 */
select ORD_NUM from orders where ORD_AMOUNT < 1000;
/* 15. Show customer names from India with outstanding amounts less than $10,000 */
select CUST_NAME from customer where CUST_COUNTRY = "India" and OUTSTANDING_AMT < 10000;