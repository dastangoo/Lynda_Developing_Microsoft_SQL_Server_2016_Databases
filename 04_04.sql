-- Create a new database
CREATE DATABASE DMLTrigger;
GO
USE DMLTrigger;
GO

-- Create a table to store products and current inventory
CREATE TABLE dbo.Products (
	ProductID int IDENTITY(1,1) PRIMARY KEY,
	ProductName varchar(100) NOT NULL,
	InventoryQuantity smallint NOT NULL,
	CHECK (InventoryQuantity >= 0)
);
GO

-- Insert values and base stock quantities
INSERT dbo.Products
	VALUES ('Mixed Nuts', 12),
		   ('Shelled Peanuts', 12),
		   ('Roasted Almonds', 12);

-- Create an order table
CREATE TABLE dbo.Orders (
	OrderID int IDENTITY(1,1) PRIMARY KEY,
	CustomerName varchar(100) NOT NULL,
	ProductName varchar(100) NOT NULL,
	QuantityOrdered smallint NOT NULL
);
GO

-- Create DML to remove stock when orders are passed
CREATE TRIGGER dbo.InventoryTrigger ON dbo.Orders
	AFTER INSERT 
	AS 
		UPDATE dbo.Products
		SET InventoryQuantity = (dbo.Products.InventoryQuantity - NewRow.QuantityOrdered)
		FROM (SELECT Orders.ProductName,
				     SUM(QuantityOrdered) as QuantityOrdered
					 FROM dbo.Orders
					 GROUP BY Orders.ProductName
					 HAVING SUM(QuantityOrdered) <> 0 

		) AS NewRow
	WHERE dbo.Products.ProductName = NewRow.ProductName
;
GO

-- Insert an order from a customer
INSERT dbo.Orders
	VALUES ('Jeremy', 'Mixed Nuts', 3),
		   ('Juanita', 'Roasted Almonds', 12);
GO

-- Verify stock on hand
SELECT * 
FROM dbo.Products;
GO

-- Insert a large order
INSERT dbo.Orders
	VALUES('Jeremy', 'Shelled Peanuts', 25);
GO

-- Verify stock on hand
SELECT * FROM dbo.Products;
GO

-- Verify the order was not saved
SELeCT * FROM dbo.Orders;
GO

-- clean up server
USE tempdb;
GO
DROP DATABASE DMLTrigger;
GO