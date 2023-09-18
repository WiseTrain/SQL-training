/*
Question 3:
We learned in question 1 that 89 check constraints exist in the AdventureWorks Database. In this question we are going to determine what the check constraints are doing while creating a new database and table.

a. Create a new database called "Edited_AdventureWorks" (we are creating another database so we don't   
overwrite or change the AdventureWorks database). Then write a USE statement to connect to the new database.
b. Using the following tables - sys.check_constraints, sys.tables, and sys.columns to write 
a query that will give you TableName, ColumnName, CheckConstraintName, and CheckConstraintDefinition

c. Create a table named "tbl_CheckConstraint" in the "Edited_AdventureWorks" database with the following  columns and data types:
TableName varchar(100)
ColumnName varchar(100)
CheckConstraint varchar(250)
Definition varchar(500)
ConstraintLevel varchar(100)

d. Using the query in part b insert the data into "tbl_CheckConstraint"
e. Using a case statement write an update statement (update ConstraintLevel) that will specify whether the constraint is assigned to the column or the table.
f. What does this mean?
g. Once you're done interpreting the results drop the tbl_CheckConstraint table
*/

USE Edited_AdventureWorks;

-- SELECT * FROM AdventureWorks2019.sys.check_constraints;
--SELECT * FROM AdventureWorks2019.sys.tables;

-- SELECT * FROM AdventureWorks2019.sys.columns;


DROP TABLE IF EXISTS tbl_CheckConstraint;

CREATE TABLE tbl_CheckConstraint (
TableName varchar(100),
ColumnName varchar(100),
CheckConstraint varchar(250),
Definition varchar(500),
ConstraintLevel varchar(100)
);

INSERT INTO tbl_CheckConstraint 
	SELECT t.name as TableName,
			c.name as ColumnName,
			cc.name AS CheckConstraint, 
			cc.definition AS [Definition],
			CASE cc.parent_column_id WHEN 0 THEN 'TABLE' ELSE 'COLUMN' END AS ConstraintLevel

		FROM AdventureWorks2019.sys.check_constraints cc
			INNER JOIN AdventureWorks2019.sys.tables t ON cc.parent_object_id  = t.object_id
			LEFT JOIN AdventureWorks2019.sys.columns c ON cc.parent_object_id  = c.object_id
				AND cc.parent_column_id = c.column_id;

-- SELECT * FROM tbl_CheckConstraint;