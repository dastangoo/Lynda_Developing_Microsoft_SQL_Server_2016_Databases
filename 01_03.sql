-- Switch to the temporary database
USE tempdb;
GO

-- Create tables to store books and their authors
CREATE TABLE Authors (
	AuthorID int IDENTITY(1000,1) PRIMARY KEY,
	AuthorFirstName nvarchar(50) NULL,
	AuthorLastName nvarchar(50) NOT NULL
);
GO

CREATE TABLE Books (
	ISBN char(13) PRIMARY KEY,
	Title nvarchar(100) NOT NULL,
	AuthorID int NOT NULL
		FOREIGN KEY REFERENCES Authors (AuthorID)
);
GO

-- Insert values into both tables
INSERT Authors
	VALUES ('Leo', 'Tolstoy'),
		   ('James','Joyce'),
		   ('Jane','Austin');
GO

SELECT * FROM Authors;
GO

INSERT Books 
	VALUES ('1','Anna Karenina', '1000'),
		   ('2', 'War and Peace', '1000'),
		   ('3', 'Ulysses', '1001'),
		   ('4', 'Emma', '1002'),
		   ('5', 'Price and Prejudice', '1002');
GO

-- Insert a book for an author not yet present in the Author table
INSERT Books 
	VALUES ('6','Brave New World', '1003');
GO

SELECT * FROM Books;
GO

-- Add the author first, then the book
INSERT Authors
	VALUES ('Aldous', 'Huxley');
GO

INSERT Books
	VALUES ('6','Brave New World', '1003');
GO

SELECT * FROM Books;
GO

-- Modify the Books table to include year published
ALTER TABLE Books
	ADD PublicationYear char(4);
GO

-- Add publication years for the books in the table
UPDATE Books
	SET PublicationYear = '1877'
	WHERE Title = 'Anna Karenina';

UPDATE Books 
	SET PublicationYear = '1869'
	WHERE Title = 'War and Peace';

UPDATE Books 
	SET PublicationYear = '1922'
	WHERE Title = 'Ulysses';

UPDATE Books
	SET PublicationYear = '1815'
	WHERE Title = 'Emma';

UPDATE Books
	SET PublicationYear = '1813'
	WHERE Title = 'Price and Prejudice';

UPDATE Books
	SET PublicationYear = '1931'
	WHERE Title = 'Brave New World';
GO
SELECT * FROM Books;
GO

-- Clean up tempdb
DROP TABLE Books;
DROP TABLE Authors;
GO