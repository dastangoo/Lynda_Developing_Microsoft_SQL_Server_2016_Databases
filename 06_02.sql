-- Create a new database
CREATE DATABASE GlobalIdentifier;
GO
USE GlobalIdentifier;
GO


-- Create a data table to products with GUIDs
CREATE TABLE Products (
	ProductGUID UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
	ProductInt int IDENTITY(1,1) NOT NULL,
	ProductName nvarchar(100) NOT NULL
);
GO

INSERT Products (ProductName)
VALUES ('Salted Cashews'),
	   ('Honey Glazed Almonds'),
	   ('Shelled Pistachios');
GO

SELECT * FROM Products;
GO

-- Create a table for additional products
CREATE TABLE NewProducts (
	ProductGUID UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
	ProductInt int IDENTITY(1,1) NOT NULL,
	ProductName nvarchar(100) NOT NULL
);
GO

INSERT NewProducts (ProductName)
VALUES ('Spanish Peanuts'),
	   ('Macadamia Nuts');
GO

-- View all products together
SELECT * FROM Products
UNION ALL 
SELECT * FROM NewProducts;
GO

-- Convert the ProductID column into the table's Primary Key 
ALTER TABLE Products 
ADD CONSTRAINT PK_ProductGUID PRIMARY KEY (ProductGUID);
GO

INSERT Products (ProductGUID, ProductName)
	SELECT ProductGUID, ProductName
	FROM NewProducts;
GO

SELECT * FROM Products
ORDER BY ProductInt
GO

-- Clean up the server
USE tempdb;
GO
DROP DATABASE GlobalIdentifier;
GO