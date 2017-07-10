-- Create a new database
CREATE DATABASE UserRolesExample;
GO
USE UserRolesExample;
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

-- Create a view of data table
CREATE VIEW EmployeePhoneNumbers
AS 
	SELECT EmployeeName, EmployeePhone
	FROM Employees;
GO

SELECT * FROM EmployeePhoneNumbers;
GO


-- Create user at the SQL Server login level, then add the database
CREATE USER JamieTemp;
GO

-- Create role and assign permissions
CREATE ROLE ViewOnly;
GO

REVOKE SELECT ON Employees
TO ViewOnly;
GO

GRANT SELECT ON EmployeePhoneNumbers
TO ViewOnly;
GO

-- Assign user to role
ALTER ROLE ViewOnly ADD MEMBER JamieTemp;
GO

-- Disconnect and reconnect as JamieTemp to check permissions
SELECT * FROM EmployeePhoneNumbers;
GO

SELECT * FROM Employees;
GO

-- log back in as dbo to clean up the server
USE tempdb;
GO
DROP DATABASE UserRolesExample;
GO