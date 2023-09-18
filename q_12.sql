/*
Question 12:
a. What is the name of the CEO? Concatenate first and last name.

b. When did this person start working for AdventureWorks

c. Who reports to the CEO? Includes their names and title
*/
-- a.
SELECT (P.FirstName + ' ' + P.LastName) FROM [HumanResources].[Employee] AS E
INNER JOIN [Person].[Person] AS P ON P.BusinessEntityID = E.BusinessEntityID
WHERE E.JobTitle = 'Chief Executive Officer';

-- b.
SELECT (P.FirstName + ' ' + P.LastName), E.HireDate FROM [HumanResources].[Employee] AS E
INNER JOIN [Person].[Person] AS P ON P.BusinessEntityID = E.BusinessEntityID
WHERE E.JobTitle = 'Chief Executive Officer';

-- c.
SELECT (P.FirstName + ' ' + P.LastName), E.JobTitle FROM [HumanResources].[Employee] AS E
INNER JOIN [Person].[Person] AS P ON P.BusinessEntityID = E.BusinessEntityID
WHERE E.OrganizationLevel = 1;

-- ANSWER 
--a.
Select 
	CONCAT(p.FirstName,' ',p.LastName) as FullName
from HumanResources.Employee e
	INNER JOIN Person.Person p
		on p.BusinessEntityID = e.BusinessEntityID 
Where JobTitle = 'Chief Executive Officer'
 
--b.
Select 
	HireDate
from HumanResources.Employee e
Where JobTitle = 'Chief Executive Officer'
 
--c.
Select  
	CONCAT(p.FirstName,' ',p.LastName) as FullName
	,JobTitle
From HumanResources.Employee e
INNER JOIN Person.Person p
		on p.BusinessEntityID = e.BusinessEntityID
Where OrganizationLevel = '1';