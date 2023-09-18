/*
Question 13
a. What is the job title for John Evans

b. What department does John Evans work in?
*/
--a.
SELECT P.FirstName, P.LastName, E.JobTitle FROM [Person].[Person] AS P 
	INNER JOIN [HumanResources].[Employee] AS E ON E.BusinessEntityID = P.BusinessEntityID
	WHERE P.FirstName = 'John' AND P.LastName = 'Evans';
--b.
SELECT P.FirstName, P.LastName, D.Name  FROM [Person].[Person] AS P 
	INNER JOIN [HumanResources].[EmployeeDepartmentHistory] AS EDH ON EDH.BusinessEntityID = P.BusinessEntityID
	INNER JOIN [HumanResources].[Department] AS D ON EDH.DepartmentID = D.DepartmentID
WHERE P.FirstName = 'John' AND P.LastName = 'Evans';

-- ANSWER
--a. 
Select 
	JobTitle
From Person.Person p
	Inner Join HumanResources.Employee e on e.BusinessEntityID = p.BusinessEntityID
Where FirstName = 'John'
	and LastName = 'Evans'
 
--b. 
Select 
	d.Name as DepartmentName
From Person.Person p
	Inner Join HumanResources.Employee e on e.BusinessEntityID = p.BusinessEntityID
	Inner Join HumanResources.EmployeeDepartmentHistory edh on edh.BusinessEntityID = e.BusinessEntityID
	Inner Join HumanResources.Department d on d.DepartmentID = edh.DepartmentID
Where FirstName = 'John'
	and LastName = 'Evans'