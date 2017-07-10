-- Switch the active database
USE WideWorldImporters;
GO

-- View schemas in object Explorer, then 
-- create role and assign permissions

CREATE ROLE WarehouseAuditor;
GO

GRANT SELECT ON SCHEMA::Warehouse
TO WarehouseAuditor;
GO

-- Create loginless user and switch security context
CREATE USER LoginlessJoe WITHOUT LOGIN;
GO
EXECUTE AS USER = 'LoginlessJoe';
GO

-- Select objects as loginlessJoe
SELECT * FROM Warehouse.StockItemHoldings;
GO

-- Switch security context back to original user
REVERT;
GO
SELECT USER_NAME();


-- Assign user to role
ALTER ROLE WarehouseAuditor ADD MEMBER LoginlessJoe;
GO

EXECUTE AS USER = 'LoginlessJoe';
GO
SELECT USER_NAME();
GO

-- Explore the database as LoginlessJoe
SELECT * FROM Warehouse.StockItemHoldings;
GO

INSERT Warehouse.Colors(ColorID, ColorName, LastEditedBy)
	VALUES (37, 'Pistachio', 1);
GO



