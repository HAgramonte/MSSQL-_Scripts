/*HAgramonte
Verify the index fragmentation on a specific database
*/

Use AdventureWorksLT2019  -- Change the database name
GO

SELECT DISTINCT
OBJECT_NAME(Stats_.[object_id]) AS Table_Name,
SysColumns_.name AS Column_Name,
Stats_.name AS Statistic_Name,
STATS_DATE(Stats_.[object_id], Stats_.stats_id) AS Last_Updated
FROM sys.stats Stats_ JOIN sys.stats_columns StatsColumn_
ON StatsColumn_.[object_id] = Stats_.[object_id] AND StatsColumn_.stats_id = Stats_.stats_id
JOIN sys.columns SysColumns_ ON SysColumns_.[object_id] = StatsColumn_.[object_id] AND SysColumns_.column_id = StatsColumn_.column_id
JOIN sys.partitions Partitions_ ON Partitions_.[object_id] = Stats_.[object_id]
JOIN sys.objects obj ON Partitions_.[object_id] = obj.[object_id]
WHERE OBJECTPROPERTY(Stats_.OBJECT_ID,'IsUserTable') = 1 AND (Stats_.user_created = 1 OR Stats_.auto_created = 1);