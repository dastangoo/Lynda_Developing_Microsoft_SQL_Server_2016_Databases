-- Use WideWorldImporters database
USE WideWorldImporters;
GO

-- Explore Application.PaymentMethod table
SELECT * FROM Application.PaymentMethods;
GO 

-- PayementMethodID 4 is used for EFT: Electronic Funds Transfer

-- Explore Sales.CustomerTransactions
SELECT * FROM Sales.CustomerTransactions;
GO 

SELECT * FROM Sales.CustomerTransactions
WHERE PaymentMethodID = 4;
GO

-- Create an index
CREATE NONCLUSTERED INDEX IX_EFT_Transactions
ON Sales.CustomerTransactions (CustomerTransactionID);
GO

-- View the stats for the index
DBCC Show_Statistics ('Sales.CustomerTransactions', 'IX_EFT_Transactions');
GO

DROP INDEX IX_EFT_Transactions
ON Sales.CustomerTransactions;
GO

CREATE NONCLUSTERED INDEX IX_EFT_Transactions
ON Sales.CustomerTransactions (CustomerTransactionID)
WHERE PaymentMethodID = 4;
GO

-- View the stats for the index
DBCC Show_Statistics ('Sales.CustomerTransactions', 'IX_EFT_Transactions');
GO

-- Run a select query
SELECT CustomerTransactionID
FROM Sales.CustomerTransactions
WHERE PaymentMethodID = 4;
GO

DROP INDEX IX_EFT_Transactions
ON Sales.CustomerTransactions;

