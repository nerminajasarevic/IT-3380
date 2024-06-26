/* Nermina Jasarevic */
/* IT 3380 */
/* Midterm SQL Queries */

/* 1. What are the top 15 books ordered in 2022. Show the book title and number ordered in a column called "Number of Books Ordered" in descending order. */
SELECT b.title, COUNT(*) AS "Number of Books Ordered"
FROM book b, cust_order co, order_line ol
WHERE co.order_id = ol.order_id AND YEAR(co.order_date) = 2022 AND b.book_id = ol.book_id
GROUP BY b.title
ORDER BY COUNT(*) DESC
LIMIT 15;

/* 2. How many books are there in each languages in the database? Display the language and the number of books in a column called "Number of Books" in descending order. */
SELECT bl.language_name, COUNT(b.book_id) AS "Number of Books"
FROM book b, book_language bl
WHERE b.language_id = bl.language_id
GROUP BY bl.language_name
ORDER BY COUNT(b.book_id) DESC;

/* 3. List the top 20 top customers who ordered the highest dollar amount of books. Show the customer first, last name and order amount in a column called "Total orders" in descending order. */
SELECT c.first_name, c.last_name, SUM(ol.price) AS "Total Orders"
FROM customer c, cust_order co, order_line ol
WHERE c.customer_id = co.customer_id AND co.order_id = ol.order_id
GROUP BY c.customer_id
ORDER BY SUM(ol.price) DESC
LIMIT 20;

/* 4. Calculate the dollar amount in orders by country. Display the country name and the order amount in a column called "Total Orders" in descending order. 107 results */
SELECT c.country_name AS "Country Name", SUM(ol.price) AS "Total Orders"
FROM country c, address a, customer_address ca, cust_order co, order_line ol
WHERE c.country_id = a.country_id AND a.address_id = ca.address_id AND ca.customer_id = co.customer_id AND co.order_id = ol.order_id
GROUP BY c.country_name
ORDER BY SUM(ol.price) DESC;

/* 5. Calculate the total order amount, including the shipping cost for each month of each year in the database. The total will include book price and shipping cost. Display the results in columns called "Year", "Month" and "Total Orders w/Shipping". Display in ascending order by year and month. Hint: you will need to group by multiple columns */
SELECT YEAR(co.order_date) AS "Year", MONTH(co.order_date) AS "Month", SUM(ol.price + sm.cost) AS "Total Orders w/Shipping"
FROM cust_order co, order_line ol, shipping_method sm
WHERE co.order_id = ol.order_id AND co.shipping_method_id = sm.method_id
GROUP BY YEAR(co.order_date), MONTH(co.order_date)
ORDER BY YEAR(co.order_date), MONTH(co.order_date);

/* 6. How many customers are there from each country in the database? Display the results in a column for country and "Total Customers". Display results in descending order by Total Customers. 109 results. */
SELECT cty.country_name AS "Country Name", COUNT(c.customer_id) AS "Total Customers"
FROM country cty, customer c, customer_address ca, address a
WHERE cty.country_id = a.country_id AND a.address_id = ca.address_id AND ca.customer_id = c.customer_id
GROUP BY cty.country_name
ORDER BY COUNT(c.customer_id) DESC;

/* 7. How many authors have published with each publisher? Show the top 20. List the publisher name and the number of authors in a column called "Number of Authors". */
SELECT p.publisher_name, COUNT(ba.author_id) AS "Number of Authors"
FROM publisher p, book b, book_author ba
WHERE p.publisher_id = b.publisher_id AND b.book_id = ba.book_id
GROUP BY p.publisher_name
ORDER BY COUNT(ba.author_id) DESC
LIMIT 20;

/* 8. Whats the average order per country in 2022? Display the Country name and average order in a column called "Average Order" rounded to 2 decimal places. Display results in descending order by average order. 94 results */
SELECT cty.country_name AS "country_name", ROUND(SUM(ol.price) / COUNT(co.order_id), 2) AS "Average Order"
FROM country cty, cust_order co, order_line ol
WHERE cty.country_id = co.dest_address_id AND co.order_id = ol.order_id AND YEAR(co.order_date) = 2022
GROUP BY cty.country_name
ORDER BY ROUND(SUM(ol.price) / COUNT(co.order_id), 2) DESC;
