-- Make a new database
CREATE DATABASE UnderstandCollation;
GO
USE UnderstandCollation;
GO

-- Check the current server collation
SELECT SERVERPROPERTY('Collation') AS ServerCollation;
GO

-- Check the current database's collation
SELECT DATABASEPROPERTYEX('UnderstandCollation', 'Collation');
GO

-- Create a table to explore collation options
CREATE TABLE dbo.CollationExample (
	myID int IDENTITY(1,1) PRIMARY KEY,
	myValue nchar(1) NOT NULL
);
GO

INSERT dbo.CollationExample
	VALUES ('a'),
		   ('A'),
		   ('a'),
		   ('A'),
		   ('a'),
		   ('1'),
		   ('2'),
		   ('1'),
		   ('A'),
		   ('a'),
		   ('1'),
		   ('A'),
		   ('a');
GO

SELECT * FROM dbo.CollationExample;
GO

SELECT * FROM dbo.CollationExample
ORDER BY myValue;
GO

SELECT * FROM dbo.CollationExample
	ORDER BY myValue
	COLLATE SQL_Latin1_General_CP1_CS_AS;
GO

SELECT * FROM dbo.CollationExample
	ORDER BY myValue
	COLLATE SQL_Latin1_General_CP1_CI_AI;
GO

-- Case insensitivty prevents the creation of similarly named objects
CREATE TABLE SameNames (
	myName int,
	MyName int,
	MYNAME int,
	myname int
);
GO

SELECT * FROM SameNames;
GO

SELECT * FROM SAMENAMES;
GO

-- Alter the database collation so that it becomes case-sensitive:
ALTER DATABASE UnderstandCollation
COLLATE SQL_Latin1_General_CP1_CS_AS;
GO

-- Delete database
USE tempdb;
GO
DROP DATABASE UnderstandCollation;
GO