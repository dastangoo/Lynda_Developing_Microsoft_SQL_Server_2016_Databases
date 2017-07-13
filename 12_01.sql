-- Use the WideWorldImporters database
USE WideWorldImporters;
GO

-- Detect fragmentation on an index
SELECT * FROM sys.dm_db_index_physical_stats
		(DB_ID('WideWorldImporters'), OBJECT_ID('Purchasing.PurchaseOrderLines'), NULL, NULL, 'DETAILED');
GO

SELECT * FROM sys.indexes
WHERE object_id = 1554104577
GO

-- For fragmentation between 5% and 30%:
-- ALTER INDEX FK_Purchasing_PurchaseOrderLines_StockItemID
-- ON Purchasing.PurchaseOrderLines
-- REORGANiZE

-- For fragmentation above 30%
-- Rebuild index to remove fragmentaition
ALTER INDEX FK_Purchasing_PurchaseOrderLines_StockItemID
ON Purchasing.PurchaseOrderLines
REBUILD WITH (ONLINE = ON);

SELECT * FROM sys.dm_db_index_physical_stats
		(DB_ID('WideWorldImporters'), OBJECT_ID('Purchasing.PurchaseOrderLines'), '3', NULL, 'DETAILED');
GO

