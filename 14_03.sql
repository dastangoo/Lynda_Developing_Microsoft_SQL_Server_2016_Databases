-- Create a new database
CREATE DATABASE ActivityMonitorExample;
GO
USE ActivityMonitorExample;
GO

CREATE TABLE dbo.DiskTable (
	OrderNumber int PRIMARY KEY NONCLUSTERED);
GO

CREATE PROC dbo.FiftyKRowDisk
AS
DECLARE @i int
SET @i = 5000
WHILE @i > 0
	BEGIN 
		Insert dbo.DiskTable values (@i)
		Set @i -= 1
	END
GO

-- View the contents of the table
SELECT * FROM dbo.DiskTable;
GO

-- Clean up the server instance
USE tempdb;
GO
DROP DATABASE ActivityMonitorDB;
GO