-- Use WideWorldImporters database
USE WideWorldImporters;
GO

-- Identify a query that is performed regularly
SELECT * FROM Purchasing.PurchaseOrderLines
WHERE PurchaseOrderID = 1655 AND StockItemID = 95;

-- Create a nonclusterd index on a table using two columns
CREATE INDEX IX_Purchasing_PurchaseOrderLines_PurchaseOrderID_StockItemID
ON Purchasing.PurchaseOrderLines (PurchaseOrderID ASC, StockItemID ASC);

-- Execute the query again and investigate the execution plan
SELECT * FROM Purchasing.PurchaseOrderLines
WHERE PurchaseOrderID = 1655 AND StockItemID = 95;

SELECT PurchaseOrderLineID, PurchaseOrderID, StockItemID
FROM Purchasing.PurchaseOrderLines
WHERE PurchaseOrderID = 1655 AND StockItemID = 95;

DROP INDEX IX_Purchasing_PurchaseOrderLines_PurchaseOrderID_StockItemID
ON Purchasing.PurchaseOrderLines

