-- Create a new database
CREATE DATABASE BinaryLargeObjects;
GO
USE BinaryLargeObjects;
GO

SELECT *
FROM OPENROWSET (BULK 'C:\Users\Administrator.WINSRV16\Downloads\aghrab.pdf', SINGLE_BLOB) document
GO


CREATE TABLE dbo.BusinessDocuments (
	DocumentID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	DocumentName nvarchar(100) NOT NULL,
	DocumentType char(3) NOT NULL,
	DocumentFile varbinary(max) NOT NULL
);
GO


INSERT BusinessDocuments (DocumentName, DocumentType, DocumentFile)
VALUES
	('Aghrab', 'pdf', 
		(SELECT * 
		FROM OPENROWSET 
			(BULK 'C:\Users\Administrator.WINSRV16\Downloads\aghrab.pdf',SINGLE_BLOB) document));
GO

SELECT * FROM BusinessDocuments;
GO

-- Clean up the server 
USE tempdb
GO
DROP DATABASE BinaryLargeObjects;
GO

