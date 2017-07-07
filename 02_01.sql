-- Switch the active database
USE PartitionTables;
GO

-- Create partition function:
CREATE PARTITION FUNCTION PFYears (smallint)
AS RANGE LEFT 
FOR VALUES (2015, 2016, 2017);
GO

-- Create partition scheme 
CREATE PARTITION SCHEME PSYears 
AS PARTITION PFYears
TO (FG_2015, FG_2016, FG_2017, FG_2018);
GO

-- Create table within partition scheme
CREATE TABLE dbo.Orders (
	OrderYear smallint NOT NULL,
	OrderID int IDENTITY(1,1) NOT NULL,
	PRIMARY KEY (OrderYear, OrderID))
	ON PSYears (OrderYear);
GO

-- Insert values into table
INSERT dbo.Orders
	VALUES (2015),
		   (2015),
		   (2016),
		   (2018);
GO

SELECT * FROM dbo.Orders;
GO

-- View the number of records in each partition using a system function
SELECT $PARTITION.PFYears(OrderYear) AS Partition,
	COUNT(*) AS [COUNT] FROM dbo.Orders
	GROUP BY $PARTITION.PFYears(OrderYear)
	ORDER BY Partition;
GO

-- View all of the records on a specified parition (4)
SELECT * FROM dbo.Orders
	WHERE $PARTITION.PFYears(OrderYear) = 3;
GO

-- Delete database 
USE tempdb;
GO
DROP DATABASE PartitionTables;
GO