-- Create a new database
CREATE DATABASE EventSessionExample
GO

USE EventSessionExample;
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
		   ('James', 'Joyce'),
		   ('Jane', 'Austin');
GO

SELECT * FROM Authors;
GO
 