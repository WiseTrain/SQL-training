/*
Question 7
a. Write a script that you can use to find every column in the database that includes "rate" in the column name.

b. Write a script that you can use to find every table in the database that includes "History" in the table name.
*/

-- a. 
USE [AdventureWorks2019];
SELECT T.name, C.name 
	FROM sys.columns as C
	INNER JOIN sys.tables AS T ON 
	C.object_id = T.object_id
 WHERE C.name LIKE '%rate%';

 --b.
SELECT name FROM sys.tables
 WHERE name LIKE '%History%';

 -- ANSWER
