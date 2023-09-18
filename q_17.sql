--We learned in Question 16 that the product table includes a few different type of products - i.e., manufactured vs. purchased.
--a. Sum the LineTotal in SalesOrderDetail. Format as currency

SELECT FORMAT(SUM(LineTotal), 'C0') FROM [Sales].[SalesOrderDetail] AS SumLineTotal;

--b. Sum the LineTotal in SalesOrderDetail by the MakeFlag in the product table. Use a case statement to specify manufactured vs. purchased. Format as currency.
SELECT FORMAT(SUM(LineTotal), 'C')  AS total,
	FORMAT(SUM(CASE WHEN P.MakeFlag = 1 THEN LineTotal ELSE null END), 'C')  AS totalProduced,
	FORMAT(SUM(CASE WHEN P.MakeFlag = 0 THEN LineTotal ELSE null END), 'C')  AS totalPurchased
FROM [Sales].[SalesOrderDetail] AS SOD INNER JOIN [Production].[Product] AS P 
	ON P.ProductID = SOD.ProductID;

--c. Add a count of distinct SalesOrderIDs
SELECT FORMAT(SUM(LineTotal), 'C')  AS total,
	FORMAT(SUM(CASE WHEN P.MakeFlag = 1 THEN LineTotal ELSE null END), 'C')  AS totalProduced,
	FORMAT(SUM(CASE WHEN P.MakeFlag = 0 THEN LineTotal ELSE null END), 'C')  AS totalPurchased,
	COUNT(DISTINCT SOD.SalesOrderID) AS distinctOrderIDs
FROM [Sales].[SalesOrderDetail] AS SOD INNER JOIN [Production].[Product] AS P 
	ON P.ProductID = SOD.ProductID;

--d. What is the average LineTotal per SalesOrderID?
SELECT FORMAT(SUM(LineTotal), 'C')  AS total,
	COUNT(DISTINCT SalesOrderID) AS distinctOrderIDs,
	FORMAT(SUM(LineTotal)/COUNT(DISTINCT SalesOrderID), 'C')
FROM [Sales].[SalesOrderDetail];

-- correct version:
-- b.
SELECT (CASE WHEN P.MakeFlag = 1 THEN 'Produced' ELSE 'Purchased' END) AS category,
	FORMAT(SUM(SOD.LineTotal), 'C0') AS total
	FROM [Sales].[SalesOrderDetail] AS SOD INNER JOIN [Production].[Product] AS P 
	ON P.ProductID = SOD.ProductID
	GROUP BY P.MakeFlag;
-- c.
SELECT (CASE WHEN P.MakeFlag = 1 THEN 'Produced' ELSE 'Purchased' END) AS category,
	FORMAT(SUM(SOD.LineTotal), 'C0') AS total,
	FORMAT(COUNT(DISTINCT SOD.SalesOrderID), 'N0') as salesOrderIDs
	FROM [Sales].[SalesOrderDetail] AS SOD INNER JOIN [Production].[Product] AS P 
	ON P.ProductID = SOD.ProductID
	GROUP BY P.MakeFlag;

	-- d.
SELECT (CASE WHEN P.MakeFlag = 1 THEN 'Produced' ELSE 'Purchased' END) AS category,
	FORMAT(SUM(SOD.LineTotal), 'C0') AS total,
	FORMAT(COUNT(DISTINCT SOD.SalesOrderID), 'N0') as salesOrderIDs,
	FORMAT(SUM(SOD.LineTotal)/(COUNT(DISTINCT SOD.SalesOrderID)), 'C') as 'avgPerOrder'
	FROM [Sales].[SalesOrderDetail] AS SOD INNER JOIN [Production].[Product] AS P 
	ON P.ProductID = SOD.ProductID
	GROUP BY P.MakeFlag;


