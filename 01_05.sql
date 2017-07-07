-- Create a new database
CREATE DATABASE CalculatedColumns;
GO
USE CalculatedColumns;
GO

-- Create a table with a computed column
CREATE TABLE dbo.Products (
	ProductID int IDENTITY(1,1) PRIMARY KEY,
	ProductName nvarchar(100) NOT NULL,
	ProductPrice smallmoney NOT NULL,
	ProductDiscount decimal(2,2) NOT NULL,
	ProductExtendedPrice AS ProductPrice - (ProductPrice * ProductDiscount)
);
GO

INSERT dbo.Products
	VALUES ('Mixed Nuts', 3.99, .15),
		   ('Shelled Peanuts', 5.49, .10),
		   ('Roasted Almonds', 7.29, 0);
GO

SELECT * FROM dbo.Products
GO

-- Alter table to include tax calculation
ALTER TABLE dbo.Products
	ADD TaxRate decimal(4,4) NOT NULL DEFAULT(.0875),
		TotalPrice AS (ProductExtendedPrice + (ProductExtendedPrice * TaxRate));
GO

-- Calculate TotalPrice from scratch
ALTER TABLE dbo.Products
	ADD TaxRate decimal(4,4) NOT NULL DEFAULT(0.0875),
		TotalPrice AS (ProductPrice - (ProductPrice * ProductDiscount) + ((ProductPrice - (ProductPrice * ProductDiscount)) * TaxRate));
GO 

SELECT * FROM dbo.Products;
GO

CREATE TABLE dbo.Departments (
	DepartmentLocation char(2) NOT NULL,
	DepartmentCode char(3) NOT NULL,
	DepartmentID AS DepartmentLocation + '-' + DepartmentCode PRIMARY KEY NOT NULl
);
GO

CREATE TABLE dbo.Departments (
	DepartmentLocation char(2) NOT NULL,
	DepartmentCode char(3) NOT NULL,
	DepartmentID AS DepartmentLocation + '-' + DepartmentCode PERSISTED PRIMARY KEY NOT NULL
);
GO

INSERT dbo.Departments 
	VALUES ('BT','447'),
		   ('CT','193'),
		   ('DT','182');
GO

SELECT * FROM dbo.Departments;
GO

-- Clean up the server instance
USE tempdb;
GO
DROP DATABASE CalculatedColumns;
GO