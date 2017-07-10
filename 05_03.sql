-- Create a new database 
CREATE DATABASE LoginlessUsers;
GO
USE LoginlessUsers;
GO

-- Create a data table and populate with values
CREATE TABLE Employees (
	EmployeeID int IDENTITY(1000,1) PRIMARY KEY,
	EmployeeName nvarchar(100) NOT NULL,
	EmployeePhone nvarchar(8) NULL,
	EmployeeSalary smallmoney
);
GO
 
INSERT Employees
	VALUES ('Malcom', '555-0123', 2500.00),
		   ('Rory', '555-1234', 3200.00),
		   ('Brianne', '555-7890', 1950.00);
GO

SELECT * FROM Employees;
GO

-- Create a view of a data table
CREATE VIEW EmployeePhoneNumbers
AS 
	SELECT EmployeeName, EmployeePhone
	FROM Employees;
GO 

SELECT * FROM EmployeePhoneNumbers;
GO

-- Create role and assign permissions
CREATE ROLE QueryObjects;
GO

GRANT SELECT ON EmployeePhoneNumbers
TO QueryObjects;
GO

-- Create loginless user
CREATE USER LoginlessJoe WITHOUT LOGIN;
GO

-- Assign user to role
ALTER ROLE QueryObjects ADD MEMBER LoginlessJoe;
GO

-- Switch security context
EXECUTE AS USER = 'LoginlessJoe';
GO

-- Check the current security context
SELECT USER_NAME();

-- Select objects as LoginlessJoe
SELECT * FROM EmployeePhoneNumbers;
GO

SELECT * FROM Employees;
GO

-- switch security context back to original user
REVERT;
GO
SELECT USER_NAME();
GO

SELECT * FROM EmployeePhoneNumbers;
GO

SELECT * FROM Employees;
GO

-- Clean up the server
USE tempdb;
GO
DROP DATABASE LoginlessUsers;
GO
