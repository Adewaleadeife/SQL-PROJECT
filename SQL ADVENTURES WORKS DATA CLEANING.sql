

--SELECT ALL COLUMNS IN ELOYEE TABLE
SELECT * 
FROM [HumanResources].[Employee]


-- SELECT ALL COLUMN WHERE GENDER IS MALE
SELECT * 
FROM [HumanResources].[Employee]
WHERE [Gender] = 'M'


-- SELECT ALL COLUMN WHERE VACATION HRS >= 40HRS
SELECT *
FROM [HumanResources].[Employee]
WHERE [VacationHours] >= 40

-- SELECT ALL COLUMN WHERE GENDER IS MALE AND MARITAL STATUS IS SINGLE
SELECT *
FROM [HumanResources].[Employee]
WHERE [Gender] = 'M' AND [MaritalStatus] = 'S'

--PRINT PRODUCT WITHOUT COLOR
SELECT *
FROM [Production].[Product]
WHERE [Color] IS NULL


--
--PRINT PRODUCT WITH COLOR
SELECT *
FROM [Production].[Product]
WHERE [Color] IS NULL


--PRINT SOME COLUMN FROM PRODUCT TABLE  WITH COLOR
SELECT [ProductID],[Name],[ProductNumber],[Color]
FROM [Production].[Product]
WHERE [Color] IS NOT NULL

--SORT IN ASC OR DESC ORDER
SELECT [BusinessEntityID],[JobTitle],[VacationHours]
FROM [HumanResources].[Employee]
ORDER BY VacationHours ASC

SELECT [OrganizationLevel],[BusinessEntityID], [JobTitle], [VacationHours]
FROM [HumanResources].[Employee]
WHERE Gender ='M'  AND MaritalStatus = 'S' AND  VacationHours <=50  
ORDER BY [OrganizationLevel] ASC

SELECT [BusinessEntityID],[JobTitle], [Gender],[HireDate],[VacationHours]
FROM [HumanResources].[Employee]
WHERE   Gender IN ('M' ,'F') AND VacationHours< 20 AND MaritalStatus ='S' 
ORDER BY [VacationHours] DESC

SELECT [ProductID],[Color],[Name]
FROM   [Production].[Product]
WHERE  COLOR IN ('BLACK','BLUE', 'RED', 'WHITE')
 

SELECT COUNT  (DISTINCT [Color]) AS NUMBERS_OF_COLORS
FROM [Production].[Product]

--TOP 100 PRODUCT
SELECT TOP 100 [NAME],[ListPrice],[Color]
FROM [Production].[Product]
WHERE [Color] IN ( 'RED', 'BLACK')
ORDER BY [ListPrice] ASC

-- SELECT UNIQUE EMPLOYEE
SELECT DISTINCT JobTitle
FROM [HumanResources].[Employee]


--SELECT SINGLE EMPLOYEES
SELECT COUNT ([JobTitle]) AS TOTAL_number_of_employee
FROM [HumanResources].[Employee]
WHERE [MaritalStatus] ='S'

SELECT SUM ([SickLeaveHours]) AS SICKLEAVE_HOURS, SUM ([VacationHours]) AS TOTAL_VACATION_HOURS, AVG ([VacationHours]) AS AVERAGE_VACATION_HOURS,
SQRT (AVG ([SickLeaveHours])) AS SQRTOFAVG_SICK_HOURS
FROM[HumanResources].[Employee]

SELECT [SalesOrderDetailID],[CarrierTrackingNumber],[OrderQty],[UnitPrice],[OrderQty]*[UnitPrice] AS TOTAL_AMOUNT_DUE,[OrderQty]*[UnitPrice]*0.9 AS DISCOUNTED_PRICE
FROM [Sales].[SalesOrderDetail]
ORDER BY [OrderQty] DESC

SELECT [OrderDate],[CustomerID],[TotalDue],[TaxAmt], 
([TotalDue]-[TaxAmt]) AS NET_DUE, 
([TotalDue]-[TaxAmt]) *0.20 AS HIDDEN_CHARGES 
FROM[Sales].[SalesOrderHeader]
WHERE [PurchaseOrderNumber] IS NULL

SELECT MAX ([TaxAmt]) AS MAX_TAX_AMOUNT
FROM[Sales].[SalesOrderHeader]

SELECT [MaritalStatus], COUNT ([MaritalStatus]) AS TOTAL_EMPLOYEES
FROM [HumanResources].[Employee]
GROUP BY [MaritalStatus]


SELECT  ([Gender]), SUM ([SickLeaveHours]) AS TOTAL_SICK_LEAVE_HOURS, COUNT ([SickLeaveHours]) AS TOTAL_SICK_LEAVE_HOURS
FROM [HumanResources].[Employee]
GROUP BY [Gender]
ORDER BY [Gender] DESC

 --YEAR,MONTH,DAY,GETDATE,DATENAME,DATEPART,DATEADD
 SELECT [BusinessEntityID],[JobTitle], DAY([HireDate]) AS DAY_OF_HIRE, MONTH ([HireDate]) AS MONTH_OF_HIRE, YEAR ([HireDate]) AS YEAR_OF_HIRE
FROM [HumanResources].[Employee]

 SELECT [BusinessEntityID],[JobTitle],[HireDate], YEAR (GETDATE()) AS TODAY_DATE 
FROM [HumanResources].[Employee] 


 SELECT [BusinessEntityID],[JobTitle],[HireDate] ,DATENAME(WEEKDAY,[HireDate])AS DAY_OF_HIRE,DATEDIFF(DD,[HireDate], GETDATE()) AS YEARS_OF_SERVICE
FROM [HumanResources].[Employee]
ORDER BY YEARS_OF_SERVICE DESC

SELECT [BusinessEntityID],
       LEFT ([FirstName], 2) AS FIRST_NAME_LOWER_CASE,
       LEFT ([LastName],2) AS LAST_NAME
FROM [Person].[Person]

SELECT [BusinessEntityID],
       RIGHT ([FirstName], 2) AS FIRST_NAME_LOWER_CASE,
       RIGHT ([LastName],2) AS LAST_NAME
FROM [Person].[Person]

-- check for names that start or end with a letter  
 SELECT *
 FROM[Person].[Person]
 WHERE [LastName] LIKE ('%a')

 --JOINING THE FIRST AND LAST NAME TOGETHER
 SELECT[BusinessEntityID],[FirstName],[LastName], CONCAT([FirstName],' ',[LastName]) AS FULL_MAME
 FROM [Person].[Person]

 --CASE FUNCTION SIMILAR LIKE IF FUNCTION IN EXCEL
 SELECT [BusinessEntityID],[JobTitle], DATEDIFF(YY,[HireDate],GETDATE()) AS YEARS_OF_SERVICE,
 CASE
 WHEN DATEDIFF (YY,[HireDate],GETDATE()) < 10
 THEN 'NEW EMPLOYEE'
 WHEN DATEDIFF (YY,[HireDate],GETDATE()) BETWEEN 11 AND 15
 THEN 'MID EMPLOYEE'
 WHEN DATEDIFF (YY,[HireDate],GETDATE()) >= 16
 THEN 'SENIOR EMPLOYEE'
 END AS EMPLOYEE_LEVEL
 FROM[HumanResources].[Employee]

 SELECT [BusinessEntityID],[JobTitle],[Gender],
 CASE
 WHEN [Gender]= 'M'
 THEN 'MALE'
 WHEN [Gender] ='F'
 THEN 'FEMALE'
 END AS EMPLOYEE_GENDER
 FROM [HumanResources].[Employee]

 --Grouping age
 SELECT[BusinessEntityID],[JobTitle],[BirthDate], DATEDIFF(YY,[BirthDate], GETDATE()) AS AGE_OF_EMPLOYEE,
 CASE
 WHEN DATEDIFF(YY,[BirthDate], GETDATE()) BETWEEN 0 AND 50
 THEN 'YOUNG'
 WHEN DATEDIFF(YY,[BirthDate], GETDATE()) >50 
 THEN 'OLD'
 END AS EMPLOYEE_CATEGORY
 FROM [HumanResources].[Employee] 

 SELECT HRE.[BusinessEntityID],HRE.[OrganizationLevel],HRE.[JobTitle],PP.[FirstName],PP.[LastName]
 FROM [HumanResources].[Employee] AS HRE
 INNER JOIN [Person].[Person] AS PP
 ON HRE.[BusinessEntityID] = PP.[BusinessEntityID]
 WHERE  JobTitle IS NOT NULL
 

 SELECT HRE.[BusinessEntityID],HRE.[OrganizationLevel],HRE.[JobTitle],PP.[FirstName],PP.[LastName]
 FROM [HumanResources].[Employee] AS HRE
 INNER JOIN [Person].[Person] AS PP
 ON HRE.[BusinessEntityID] = PP.[BusinessEntityID]
 WHERE  JobTitle IS NOT NULL

 SELECT HRE.[BusinessEntityID], HRE.[OrganizationLevel],HRE.[JobTitle],[FirstName],[LastName], CONCAT([FirstName], '  ',[LastName]) AS FULL_NAME
 FROM [HumanResources].[Employee] AS HRE
  FULL OUTER JOIN [Person].[Person] AS PP
 ON HRE. [BusinessEntityID] = PP.[BusinessEntityID]
 WHERE JobTitle IS NOT NULL

 SELECT SOD. [SalesOrderID],SOD.[CarrierTrackingNumber],SOD.[OrderQty],SOD.[UnitPrice],SOD.[LineTotal],
 CASE
 WHEN SOH.[OnlineOrderFlag]= 0
 THEN 'OFFLINE ORDER'
 WHEN [OnlineOrderFlag] = 1
 THEN 'ONLINE ORDER'
 END AS SALES_CHANNEL
 FROM   [Sales].[SalesOrderDetail] AS SOD
 LEFT JOIN [Sales].[SalesOrderHeader] AS SOH
 ON SOD.[SalesOrderID] = SOH.[SalesOrderID]
 WHERE [OnlineOrderFlag] = 0

 CREATE VIEW SALES_AND_PRODUCTION  AS
 SELECT PP.[ProductID], SOD.[SalesOrderID],SOD.[CarrierTrackingNumber],SOD.[OrderQty],SOD.[UnitPrice],SOD.[LineTotal], PP.[Name]
 FROM [Sales].[SalesOrderDetail] AS SOD
 LEFT JOIN [Production].[Product] AS PP
 ON  SOD.[ProductID]  = PP.[ProductID]
  
  SELECT *
  FROM SALES_AND_PRODUCTION
  
  SELECT *
  FROM [dbo].[SALES_AND_PRODUCTION]
  WHERE NAME LIKE ('MOUNTAIN%')

  SELECT*
  FROM [Person].[Person]

  CREATE TABLE FRIENDS_ADEIFE(
  [FIRST_NAME] VARCHAR (32),
  [LAST_NAME] VARCHAR (32),
  AGE INT,
  [DESIGNATATION] VARCHAR (20))

  SELECT *
  FROM [dbo].[FRIENDS_ADEIFE]

  INSERT INTO [dbo].[FRIENDS_ADEIFE](FIRST_NAME,LAST_NAME,AGE,DESIGNATATION)
  VALUES('OMOTOKE','OTEMUYI','24','CHILDHOOD FRIEND')

 SELECT [BusinessEntityID],[NationalIDNumber],[JobTitle]
 FROM [HumanResources].[Employee]
