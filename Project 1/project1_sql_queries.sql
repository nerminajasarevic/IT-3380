/* Nermina Jasarevic */
/* IT 3380 */
/* Project 1 SQL Queries */

/* 1. How many universities in each country? Display the country name and number of universities in a column named "Number of Universities". Display results in descending order based on the number of universities. (74 rows returned). The results show the first 10 rows and last 10 rows of the results. */
SELECT c.country_name, COUNT(u.id) AS "Number of Universities"
FROM country c
LEFT JOIN university u ON c.id = u.country_id
GROUP BY c.country_name
ORDER BY COUNT(u.id) DESC;

/* 2. List all of the current universities in the database. List the university name and country. (1247 rows returned) */
SELECT u.university_name, c.country_name
FROM university u
JOIN country c ON u.country_id = c.id;

/* 3. Show the average university student enrollment for each country in the database in 2015. Display the country and average enrollment in a column named "Average enrollment". Round to 0 decimal places and order by the average number of students. */
SELECT c.country_name, ROUND(AVG(uy.num_students), 0) AS "Average enrollment"
FROM university_year uy
JOIN university u ON uy.university_id = u.id
JOIN country c ON u.country_id = c.id
WHERE uy.year = 2015
GROUP BY c.country_name
ORDER BY ROUND(AVG(uy.num_students), 0) DESC;

/* 4. How many ranking criteria does each ranking system have? Display the ranking system name and number of criteria in a column named "Total Criteria". Display in descending order by total criteria. */
SELECT rs.system_name, COUNT(rc.id) AS "Total Criteria"
FROM ranking_system rs
LEFT JOIN ranking_criteria rc ON rs.id = rc.ranking_system_id
GROUP BY rs.system_name
ORDER BY COUNT(rc.id) DESC; 

/* 5. Show the average score for each ranking criteria in the year 2014. Display the system name, criteria name and average score in a column named average score. Round the average scores to 2 decimal places. Display results in descending order by ranking system name. */
SELECT rs.system_name, rc.criteria_name, ROUND(AVG(ur.score), 2) AS "Average Score"
FROM university_ranking_year ur
JOIN ranking_criteria rc ON ur.ranking_criteria_id = rc.id
JOIN ranking_system rs ON rc.ranking_system_id = rs.id
WHERE ur.year = 2014
GROUP BY rs.system_name, rc.criteria_name
ORDER BY rs.system_name;

/* 6. Show the top 25 universities with the highest alumni employment rank in 2015. Display in Descending order. */
SELECT u.university_name, rc.criteria_name AS "criteria_name", ur.score AS "score"
FROM university_ranking_year ur
JOIN ranking_criteria rc ON ur.ranking_criteria_id = rc.id
JOIN university u ON ur.university_id = u.id
WHERE ur.year = 2015 AND rc.criteria_name = 'Alumni Employment Rank'
ORDER BY ur.score DESC
LIMIT 25;

/* 7. Show the number of international students at each United States universities in 2013. Show the University name and the number of students in a column called "Total Internalional Students". Display in descending order by total students. You can calculate the number of international students by (pct_international_students * 0.01) * num students. (75 rows returned). The results below show the first 10 rows and the last 10 rows. */
SELECT u.university_name, ROUND((uy.pct_international_students * 0.01) * uy.num_students, 0) AS "Total International Students"
FROM university_year uy
JOIN university u ON uy.university_id = u.id
JOIN country c ON u.country_id = c.id
WHERE c.country_name = 'United States of America' AND uy.year = 2013
ORDER BY ROUND((uy.pct_international_students * 0.01) * uy.num_students, 0) DESC;


/* 8. Show the number of students in each country in 2016. Display the contry name and number of students in a column called "Total Students" ordered by the number of students in descending order. */
SELECT c.country_name, SUM(uy.num_students) AS "Total Students"
FROM university_year uy
JOIN university u ON uy.university_id = u.id
JOIN country c ON u.country_id = c.id
WHERE uy.year = 2016
GROUP BY c.country_name
ORDER BY SUM(uy.num_students) DESC;
