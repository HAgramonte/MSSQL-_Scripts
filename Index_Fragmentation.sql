
/*HAgramonte
Verify the index fragmentation on a specific database
*/

Use AdventureWorksLT2019  -- Change the database name
GO

SELECT Schemas_.[name] +'.'+Tables_.[name]  AS table_name,Indexes_.NAME AS index_name,index_type_desc ,ROUND(avg_fragmentation_in_percent,2) AS Fragmentation
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, '') IndexStats
INNER JOIN sys.tables Tables_ on Tables_.[object_id] = IndexStats.[object_id]
INNER JOIN sys.schemas Schemas_ on Tables_.[schema_id] = Schemas_.[schema_id]
INNER JOIN sys.indexes Indexes_ ON (IndexStats.object_id = Indexes_.object_id) AND (IndexStats.index_id = Indexes_.index_id)
WHERE avg_fragmentation_in_percent <> 0 --- You can change this if you want to include 0.
ORDER BY avg_fragmentation_in_percent DESC;