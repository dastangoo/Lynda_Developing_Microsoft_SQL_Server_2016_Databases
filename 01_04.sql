-- Create a new database for this example
CREATE database SchemaDemo;
GO
USE SchemaDemo;
GO

-- Create table to store authors
CREATE TABLE Authors (
	AuthorID int IDENTITY (1000,1) PRIMARY KEY,
	AuthorFirstName nvarchar(50) NULL,
	AuthorLastName nvarchar(50) NOT NULL
);
GO

-- Review schemas in SSMS Object Explorer, then remove table
DROP TABLE Authors;
GO

-- Create a new schema
CREATE SCHEMA Publications AUTHORIZATION dbo;
GO

-- Recreate table under new schema
CREATE TABLE Publications.Authors (
AuthorID int IDENTITY(1000,1) PRIMARY KEY,
AuthorFirstName nvarchar(50) NULL,
AuthorLastName nvarchar(50) NOT NULL
);
GO

SELECT AuthorID, AuthorFirstName, AuthorLastName
FROM Publications.Authors;
GO

-- Move table from one schema to another
CREATE SCHEMA People AUTHORIZATION dbo;
GO

ALTER SCHEMA People TRANSFER Publications.Authors;
GO

-- View all tables within a schema
USE WideWorldImporters;
GO

SELECT sys.schemas.name AS SchemaName, sys.tables.name AS TableName
	FROM sys.tables
	INNER JOIN sys.schemas
	ON sys.tables.schema_id = sys.schemas.schema_id
    WHERE sys.schemas.name = N'Sales';
GO

-- Clean up the server instance
USE tempdb;
GO
DROP database SchemaDemo;
GO


