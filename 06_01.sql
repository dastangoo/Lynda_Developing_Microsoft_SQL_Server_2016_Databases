-- Create a new database 
CREATE DATABASE SpatialData;
GO
USE SpatialData;
GO

-- Create a 3-4-5 right triangle
SELECT GEOMETRY::STPolyFromText('Polygon((0 0, 3 0, 0 4, 0 0))', 4619);
GO

-- Create the outline of California using lon lat coordinates
-- SELECT GEOGRAPHY ::STPolyFromText('Polygon(())'

-- Create a data table to hold spatial data
CREATE TABLE Cities (
	CityID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	CityName nvarchar(100) NOT NULL,
	LOCATION GEOGRAPHY NOT NULL
);
GO

INSERT Cities 
VALUES ('Los Angeles', Geography::STPointFromText('Point(-118.2437 34.0522)', 4326)),
	   ('Seatle', Geography::STPointFromText('Point(-122.3321 47.6062)', 4326)),
	   ('Portland', Geography::STPointFromText('Point(-122.6765 45.5231)', 4326)),
	   ('San Francisco', Geography::STPointFromText('Point(-122.4194 37.7749)', 4326));
GO

SELECT * FROM Cities;
GO

SELECT * FROM Cities
WHERE CityName = 'Portland';
GO

CREATE TABLE States (
	StateID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	StateName nvarchar(100) NOT NULL,
	Location geography NOT NULL
);
GO

INSERT States
-- VALUES ('California', 
SELECT * FROM States;
GO

-- Clean up the server
USE tempdb;
GO
DROP DATABASE SpatialData;
GO