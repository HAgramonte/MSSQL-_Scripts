/*HAgramonte
Verify the index fragmentation on a specific database in SQL Server versions 2005-2008
*/
Use AdventureWorksLT2019  -- Change the database name
GO

SELECT OBJECT_NAME(IndexStats.object_id)as 'Table_Name', Indexes_.name AS Index_Name,ROUND(IndexStats.avg_fragmentation_in_percent,2) AS Fragmentation
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS IndexStats
INNER JOIN sys.indexes AS Indexes_ ON IndexStats.OBJECT_ID = Indexes_.OBJECT_ID
AND IndexStats.index_id = Indexes_.index_id
WHERE IndexStats.database_id = DB_ID() AND avg_fragmentation_in_percent <> 0 --and OBJECT_NAME(ps.object_id) in ('You can Specify Table names here')
ORDER BY IndexStats.avg_fragmentation_in_percent DESC
GO