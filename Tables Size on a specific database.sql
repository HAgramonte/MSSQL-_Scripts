/*HAgramonte
Tables size on a specific database
*/

Use AdventureWorksLT2019  -- Change the database name
GO

/*HAgramonte
Verify the Tables Size on a specific database
*/

Use AdventureWorksLT2019  -- Change the database name
GO

SELECT s.Name AS Schema_Name, Tables_.NAME AS Table_Name,Partitions_.Rows,SUM(a.total_pages) * 8 AS Space_In_KB,CAST(ROUND(((SUM(a.total_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS Space_In_MB    
FROM sys.tables Tables_
INNER JOIN sys.indexes Indexes_ ON Tables_.OBJECT_ID = Indexes_.object_id
INNER JOIN sys.partitions Partitions_ ON Indexes_.object_id = Partitions_.OBJECT_ID AND Indexes_.index_id = Partitions_.index_id
INNER JOIN sys.allocation_units a ON Partitions_.partition_id = a.container_id
LEFT OUTER JOIN sys.schemas s ON Tables_.schema_id = s.schema_id
WHERE Tables_.is_ms_shipped = 0 AND Indexes_.OBJECT_ID > 255
GROUP BY Tables_.Name, s.Name, Partitions_.Rows
ORDER BY Space_In_KB DESC, Tables_.Name