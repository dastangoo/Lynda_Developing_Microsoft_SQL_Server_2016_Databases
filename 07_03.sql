-- Switch to the WideWorldImporters database
USE WideWorldImporters;
GO

-- Create procedure with parameter
CREATE PROCEDURE Warehouse.uspSelectProductByColor
	@paramColor char(20)
AS
SELECT Warehouse.StockItems.StockItemID,
	   Warehouse.StockItems.StockItemName,
	   Warehouse.StockItemHoldings.QuantityOnHand,
	   Warehouse.StockItems.RecommendedRetailPrice,
	   Warehouse.Colors.ColorName
FROM   Warehouse.Colors INNER JOIN 
	   Warehouse.StockItems ON Warehouse.Colors.ColorID = Warehouse.StockItems.ColorID INNER JOIN
	   Warehouse.StockItemHoldings ON Warehouse.StockItems.StockItemID = Warehouse.StockItemHoldings.StockItemID
WHERE ColorName = @paramColor
;
GO

-- Execute the stored procedure with various parameters
EXEC Warehouse.uspSelectProductByColor 'Black';
GO
EXEC Warehouse.uspSelectProductByColor 'Blue';
GO
EXEC Warehouse.uspSelectProductByColor;
GO

-- Alter the procedure to include a default value and error handling
ALTER PROCEDURE Warehouse.uspSelectProductByColor
	@paramColor char(20) = NULL
AS
IF @paramColor IS NULL
BEGIN 
	PRINT 'A valid product color is required'
	RETURN
END
SELECT Warehouse.StockItems.StockItemID,
	   Warehouse.StockItems.StockItemName,
	   Warehouse.StockItemHoldings.QuantityOnHand,
	   Warehouse.StockItems.RecommendedRetailPrice,
	   Warehouse.Colors.ColorName
FROM   Warehouse.Colors INNER JOIN 
	   Warehouse.StockItems ON Warehouse.Colors.ColorID = Warehouse.StockItems.ColorID INNER JOIN
	   Warehouse.StockItemHoldings ON Warehouse.StockItems.StockItemID = Warehouse.StockItemHoldings.StockItemID
WHERE ColorName = @paramColor
;
GO

EXECUTE Warehouse.uspSelectProductByColor;
GO

EXECUTE Warehouse.uspSelectProductByColor 'Red';
GO

-- Clean up the WideWorldImporters database
DROP PROCEDURE Warehouse.uspSelectProductByColor;
GO

