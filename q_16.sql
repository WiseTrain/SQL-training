--Question 16:
--a. How many products are sold by AdventureWorks?

--b. How many of these products are actively being sold by AdventureWorks?

--c. How many of these active products are made in house vs. purchased?

-- a. How many products are sold by AdventureWorks?
SELECT DISTINCT S.ProductID, P.Name, SC.Name, C.Name
	FROM [Sales].[SalesOrderDetail] AS S INNER JOIN [Production].[Product] AS P ON S.ProductID = P.ProductID 
	INNER JOIN [Production].[ProductSubcategory] AS SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
	INNER JOIN [Production].[ProductCategory] AS C ON C.ProductCategoryID = SC.ProductCategoryID;
-- SELECT COUNT(DISTINCT ProductID) FROM [Sales].[SalesOrderDetail];

-- a. How many products are sold by AdventureWorks?
SELECT count(*) FROM [Production].[Product]
	WHERE FinishedGoodsFlag = 1;

--b. How many of these products are actively being sold by AdventureWorks?
SELECT count(*) FROM [Production].[Product]
	WHERE FinishedGoodsFlag = 1 AND SellEndDate is null;

-- c. How many of these active products are made in house vs. purchased?
SELECT count(*) AS total, 
	count(CASE WHEN MakeFlag = 1 THEN ProductID ELSE null END) AS madeInHouse,
	count(CASE WHEN MakeFlag = 0 THEN ProductID ELSE null END) AS Purchased
	FROM [Production].[Product] 
	WHERE FinishedGoodsFlag = 1 
	AND SellEndDate is null;