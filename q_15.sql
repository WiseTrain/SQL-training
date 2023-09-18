
--Question 15:
--Assume today is August 15, 2014.

--a. Calculate the age for every current employee. What is the age of the oldest employee?

--b. What is the average age by Organization level? Show answer with a single decimal

--c. Use the ceiling function to round up

--d. Use the floor function to round down

USE [AdventureWorks2019];

--SELECT (P.[FirstName] + ' ' + P.[LastName]) AS Name, E.BirthDate 
--	FROM [HumanResources].[Employee] AS E INNER JOIN [Person].[Person] AS P
--		ON E.BusinessEntityID = P.BusinessEntityID;
-- a. 
DECLARE @CurrentDate DATE;
-- Initialize the variable.
SET @CurrentDate = CAST('2014/08/15' AS DATE);

SELECT (P.[FirstName] + ' ' + P.[LastName]) AS Name, 
	E.BirthDate,
	( CAST(DATEDIFF(day, E.BirthDate, @CurrentDate) AS DECIMAL(8, 2)) / 365) AS Age
	FROM [HumanResources].[Employee] AS E INNER JOIN [Person].[Person] AS P
		ON E.BusinessEntityID = P.BusinessEntityID
	ORDER BY 2;

DECLARE @MAX_AGE_DAYS INT, @MONTHS INT, @YEARS INT, @DAYS INT;
SET @MAX_AGE_DAYS = (SELECT MAX(DATEDIFF(day, BirthDate, @CurrentDate)) FROM [HumanResources].[Employee]);
SET @YEARS = FLOOR(@MAX_AGE_DAYS / 365);
SET @MONTHS = FLOOR( (@MAX_AGE_DAYS - @YEARS * 365) / 12 );
SET @DAYS = @MAX_AGE_DAYS - @YEARS * 365 - @MONTHS * 12;

SELECT ( CAST(@YEARS AS VARCHAR) + ' years ' + CAST(@MONTHS AS VARCHAR) + ' month ' + CAST(@DAYS AS VARCHAR) + ' days') AS oldestEmployee;

-- b. 
-- AS DECIMAL(8, 2) vs AS DECIMAL
-- FORMAT not ROUND
SELECT OrganizationLevel, (FORMAT(CAST(AVG(DATEDIFF(day, BirthDate, @CurrentDate)) AS DECIMAL) / 365, 'N1') ) AS avgAge,
	(CEILING(CAST(AVG(DATEDIFF(day, BirthDate, @CurrentDate)) AS DECIMAL) /356) ) AS avgAgeCeiling,
	(FLOOR(CAST(AVG(DATEDIFF(day, BirthDate, @CurrentDate)) AS DECIMAL) / 365) ) AS avgAgeFloor
	FROM [HumanResources].[Employee]
	GROUP BY OrganizationLevel;

---- c.
--SELECT OrganizationLevel, (CEILING(CAST(AVG(DATEDIFF(year, BirthDate, @CurrentDate)) AS DECIMAL)) ) AS avgAge
--	FROM [HumanResources].[Employee]
--	GROUP BY OrganizationLevel;

---- d.
--SELECT OrganizationLevel, (FLOOR(CAST(AVG(DATEDIFF(year, BirthDate, @CurrentDate)) AS DECIMAL)) ) AS avgAge
--	FROM [HumanResources].[Employee]
--	GROUP BY OrganizationLevel;

-- ANSWER
--a. 
Select 
	BusinessEntityID
	,DATEDIFF(Year,BirthDate,'2014-08-15') as Age
From HumanResources.Employee
Order by 2 desc
 
--b. 
Select 
	OrganizationLevel
	,Format(Avg(cast(DATEDIFF(Year,BirthDate,'2014-08-15') as decimal)),'N1') as Age
From HumanResources.Employee
Group by OrganizationLevel
Order by 2 desc
 
--c. 
Select 
	OrganizationLevel
	,Format(Avg(cast(DATEDIFF(Year,BirthDate,'2014-08-15') as decimal)),'N1') as Age
	,Ceiling(Avg(cast(DATEDIFF(Year,BirthDate,'2014-08-15') as decimal))) as Age
From HumanResources.Employee
Group by OrganizationLevel
Order by 2 desc
 
--d. 
Select 
	OrganizationLevel
	,Format(Avg(cast(DATEDIFF(Year,BirthDate,'2014-08-15') as decimal)),'N1') as Age
	,Ceiling(Avg(cast(DATEDIFF(Year,BirthDate,'2014-08-15') as decimal))) as Age
	,Floor(Avg(cast(DATEDIFF(Year,BirthDate,'2014-08-15') as decimal))) as Age
From HumanResources.Employee
Group by OrganizationLevel
Order by 2 desc