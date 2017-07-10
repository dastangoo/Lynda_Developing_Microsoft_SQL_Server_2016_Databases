-- Switch to WideWorldImporters database
USE WideWorldImporters;
GO

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

SELECT * 
FROM dbo.CustomerOrders;
GO

-- Add schemabinding to the view
ALTER VIEW dbo.CustomerOrders 
WITH SCHEMABINDING
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

-- Add an index to the view
CREATE UNIQUE CLUSTERED INDEX IndexCustomerOrders
ON dbo.CustomerOrders (InvoiceLineID);
GO

SELECT * 
FROM dbo.CustomerOrders;
GO

