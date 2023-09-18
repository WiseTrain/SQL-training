/*
Question 10
One of the most convenient things about the AdventureWorks database is the column "value" (definitions) found in table below.

Select * From sys.extended_properties

a. Write a script that will give you the TableName, ColumnName and each value (definition) where class = 1

b. What is the find the value (definition) for every Column in the Person table
*/

USE [AdventureWorks2019];
--SELECT type_desc, COUNT(*) FROM sys.all_objects
--GROUP BY type_desc;
-- SELECT * from sys.columns;
-- SELECT * FROM sys.extended_properties;

-- a.
-- ONLY COLUMNS
--SELECT  
--	T.name AS 'Table_name',
--	CASE WHEN EP.minor_id > 0 THEN C.name ELSE ''
--	END as 'Column_name',
--	EP.value AS 'Definition'
--	FROM sys.extended_properties AS EP 
--		INNER JOIN sys.columns AS C ON EP.major_id = C.object_id AND EP.minor_id = C.column_id
--		INNER JOIN sys.tables AS T ON EP.major_id = T.object_id
--	WHERE class = 1 ;

SELECT  
	T.name AS 'Table_name',
	CASE WHEN EP.minor_id > 0 THEN C.name ELSE ''
	END as 'Column_name',
	EP.value AS 'Definition'
	FROM sys.extended_properties AS EP 
		LEFT JOIN sys.columns AS C ON (EP.major_id = C.object_id AND EP.minor_id = C.column_id AND EP.minor_id > 0) 
		INNER JOIN sys.tables AS T ON EP.major_id = T.object_id
	WHERE class = 1 ;

-- ONLY TABLES
--SELECT  
--	T.name AS 'Table_name',
--	CASE WHEN EP.minor_id > 0 THEN C.name ELSE ''
--	END as 'Column_name',
--	EP.value AS 'Definition'
--	FROM sys.extended_properties AS EP 
--		INNER JOIN sys.columns AS C ON EP.major_id = C.object_id AND 
--		(CASE 
--			WHEN EP.minor_id = 0 THEN EP.minor_id 
--			ELSE EP.minor_id 
--		END) = C.column_id

--		INNER JOIN sys.tables AS T ON EP.major_id = T.object_id
--	WHERE class = 1

--SELECT  
--	T.name AS 'Table_name',
--	EP.value AS 'Definition'
--	FROM sys.extended_properties AS EP 
--		INNER JOIN sys.tables AS T ON EP.major_id = T.object_id
--	WHERE class = 1 AND EP.minor_id = 0;

-- b.
SELECT  
	T.name AS 'Table_name',
	CASE WHEN EP.minor_id > 0 THEN C.name ELSE ''
	END as 'Column_name',
	EP.value AS 'Definition'
	FROM sys.extended_properties AS EP 
		INNER JOIN sys.columns AS C ON EP.major_id = C.object_id AND EP.minor_id = C.column_id
		INNER JOIN sys.tables AS T ON EP.major_id = T.object_id
	WHERE class = 1 AND T.name = 'Person';



--a. 
--Select 
--	t.name as TableName
--	,c.name as ColumnName
--	,ep.value as 'Definition'
--From sys.extended_properties ep
--	Inner Join sys.tables t on t.object_id = ep.major_id
--	Inner join sys.columns c on c.object_id = ep.major_id
--		and c.column_id = ep.minor_id
--Where class = 1
 
----b. 
--Select 
--	t.name as TableName
--	,c.name as ColumnName
--	,ep.value as 'Definition'
--From sys.extended_properties ep
--	Inner Join sys.tables t on t.object_id = ep.major_id
--	Inner join sys.columns c on c.object_id = ep.major_id
--		and c.column_id = ep.minor_id
--Where class = 1
--	and t.name = 'Person'