
/* Question 2:
a. Write a SQL Statement that will show a count of schemas, tables, and columns (do not include views) in the AdventureWorks database.

b. Write a similar statement as part a but list each schema, table, and column (do not include views). This table can be used later in the course. 
*/

-- SELECT * FROM sys.objects;




SELECT COUNT(*) AS [Number of Tables]
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

SELECT COUNT(DISTINCT TABLE_SCHEMA) AS [Number of Schemas]
FROM INFORMATION_SCHEMA.TABLES;

SELECT COUNT(COLUMN_NAME) as [Number of Columns] 
FROM INFORMATION_SCHEMA.COLUMNS;

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

SELECT DISTINCT TABLE_SCHEMA
FROM INFORMATION_SCHEMA.TABLES;

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS;


/* ANSWER */

--a.
Select 
	Count(distinct s.name) as SchemaName
	,Count(distinct t.name) as TableName
	,Count(c.name) as ColumnName
From sys.tables t
	INNER JOIN sys.columns c on c.object_id = t.object_id
	INNER JOIN sys.schemas s on s.schema_id = t.schema_id
 
Select 
	Count(Distinct table_schema) as SchemaName
	,Count(Distinct table_name) as TableName
	,Count(column_name) as ColumnName
From information_schema.columns
Where table_name not in(
		Select Distinct TABLE_NAME 
		From information_schema.views)
 
--b.
Select 
	s.name as SchemaName
	,t.name as TableName
	,c.name as ColumnName
From sys.tables t
	INNER JOIN sys.columns c on c.object_id = t.object_id
	INNER JOIN sys.schemas s on s.schema_id = t.schema_id	
 
Select 
	table_schema as SchemaName
	,table_name as TableName
	,column_name as ColumnName
From information_schema.columns
Where table_name not in(Select Distinct table_name 
			From information_schema.views)