-- Create a new database
CREATE DATABASE XMLDatabase;
GO
USE XMLDatabase;
GO

-- Create a table to hold a book catalog in XML format
CREATE TABLE Catalog (
	CatalogID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	CatalogData XML
);
GO

DECLARE @varBook XML
SET @varBook = 
'<book id="bk109">
	<author>Kress, Peter</author>
	<title>Paradax Last</title>
	<genre>Science Fiction</genre>
	<price>6.95</price>
	<publish_date>2000-11-02</publish_date>
	<description>After an inadvertent trip through a Heisenberg Uncertainty Device, James Salway discovers ...</description>
</book>'

INSERT INTO Catalog (CatalogData)
VAlUES (@varBook);
GO

SELECT * FROM Catalog;
GO

SELECT CatalogData.query('/book[@id="bk109"]') FROM Catalog;
GO

-- Clean up the server
USE WideWorldImporters;
GO
DROP DATABASE XMLDatabase;
GO

SELECT * FROM dbo.CustomerOrders
WHERE StateProvinceName = 'California'
FOR XML Auto, ROOT('CaliforniaCustomers'), ELEMENTS


