USE WideWorldImporters;
GO

-- View the execution plan for the following query
SELECT PersonID, Fullname, EmailAddress
FROM Application.People;
GO

-- View the records in another table
SELECT * FROM Purchasing.PurchaseOrders;
GO

SELECT OrderDate, DeliveryMethodID, ExpectedDeliveryDate
FROM Purchasing.PurchaseOrders
WHERE OrderDate BETWEEN '2016-01-01' AND '2016-03-31'
ORDER BY OrderDate DESC;
GO

-- Create index on OrderDate, include delivery method and date
CREATE INDEX IX_Purchasing_PurchaseOrders_OrderDate
ON Purchasing.PurchaseOrders (OrderDate)
INCLUDE (DeliveryMethodID, ExpectedDeliveryDate);
GO 

DROP INDEX IX_Purchasing_PurchaseOrders_OrderDate
ON Purchasing.PurchaseOrders;