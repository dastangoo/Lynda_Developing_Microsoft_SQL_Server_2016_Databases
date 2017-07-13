-- Use the WideWorldImporters
USE WideWorldImporters;
GO

-- Create a table valued fucntion to select total sales per products by color
CREATE FUNCTION dbo.udfTotalSalesByColor (@varColor char(20))
RETURNS TABLE
AS 
RETURN (
SELECT Warehouse.StockItems.StockItemName, 
	   SUM(Sales.InvoiceLines.Quantity * Sales.InvoiceLines.UnitPrice) AS Total,
	   Warehouse.Colors.ColorName
FROM Sales.Invoices INNER JOIN 
	 Sales.InvoiceLines ON Sales.Invoices.InvoiceID = Sales.InvoiceLines.InvoiceID INNER JOIN
	 Warehouse.StockItems ON Sales.InvoiceLines.StockItemID = Warehouse.StockItems.StockItemID INNER JOIN
	 Warehouse.Colors ON Warehouse.StockItems.ColorID = Warehouse.Colors.ColorID
GROUP BY Warehouse.StockItems.StockItemName, Warehouse.Colors.ColorName
HAVING Warehouse.Colors.ColorName = @varColor
);
GO

SELECT StockItemName, ColorName, Total
FROM dbo.udfTotalSalesByColor('Blue')
ORDER BY Total DESC;

-- Clean up the database
DROP FUNCTION dbo.udfTotalSalesByColor;
GO


