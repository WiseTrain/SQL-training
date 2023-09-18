USE AdventureWorks2019;
--SELECT DISTINCT type, type_desc
--FROM sys.objects;

/* Write a SQL Statement that will give you a count of each object type in the Adventure Works database. Order by count descending */

SELECT type, type_desc, COUNT(*) AS "QTY"
FROM sys.objects
GROUP BY type, type_desc
ORDER BY QTY DESC;
/* ORDER BY COUNT(*)DESC; */

/* Answer */
Select 
    type_desc
    , Count(*) as CNT
From sys.objects
Group by type_desc
Order by 2 desc