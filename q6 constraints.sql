/* 
Question 6
In Question 1 we learned that the AdventureWorks Database has 152 Default Constraints. 
What tables and columns are these constraints on? And what are the default values?
*/


USE [AdventureWorks2019];

SELECT DC.name AS DefaultConstraintName, 
	S.name AS SchemaName,
	T.name as TableName,
	C.name AS ColumnName,
	DC.definition AS Definition
FROM sys.default_constraints AS DC
	INNER JOIN sys.schemas AS S ON DC.schema_id = S.schema_id
	INNER JOIN sys.tables AS T ON DC.parent_object_id = T.object_id
	INNER JOIN sys.columns AS C ON DC.parent_object_id = C.object_id 
		AND DC.parent_column_id = C.column_id; 


-- ANSWER
Select 
	s.name as SchemaName
	,t.name as TableName
	,c.name as ColumnName
	,dc.name as DefaultConstraint
	,dc.definition as DefaultDefinition
From sys.default_constraints dc
	Inner Join sys.tables t on t.object_id = dc.parent_object_id
	Inner Join sys.schemas s on s.schema_id = dc.schema_id
	Inner Join sys.columns c on c.column_id = dc.parent_column_id
			        and c.object_id = dc.parent_object_id