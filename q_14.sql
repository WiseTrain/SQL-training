/* Question 14
a. Which Purchasing vendors have the highest credit rating?

b. Using a case statement replace the 1 and 0 in Vendor.PreferredVendorStatus to "Preferred" vs "Not Preferred."   How many vendors are considered Preferred?

c. For Active Vendors only, do Preferred vendors have a High or lower average credit rating?

d. How many vendors are active and Not Preferred?
*/

USE [AdventureWorks2019];
-- a.
SELECT * FROM [Purchasing].[Vendor] WHERE
	CreditRating = (SELECT MAX(CreditRating) FROM [Purchasing].[Vendor]);

--UPDATE [Purchasing].[Vendor] SET PreferredVendorStatus = 
--	(CASE
--		WHEN PreferredVendorStatus = 1 THEN 'Preferred'
--		WHEN PreferredVendorStatus = 0 THEN 'Not Preferred'
--	END)
--WHERE PreferredVendorStatus IN (1, 0);

-- b.
SELECT Name, 
	(CASE
		WHEN PreferredVendorStatus = 1 THEN 'Preferred'
		WHEN PreferredVendorStatus = 0 THEN 'Not Preferred'
	END) AS 'Status'
	FROM [Purchasing].[Vendor]
	ORDER BY PreferredVendorStatus DESC;

SELECT COUNT(*) AS 'Number of Prefered Vendors' FROM [Purchasing].[Vendor]
	WHERE PreferredVendorStatus = 1;

-- c.
SELECT Name
	FROM [Purchasing].[Vendor]
	WHERE ActiveFlag = 1; 

SELECT AVG(CAST(CreditRating AS DECIMAL)) AS AvgRating,
		(CASE
			WHEN PreferredVendorStatus = 1 THEN 'Preferred'
			WHEN PreferredVendorStatus = 0 THEN 'Not Preferred'
		END) AS 'Status'
	FROM [Purchasing].[Vendor]
	WHERE ActiveFlag = 1
	GROUP BY (CASE
			WHEN PreferredVendorStatus = 1 THEN 'Preferred'
			WHEN PreferredVendorStatus = 0 THEN 'Not Preferred'
		END); 

--d. 
SELECT Name FROM [Purchasing].[Vendor]
	WHERE PreferredVendorStatus = 0 AND ActiveFlag = 1;


-- ANSWER
--a. 
Select * from Purchasing.Vendor
order by CreditRating asc
 
--b. 
Select 
	Case when PreferredVendorStatus = '1' Then 'Preferred'
		 Else 'Not Preferred' End as PreferredStatus
	,count(*) as CNT
From Purchasing.Vendor
Group by 
	Case when PreferredVendorStatus = '1' Then 'Preferred'
		 Else 'Not Preferred' End
 
--c. 
Select 
	Case when PreferredVendorStatus = '1' Then 'Preferred'
		 Else 'Not Preferred' End as PreferredStatus
	,Avg(Cast(CreditRating as decimal)) as AvgRating
From Purchasing.Vendor
Where ActiveFlag = 1
Group by 
	Case when PreferredVendorStatus = '1' Then 'Preferred'
		 Else 'Not Preferred' End
 
--d. 
Select 
	Count(*) as CNT
From Purchasing.Vendor
Where ActiveFlag = 1 and PreferredVendorStatus = 0