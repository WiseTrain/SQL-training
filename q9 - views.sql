/*
Question 9
We know from Question 1 and using the information_schema.view table that there are 20 views 
in the AdventureWorks database. Each one of these views are created from one or more table(s) 
in the database. For Example, "vStateProvinceCountryRegion" is a view that was created from multiple columns
in the StateProvince and CountryRegion tables.

Write a script that will show you each view name and the number of tables used to create the view.
*/

USE [AdventureWorks2019]
SELECT TABLE_NAME, 
    (LEN(VIEW_DEFINITION) - LEN(REPLACE(VIEW_DEFINITION, 'join','xxx')) + 1) 
        AS TablesNum
	FROM INFORMATION_SCHEMA.VIEWS;

SELECT * FROM Information_Schema.View_Column_Usage;

-- ANSWER
Select View_name 
    ,Count(Distinct Table_Name) as TableCNT		
from Information_Schema.View_Column_Usage
Group by View_name