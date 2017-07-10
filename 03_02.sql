-- Switch to the WideWorldImporters database
USE WideWorldImporters;
GO

-- Explore view in Object Explorer, then use one in a query
SELECT * 
FROM Website.Customers;
GO

-- Filter using a view 
SELECT * 
FROM Website.Customers
WHERE CustomerCategoryName = 'supermarket';
GO

-- Create a view
CREATE VIEW dbo.CustomerCities
AS
SELECT Sales.Customers.CustomerName,
	   Application.Cities.CityName,
	   Application.StateProvinces.StateProvinceName,
	   Sales.Customers.PhoneNumber
FROM   Application.Cities INNER JOIN
		Sales.Customers ON Application.Cities.CityID = Sales.Customers.DeliveryCityID INNER JOIN
		Application.StateProvinces ON Application.Cities.StateProvinceID = 
			Application.StateProvinces.StateProvinceID;
GO

-- Delete a view 
SELECT * FROM dbo.CustomerCities;
GO

-- Delete a view
DROP VIEW dbo.CustomerCities;
GO

-- Create a more complex view
CREATE VIEW dbo.CustomerOrders 
AS
SELECT Sales.Customers.CustomerID, Sales.Customers.CustomerName, Application.Cities.CityName,
	   Application.StateProvinces.StateProvinceName, Sales.Invoices.InvoiceDate, Sales.Invoices.InvoiceID,
	   Sales.InvoiceLines.InvoiceLineID, Warehouse.StockItems.StockItemName, Sales.InvoiceLines.Quantity,
	   Sales.InvoiceLines.UnitPrice
FROM Sales.Customers INNER JOIN 
		Sales.Invoices ON Sales.Customers.CustomerID = Sales.Invoices.CustomerID INNER JOIN
		Sales.InvoiceLines ON Sales.Invoices.InvoiceID = Sales.InvoiceLines.InvoiceID INNER JOIN
		Warehouse.StockItems ON Sales.InvoiceLines.StockItemID = Warehouse.StockItems.StockItemID INNER JOIN 
		Application.Cities ON Sales.Customers.DeliveryCityID = Application.Cities.CityID INNER JOIN 
			Application.StateProvinces ON Application.Cities.StateProvinceID = 
				Application.StateProvinces.StateProvinceID;
GO

-- Use the view to find orders from a single state
SELECT * 
FROM dbo.CustomerOrders
WHERE StateProvinceName = 'Arizona'
ORDER BY InvoiceID DESC, InvoiceLineID;
GO


-- Create an aggregate count as a view
CREATE VIEW dbo.CustomerCounts
AS
SELECT Application.StateProvinces.StateProvinceName AS State,
	   COUNT(Sales.Customers.CustomerID) AS [Count of Customers]
FROM Application.Cities INNER JOIN
		Sales.Customers ON Application.Cities.CityID = Sales.Customers.DeliveryCityID INNER JOIN
			Application.StateProvinces ON Application.Cities.StateProvinceID = 
				Application.StateProvinces.StateProvinceID
GROUP BY Application.StateProvinces.StateProvinceName;
GO


-- Query the view
SELECT * FROM dbo.CustomerCounts
ORDER BY State;
--ORDER BY [Count of Customers]
GO

ALTER VIEW dbo.CustomerCounts
WITH ENCRYPTION
AS
SELECT Application.StateProvinces.StateProvinceName AS State,
	   COUNT(Sales.Customers.CustomerID) AS [Count of Customers]
FROM Application.Cities INNER JOIN
		Sales.Customers ON Application.Cities.CityID = Sales.Customers.DeliveryCityID INNER JOIN
			Application.StateProvinces ON Application.Cities.StateProvinceID = 
				Application.StateProvinces.StateProvinceID
GROUP BY Application.StateProvinces.StateProvinceName;
GO