-- Use the WideWorldImporters databases
USE WideWorldImporters;
GO

-- Run a query and view the execution plan
SELECT Purchasing.PurchaseOrderLines.PurchaseOrderID,
	   Purchasing.PurchaseOrderLines.PurchaseOrderLineID,
	   Warehouse.StockItems.StockItemID,
	   Warehouse.Colors.ColorName
FROM Purchasing.PurchaseOrderLines INNER JOIN 
	 Purchasing.PurchaseOrders ON Purchasing.PurchaseOrderLines.PurchaseOrderID = Purchasing.PurchaseOrders.PurchaseOrderID INNER JOIN
	 Warehouse.StockItems ON Purchasing.PurchaseOrderLines.StockItemID = Warehouse.StockItems.StockItemID INNER JOIN
	 Warehouse.Colors ON Warehouse.StockItems.ColorID = Warehouse.Colors.ColorID
WHERE ColorName = 'Black'
;
GO