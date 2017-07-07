USE WideWorldImporters;
GO

-- View compression settings for objects in the database
SELECT S.name AS SchemaName, O.name AS ObjectName, I.name AS IndexName,
	I.type_desc AS IndexType, P.data_compression_desc AS Compression
	FROM sys.schemas AS S JOIN sys.objects AS O
	ON S.schema_id = O.schema_id JOIN sys.indexes AS I
	ON O.object_id = I.object_id JOIN sys.partitions AS P
	ON I.object_id = P.object_id AND I.index_id = P.index_id
	WHERE O.type = 'U'
	ORDER BY S.name, O.name, I.index_id;
GO

-- Estimate compression using a system stored procedure
EXEC sp_estimate_data_compression_savings
	@schema_name = 'Purchasing',
	@object_name = 'PurchaseOrderLines',
	@index_id = NULL,
	@partition_number = NULL,
	@data_compression = 'Page';
GO

-- Alter a table to enable compression
ALTER TABLE Purchasing.PurchaseOrderLines 
	REBUILD with (DATA_COMPRESSION = Page);

-- Create a new table with compression enabled
CREATE TABLE NewCompressedTable (
	FirstColumn int,
	SecondColumn varchar(50))
WITH (DATA_COMPRESSION = Page);
GO