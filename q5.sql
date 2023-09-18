/*
Question 5
**Complete Question 4 before attempting this question**

a. In this question we are going to put the script written in question 4 into a table. 
To keep the AdventureWorks   database clean create a new database called "Edited_AdventureWorks" (if you haven't already)

b. Using a Select Into put the script in question 4 into a table named "Table_Relationships" be sure to put this   
table in the Edited_AdventureWorks database. Here is the script from question 4:

Select 
    O.name as FKName
    ,S1.name as SchemaName
    ,T1.name as TableName
    ,C1.name as ColumnName
    ,S2.name as ReferencedSchemaName
    ,T2.name as ReferencedTableName
    ,C2.name as ReferencedColumnName
From sys.foreign_key_columns FKC
    INNER JOIN sys.objects O ON O.object_id = FKC.constraint_object_id
    INNER JOIN sys.tables T1 ON T1.object_id = FKC.parent_object_id
    INNER JOIN sys.tables T2 ON T2.object_id = FKC.referenced_object_id
    INNER JOIN sys.columns C1 ON C1.column_id = parent_column_id 
		             AND C1.object_id = T1.object_id
    INNER JOIN sys.columns C2 ON C2.column_id = referenced_column_id 
			     AND C2.object_id = T2.object_id
    INNER JOIN sys.schemas S1 ON T1.schema_id = S1.schema_id
    INNER JOIN sys.schemas S2 ON T2.schema_id = S2.schema_id
c. Find the Table in Object Explorer

d. In Question 1 we learned that the AdventureWorks database has 90 foreign key constraints; 
however, Table_Relationships has 91 rows/relationships. Find the foreign key that has been used twice. What does this mean?

e. How many Distinct Foreign Keys include BusinessEntityID as a column or referenced column?

*/

IF NOT EXISTS 
   (
     SELECT name FROM master.dbo.sysdatabases 
     WHERE name = 'Edited_AdventureWorks'
    )
CREATE DATABASE Edited_AdventureWorks;

USE Edited_AdventureWorks;

DROP TABLE IF EXISTS Table_Relationships;
CREATE TABLE Table_Relationships (
	ForeignKeyName varchar(100),
	SchemaName varchar(100),
	TableName varchar(100),
	ColumnName varchar(100),
	ReferencedSchemaName varchar(100),
	ReferencedTableName varchar(100),
	ReferencedColumnName varchar(100)
);

INSERT INTO Table_Relationships 
	SELECT O.name AS ForeignKeyName, 
		S1.name AS SchemaName,
		T1.name AS TableName, 
		C1.name AS ColumnName,
		S2.name AS ReferencedSchema,
		T2.name AS ReferencedTable, 
		C2.name AS ReferencedColumn
		FROM AdventureWorks2019.sys.foreign_key_columns AS FKC
			INNER JOIN AdventureWorks2019.sys.objects AS O ON O.object_id = FKC.constraint_object_id
			INNER JOIN AdventureWorks2019.sys.tables AS T1 ON FKC.parent_object_id = T1.object_id
			INNER JOIN AdventureWorks2019.sys.tables AS T2 ON FKC.referenced_object_id = T2.object_id
			INNER JOIN AdventureWorks2019.sys.schemas AS S1 ON T1.schema_id = S1.schema_id
			INNER JOIN AdventureWorks2019.sys.schemas AS S2 ON T2.schema_id = S2.schema_id
			INNER JOIN AdventureWorks2019.sys.columns AS C1 ON FKC.parent_object_id = C1.object_id 
				AND FKC.parent_column_id = C1.column_id
			INNER JOIN AdventureWorks2019.sys.columns AS C2 ON FKC.referenced_object_id = C2.object_id 
				AND FKC.referenced_column_id = C2.column_id;

SELECT * FROM Table_Relationships;
SELECT COUNT(*) FROM Table_Relationships WHERE ColumnName = 'BusinessEntityID' OR ReferencedColumnName = 'BusinessEntityID';