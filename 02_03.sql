-- Make a new database
CREATE DATABASE TableVariables;
GO
USE TAbleVariables;
GO

-- Create table variable to store authors
DECLARE @tmpAuthors TABLE (
	AuthorID int IDENTITY(1000,1) PRIMARY KEY,
	AuthorFirstName nvarchar(50) NULL,
	AuthorLastName nvarchar(50) NOT NULL
);

-- Insert values into the author table
INSERT @tmpAuthors 
	VALUES ('Leo', 'Tolstoy'),
		   ('James', 'Joyce'),
		   ('Jane', 'Austin');

SELECT * FROM @tmpAuthors;
GO

-- Create and use table variable in a single batch
DECLARE @tmpAuthors TABLE (
	AuthorID int IDENTITY(1000,1) PRIMARY KEY,
	AuthorFirstName nvarchar(50) NULL,
	AuthorLastName nvarchar(50) NOT NULL
);

INSERT @tmpAuthors 
	VALUES ('Leo', 'Tolstoy'),
		   ('James', 'Joyce'),
		   ('Jane', 'Austin');

DECLARE @tmpBooks TABLE (
	ISBN char(16) PRIMARY KEY,
	Title nvarchar(100) NOT NULL,
	AuthorID int NOT NULL
);

INSERT @tmpBooks 
	VALUES ('1', 'Anna Karenina', '1000'),
		   ('2', 'Ware and Peace', '1000'),
		   ('3', 'Ulysses', '1001'),
		   ('4', 'Emma', '1002'),
		   ('5', 'Price and Prejudice', '1001');

SELECT * 
	FROM @tmpBooks B 
	JOIN @tmpAuthors A
	ON B.AuthorID = A.AuthorID;

GO

-- Delete database
USE tempdb;
GO
DROP DATABASE TableVariables;
GO
