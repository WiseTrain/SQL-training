/* In this question you will replicate the 7 columns above (ForeignKeyName, SchemaName, TableName, ColumnName,  ReferencedSchema, ReferencedTable, Referenced Column) 
	for every Foreign Key in the AdventureWorks database. 
*/
USE [AdventureWorks2019];
-- Select * from sys.foreign_keys;


SELECT fk.name AS ForeignKeyName, s.name AS SchemaName, t.name AS TableName, 
		rs.name AS ReferencedSchema, rt.name AS ReferencedTable
	FROM sys.foreign_keys as fk 
	INNER JOIN sys.schemas as s ON fk.schema_id = s.schema_id
	INNER JOIN sys.tables as t ON fk.parent_object_id = t.object_id
	INNER JOIN sys.tables as rt ON fk.referenced_object_id = rt.object_id
	INNER JOIN sys.schemas as rs ON fk.referenced_object_id = rt.object_id AND rt.schema_id = rs.schema_id; 


SELECT O.name AS ForeignKeyName, 
	S1.name AS SchemaName,
	T1.name AS TableName, 
	C1.name AS ColumnName,
	S2.name AS ReferencedSchema,
	T2.name AS ReferencedTable, 
	C2.name AS ReferencedColumn
	FROM sys.foreign_key_columns AS FKC
		INNER JOIN sys.objects AS O ON O.object_id = FKC.constraint_object_id
		INNER JOIN sys.tables AS T1 ON FKC.parent_object_id = T1.object_id
		INNER JOIN sys.tables AS T2 ON FKC.referenced_object_id = T2.object_id
		INNER JOIN sys.schemas AS S1 ON T1.schema_id = S1.schema_id
		INNER JOIN sys.schemas AS S2 ON T2.schema_id = S2.schema_id
		INNER JOIN sys.columns AS C1 ON FKC.parent_object_id = C1.object_id 
			AND FKC.parent_column_id = C1.column_id
		INNER JOIN sys.columns AS C2 ON FKC.referenced_object_id = C2.object_id 
			AND FKC.referenced_column_id = C2.column_id;


-- ANSWER 

--Select 
--    O.name as FK_Name
--    ,S1.name as SchemaName
--    ,T1.name as TableName
--    ,C1.name as ColumnName
--    ,S2.name as ReferencedSchemaName
--    ,T2.name as ReferencedTableName
--    ,C2.name as ReferencedColumnName
--From sys.foreign_key_columns FKC
--    INNER JOIN sys.objects O ON O.object_id = FKC.constraint_object_id
--    INNER JOIN sys.tables T1 ON T1.object_id = FKC.parent_object_id
--    INNER JOIN sys.tables T2 ON T2.object_id = FKC.referenced_object_id
--    INNER JOIN sys.columns C1 ON C1.column_id = parent_column_id 
--		             AND C1.object_id = T1.object_id
--    INNER JOIN sys.columns C2 ON C2.column_id = referenced_column_id 
--			     AND C2.object_id = T2.object_id
--    INNER JOIN sys.schemas S1 ON T1.schema_id = S1.schema_id
--    INNER JOIN sys.schemas S2 ON T2.schema_id = S2.schema_id