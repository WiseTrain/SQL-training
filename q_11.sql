/* 
. How many employees exist in the Database?

b. How many of these employees are active employees?

c. How many Job Titles equal the 'SP' Person type?

d. How many of these employees are sales people?
*/

USE [AdventureWorks2019];
-- a.
SELECT COUNT(*) FROM [Person].[Person];
-- b.
SELECT COUNT(*) FROM [Person].[Person] AS P
INNER JOIN [HumanResources].[Employee] AS E ON P.BusinessEntityID = E.BusinessEntityID;
-- c.
SELECT  DISTINCT E.JobTitle FROM [HumanResources].[Employee] AS E
INNER JOIN [Person].[Person] AS P ON P.BusinessEntityID = E.BusinessEntityID
WHERE P.PersonType = 'SP';

--d. 
SELECT   P.FirstName, P.MiddleName, P.LastName, E.JobTitle FROM [Person].[Person] AS P
INNER JOIN [HumanResources].[Employee] AS E ON P.BusinessEntityID = E.BusinessEntityID
INNER JOIN [Sales].[SalesPerson] AS S ON P.BusinessEntityID = S.BusinessEntityID
WHERE P.PersonType = 'SP';

-- ANSWER

--a. 
Select 
	Count(*) as EmpCNT
	,Count(Distinct BusinessEntityID) as EmpCNT2
	,Count(Distinct NationalIDNumber) as EmpCNT3
From HumanResources.Employee
 
--b.
Select 
	CurrentFlag
	,Count(*) as EmpCNT
From HumanResources.Employee
Group by CurrentFlag
 
--c.
Select 
	Distinct JobTitle as CNT
From HumanResources.Employee e
	INNER JOIN Person.Person p on p.BusinessEntityID = e.BusinessEntityID
Where PersonType = 'SP'
 
--d.
Select 
	JobTitle
	, Count(Distinct e.BusinessEntityID) as SPCNT
From HumanResources.Employee e
	INNER JOIN Person.Person p on p.BusinessEntityID = e.BusinessEntityID
Where PersonType = 'SP'
Group by JobTitle;


SELECT * FROM HumanResources.Employee;