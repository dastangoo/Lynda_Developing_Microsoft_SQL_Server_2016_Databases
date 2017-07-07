-- Make a new database
CREATE DATABASE TemporaryTables;
GO
USE TemporaryTables;
GO

-- Create temporary table to store books
CREATE TABLE #tmpBooks (
	ISBN char(16) PRIMARY KEY,
	Title nvarchar(100) NOT NULL,
	AuthorFirstName nvarchar(50) NULL,
	AuthorLastName nvarchar(50) NOT NULL
);
GO

-- Insert values into the books temporary table
INSERT #tmpBooks
	VALUES ('1', 'Anna Karenina', 'Leo', 'Tolstoy'),
		   ('2', 'War and Peace', 'Leo', 'Tolstoy'),
		   ('3', 'Ulysses', 'James', 'Joyce'),
		   ('4', 'Emma', 'Jane', 'Austin'),
		   ('5', 'Price and Prejudice', 'Jane', 'Austin');
GO

SELECT * FROM #tmpBooks;
GO

-- Close query window, log off and back on, then query the table again
USE TemporaryTables;
GO
SELECT * FROM #tmpBooks;
GO

-- Delete database
USE tempdb;
GO 
DROP DATABASE TemporaryTables;
GO