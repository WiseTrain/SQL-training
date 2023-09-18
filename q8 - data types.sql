/*
Question 8
In Question 2 we were introduced to the information_schema schema, specifically the information_schema.columns table.

a. Use this table to get a count of each data type in the AdventureWorks Database (include the view tables). Which data type is used the most?
b. Using a case statement create a data type grouping that summarizes each data type as one of the following Groups:

Character

Numeric

Date

Null

Use the following columns to create these groups:

Character_Maximum_Length

Numeric_Precision

DateTime_Precision

For example, when the Character_Maximum_Length is not null then the data type group is "Character." If a row is    null in all three columns then put it in the "Null" group.

Then give a count of data types in each grouping. The final output will only have two columns - "DataTypeGroup" and "DataTypeCNT." Lastly, order by count desc



c. What data types are in the "Null" group
*/

--a.
USE AdventureWorks2019;
SELECT DATA_TYPE, COUNT(*) AS CNT FROM INFORMATION_SCHEMA.COLUMNS
GROUP BY DATA_TYPE
ORDER BY 2 DESC;

--b.
SELECT 
	CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL THEN 'Character'
		WHEN NUMERIC_PRECISION IS NOT NULL THEN 'Numeric'
		WHEN DATETIME_PRECISION IS NOT NULL THEN 'Date'
		ELSE 'Null' 
	END AS DataTypeGroup, 
	COUNT(*) as DataTypeCNT

	FROM INFORMATION_SCHEMA.COLUMNS
	GROUP BY 
		CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL THEN 'Character'
		WHEN NUMERIC_PRECISION IS NOT NULL THEN 'Numeric'
		WHEN DATETIME_PRECISION IS NOT NULL THEN 'Date'
		ELSE 'Null' 
	END
	ORDER BY COUNT(*) DESC;
-- SELECT * FROM INFORMATION_SCHEMA.COLUMNS;

--c.
SELECT DISTINCT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE (CHARACTER_MAXIMUM_LENGTH IS NULL) AND (NUMERIC_PRECISION IS NULL) AND (DATETIME_PRECISION IS NULL);

-- ANSWER

--b. 
Select 
	Case When Character_Maximum_Length is not null then 'Character'
		 When Numeric_Precision is not null then 'Numeric'
		 When Datetime_Precision is not null then 'Date'
		 Else null
		 End as 'DataTypeGroup'
	,Count(*) as CNT
From Information_Schema.Columns

Group by 
	Case When Character_Maximum_Length is not null then 'Character'
		 When Numeric_Precision is not null then 'Numeric'
		 When Datetime_Precision is not null then 'Date'
		 Else null
		 End
Order by count(*) desc
 
--c.
Select * from Information_Schema.Columns
Where Character_Maximum_Length is null
	and Numeric_Precision is null
	and Datetime_Precision is null