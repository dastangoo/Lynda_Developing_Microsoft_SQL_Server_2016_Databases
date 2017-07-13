-- After enabling filestream for server instance in SQL Server Configuration Manager
EXEC sp_configure filestream_access_level, 2
GO

RECONFIGURE
GO

-- Create a new database with a filestream filegroup 
CREATE DATABASE FS_Example 
ON 
PRIMARY ( NAME = fg_data,
					FILENAME = 'C:\FS_Temp\fgdata.mdf'),
		  FILEGROUP FileStreamGroup1 CONTAINS FILESTREAM ( NAME = fs1, 
					FILENAME = 'C:\FS_Temp\Filestream_Data')
		  Log ON ( NAME = fg_log, 
					FILENAME = 'C:\FS_Temp\fglog.ldf')
GO

USE FS_Example;
GO

CREATE TABLE dbo.BusinessDocuments (
	DocumentID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	DocumentName nvarchar(100) NOT NULL,
	DocumentType char(3) NOT NULL,
	DocumentFile varbinary(max) FILESTREAM NOT NULL
);
Go

CREATE TABLE dbo.BusinessDocuments (
	DocumentGUID UNIQUEIDENTIFIER ROWGUIDCOL DEFAULT NEWID() PRIMARY KEY NOT NULL,
	DocumentName nvarchar(100) NOT NULL,
	DocumentType char(3) NOT NULL,
	DocumentFile varbinary(max) FILESTREAM NOT NULL
);
Go

-- Add a file to the filestream enabled table
INSERT BusinessDocuments (DocumentName, DocumentType, DocumentFile)
VALUES 
	('Aghrab', 'pdf', 
		(SELECT * 
		FROM OPENROWSET 
			(BULK 'C:\Users\Administrator.WINSRV16\Downloads\aghrab.pdf', SINGLE_BLOB) document));
GO

SELECT * FROM BusinessDocuments;
GO


