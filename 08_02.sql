-- Create a new database
CREATE DATABASE MemoryOptimizedTables;
GO
USE MemoryOptimizedTables;
GO

-- Add a memory optimized filegroup
ALTER DATABASE MemoryOptimizedTables ADD FILEGROUP mot_mod CONTAINS memory_optimized_data
GO

-- Give the filegroup a location on disk for durability 
ALTER DATABASE MemoryOptimizedTables
	ADD FILE (
		NAME = 'mot_mod',
		FILENAME = 'C:\MemoryTemp\mot_mod')
	TO FILEGROUP mot_mod;
GO

-- Create a memory optimized table
CREATE TABLE dbo.MemTable (
	OrderID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	CustomerName char(50),
	ProductOrdered char(50))
WITH (memory_optimized = on)
GO

CREATE TABLE dbo.MemTable (
	OrderID int IDENTITY(1,1) PRIMARY KEY NONCLUSTERED NOT NULL,
	CustomerName char(50),
	ProductOrdered char(50))
WITH (memory_optimized = on)
GO

INSERT INTO dbo.MemTable
VALUES ('Adam', 'Peanuts'),
	   ('Kevin', 'Almonds')
;
GO

SELECT * FROM dbo.MemTable;
GO

-- Retrieve the path of the DLL for dbo.MemTable
SELECT name, description
FROM sys.dm_os_loaded_modules
WHERE name like '%xtp_t_' + cast(db_id() as varchar(10)) + '_' 
	+ cast(object_id('dbo.MemTable') as varchar(10)) + '%'
GO

-- Clean up the server instance
USE tempdb;
GO
DROP DATABASE MemoryOptimizedTables;
GO
