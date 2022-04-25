-- Retrieve information about the products with color values except null, Red,
--silver/black, white and list price between £75 and £750. Rename the column StandardCost to
--price. Also, sort the result in descending order by list price

SELECT [ProductID],[Name],[Color],[StandardCost] AS PRICE,[ListPrice]
FROM [Production].[Product]
WHERE [Color] <> 'BLACK' 
AND  [Color] <> 'SILVER' 
AND [Color] IS NOT NULL
AND [Color] <> 'WHITE'
AND [Color] <> 'RED'
AND [ListPrice] BETWEEN 75 AND 750 
 ORDER BY [ListPrice] DESC

 --Find all the male employees born between 1962 to 1970 and with hire date greater
--than 2001 and female employees born between 1972 and 1975 and hire date between 2001
--and 2002.

 SELECT[BusinessEntityID],[JobTitle],[BirthDate],[HireDate], [Gender]
 FROM [HumanResources].[Employee]
WHERE GENDER = 'M' AND BirthDate BETWEEN  '1962-01-01' AND  '1970-01-01'
AND HireDate >'2001-01-01'

--: Create a list of 10 most expensive products that have a product number beginning
--with ‘BK’. Include only the product ID, Name and colour.

 SELECT[BusinessEntityID],[JobTitle],[BirthDate],[HireDate], [Gender]
 FROM [HumanResources].[Employee]
WHERE GENDER = 'F' AND BirthDate BETWEEN  '1972-01-01' AND  '1975-01-01'
AND HireDate BETWEEN '2001-01-01' AND '2002-01-01'
 
 -- Create a list of all contact persons, where the first 4 characters of the last name are
--the same as the first four characters of the email address. Also, for all contacts whose first name
--and the last name begin with the same characters, create a new column called full name
--combining first name and the last name only. Also provide the length of the new column full name.

 SELECT TOP 10[ListPrice], [ProductID], [Name],[Color],[ProductNumber][EndDate]
 FROM [Production].[Product]
 WHERE  [ProductNumber] LIKE ('BK%')

--Create a list of all contact persons, where the first 4 characters of the last name are the same as the first four characters of the email address. 
--Alsofor all contacts whose first namand the last name begin with the same characters, create a new column called full name
--combining first name and the last name only. Also provide the length of the new column full

SELECT [FirstName],[LastName],[EmailAddress], CONCAT ([FirstName], ' ',[LastName]) AS FULL_NAME, LEN(CONCAT ([FirstName], ' ',[LastName])) AS LENGTH_OF_FULLNAME
 FROM [Person].[Person] AS PP
 LEFT JOIN [Person].[EmailAddress] AS PEA
 ON PP. [BusinessEntityID] = PEA.[BusinessEntityID]
WHERE LEFT([LastName],4) =LEFT([EmailAddress],4)
AND LEFT([FirstName],1) = LEFT([LastName],1)


--Question 5: Return all product subcategories that take an average of 3 days or longer to manufacture


SELECT PP.[ProductID],PP.[ListPrice],PP.[DaysToManufacture],PPS.[ProductSubcategoryID], PPS.[Name]
FROM [Production].[Product] AS PP
LEFT JOIN [Production].[ProductSubcategory] AS PPS
ON PP.[ProductSubcategoryID] =PPS.[ProductSubcategoryID]
WHERE [DaysToManufacture] >= 3


--: Create a list of product segmentation by defining criteria that places each item in a
--predefined segment as follows. If price gets less than £200 then low value. If price is between
--£201 and £750 then mid value. If between £750 and £1250 then mid to high value else higher
--value. Filter the results only for black, silver and red color products

 SELECT [ProductID],[Name],[Color],[ListPrice],
CASE
WHEN [ListPrice] <=200
THEN 'LOW VALUE'
WHEN [ListPrice] BETWEEN 201 AND 750
THEN 'MID VALUE'
WHEN [ListPrice] BETWEEN 750 AND 1250 
THEN 'MID TO HIGH VALUE'
ELSE 'HIGHER VALUE'
END AS PRODUCT_SEGEMEMT
FROM[Production].[Product]
WHERE  COLOR IN ('BLACK','SILVER', 'RED')
