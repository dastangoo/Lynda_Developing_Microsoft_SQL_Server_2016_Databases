USE WideWorldImporters;
GO

-- View the stats for a specific index
DBCC Show_Statistics ('Application.People', 'IX_Application_People_Perf_20160301_05');
GO

-- Update statistics for the database 
EXEC sp_updatestats;
GO

