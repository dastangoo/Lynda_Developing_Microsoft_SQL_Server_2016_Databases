-- Create a new database
CREATE DATABASE MemoryOptimizedProcedures;
GO
USE MemoryOptimizedProcedures;
GO

ALTER DATABASE MemoryOptimizedProcedures ADD FILEGROUP mop_mod CONTAINS memory_optimized_data
GO

ALTER DATABASE MemoryOptimizedProcedures
	ADD FILE (
		NAME = 'mop_mod', 
		FILENAME = 'C:\MemoryTemp\mop_mod')
	TO FILEGROUP mop_mod
GO

-- Create a disk based table
CREATE TABLE dbo.DiskTable (
	OrderNumber int PRIMARY KEY NONCLUSTERED);
GO

-- Create a memory optimized table
CREATE TABLE dbo.MemTable (
	OrderNumber int PRIMARY KEY NONCLUSTERED)
WITH (memory_optimized = on);
GO

-- Create a stored procedure to insert values to the disk based table
CREATE PROCEDURE dbo.FiftyKRowsDisk
AS 
DECLARE @i int;
SET @i = 50000;
WHILE @i > 0
	BEGIN 
		Insert dbo.DiskTable values (@i)
		Set @i -= 1
	END
GO

EXECUTE dbo.FiftyKRowsDisk;
GO

-- View the contents of the table
SELECT * FROM dbo.DiskTable 

-- Create a native stored prcedure to insert rows into the memory optimized table
CREATE PROCEDURE dbo.FiftyKRowsMem
WITH native_compilation, schemabinding
AS
BEGIN ATOMIC
WITH(transaction isolation level=snapshot, language=N'us_english')
DECLARE @i int
SET @i = 50000
WHILE @i > 0
	BEGIN 
		Insert dbo.MemTable values (@i)
		Set @i -= 1
	END
END
GO

EXECUTE dbo.FiftyKRowsMem;
GO

SELECT * FROM dbo.MemTable
ORDER BY OrderNumber;
GO

-- Clean up the server instance
USE tempdb;
GO
DROP DATABASE MemoryOptimizedProcedures;
GO