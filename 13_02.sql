-- Use the WideWorldImporters database
USE WideWorldImporters;
GO

-- Explore Sales.Customers
SELECT * FROM Sales.Customers;
GO

-- Create a function to fetch website url
CREATE FUNCTION Sales.FetchWebsite (@CustomerID int)
RETURNS char(100)
AS
BEGIN
	DECLARE @URL char(100)
	SELECT @URL = WebsiteURL FROM Sales.Customers
	WHERE CustomerID = @CustomerID;
	RETURN @URL;
END
GO

-- Test function
SELECT Sales.FetchWebsite('1');
GO

SELECT Sales.FetchWebsite('5');
GO

DROP FUNCTION Sales.FetchWebsite;

-- Create function to add up total quantity sold across orders

CREATE FUNCTION udfQuantitySold (@StockID int)
RETURNS int
BEGIN
DECLARE @QuantitySold int
SELECT @QuantitySold = SUM(Sales.OrderLines.Quantity)
	FROM Warehouse.StockItems
		INNER JOIN Sales.OrderLines
		ON Warehouse.StockItems.StockItemID = Sales.OrderLines.StockItemID
	WHERE Warehouse.StockItems.StockItemID = Sales.OrderLines.StockItemID
	RETURN @QuantitySold;
END;
GO

-- Apply to a single product
SELECT dbo.udfQuantitySold('5');
GO

-- Use in a table column to generate total sales across all products
SELECT Warehouse.StockItems.StockItemName,
	   dbo.udfQuantitySold(Warehouse.StockItems.StockItemID) AS QuantityeSold
FROM Warehouse.StockItems
ORDER BY QuantityeSold DESC;
GO

DROP FUNCTION dbo.udfQuantitySold;
GO