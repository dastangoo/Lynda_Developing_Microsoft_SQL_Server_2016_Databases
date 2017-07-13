-- Create a new database
CREATE DATABASE ImplementSparseColumns;
GO
USE ImplementSparseColumns;
GO

-- Create a table
CREATE TABLE People (
	PersonID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	FirstName nvarchar(40),
	LastName nvarchar(40),
	Suffix char(5),
	AddressLine1 nvarchar(50),
	AddressLine2 nvarchar(50),
	City nvarchar(20), 
	State char(2),
	Zip char(5)
);
GO

CREATE PROCEDURE InsertPeople
AS
DECLARE @i int
SET @i = 5000
WHILE @i > 0
	BEGIN 
		INSERT People (FirstName) VALUES (@i)
		SET @i -= 1
	END
GO

EXECUTE InsertPeople;
GO

SELECT * FROM People
GO

EXEC sp_spaceused People
GO

CREATE TABLE People2 (
	PersonID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	FirstName nvarchar(40),
	LastName nvarchar(40),
	Suffic char(5) SPARSE,
	AddressLine1 nvarchar(50),
	AddressLine2 nvarchar(50) SPARSE,
	City nvarchar(20),
	State char(2),
	Zip char(5)
);

CREATE PROC InsertPeople2
AS 
DECLARE @i int
SET @i = 5000
WHILE @i > 0
	BEGIN 
		INSERT People2 (FirstName) VALUES (@i)
		SET @i -= 1
	END
GO
EXECUTE InsertPeople2;
GO 

SELECT * FROM People2;
GO

-- Inspect the size of the table
EXEC sp_spaceused People2
GO

-- Clean up the server
USE tempdb
GO
DROP DATABASE ImplementSparseColumns;
GO 