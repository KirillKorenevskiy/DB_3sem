
-------------------задание 1-----------------------

exec sp_helpindex'AUDITORIUM'

CREATE TABLE #TempTable (
  ID INT PRIMARY KEY,
  Name VARCHAR(50),
  Age INT
);

DECLARE @counter INT = 1;

WHILE @counter <= 1000
BEGIN
  INSERT INTO #TempTable (ID, Name, Age)
  VALUES (@counter, 'Kirill' + CAST(@counter AS VARCHAR), ABS(CHECKSUM(NEWID())) % 100);
  SET @counter = @counter + 1;
END;

SELECT ID, Name, Age
FROM #TempTable
WHERE Age > 25;

CREATE CLUSTERED INDEX IX_TempTable_Age ON #TempTable (Age);
drop INDEX IX_TempTable_Age ON #TempTable ;

alter table #TempTable drop constraint PK__#TempTab__3214EC278C72CE40;


-------------------задание 2-----------------------

CREATE TABLE #TempTable1 (
  ID INT PRIMARY KEY,
  Name VARCHAR(50),
  Age INT
);

DECLARE @counter1 INT = 1;

WHILE @counter1 <= 10000
BEGIN
  INSERT INTO #TempTable1 (ID, Name, Age)
  VALUES (@counter1, 'Name' + CAST(@counter1 AS VARCHAR), ABS(CHECKSUM(NEWID())) % 100);
  SET @counter1 = @counter1 + 1;
END;

SELECT ID, Name, Age
FROM #TempTable1
WHERE Age > 25 and Name = 'Name2';

SET SHOWPLAN_TEXT OFF;

CREATE NONCLUSTERED INDEX IX_TempTable_NameAge ON #TempTable1 (Name, Age);

-------------------задание 3-----------------------

CREATE TABLE #TempTable3 (
  ID INT PRIMARY KEY,
  Name VARCHAR(50),
  Age INT
);

DECLARE @counter3 INT = 1;

WHILE @counter3 <= 10000
BEGIN
  INSERT INTO #TempTable3 (ID, Name, Age)
  VALUES (@counter3, 'Name' + CAST(@counter3 AS VARCHAR), ABS(CHECKSUM(NEWID())) % 100);
  SET @counter3 = @counter3 + 1;
END;

SELECT ID, Name, Age
FROM #TempTable3
WHERE Age > 25;

CREATE NONCLUSTERED INDEX IX_TempTable_AgeCovering ON #TempTable3 (Age) INCLUDE (ID, Name);

-------------------задание 4-----------------------

CREATE TABLE #TempTable2 (
  ID INT PRIMARY KEY,
  Name VARCHAR(50),
  Age INT
);

DECLARE @counter2 INT = 1;

WHILE @counter2 <= 10000
BEGIN
  INSERT INTO #TempTable2 (ID, Name, Age)
  VALUES (@counter2, 'Name' + CAST(@counter2 AS VARCHAR), ABS(CHECKSUM(NEWID())) % 100);
  SET @counter2 = @counter2 + 1;
END;

SELECT ID, Name, Age
FROM #TempTable2
WHERE Age > 25;

CREATE NONCLUSTERED INDEX IX_TempTable_Agee ON #TempTable2 (ID, Name, Age) WHERE Age > 25;
drop INDEX IX_TempTable_Agee ON #TempTable2;

-------------------задание 5-----------------------

CREATE TABLE #TempTable4 (
  ID INT PRIMARY KEY,
  Name VARCHAR(50),
  Age INT
);

DECLARE @counter4 INT = 20001;

WHILE @counter4 <= 30000
BEGIN
  INSERT INTO #TempTable4 (ID, Name, Age)
  VALUES (@counter4, 'Name' + CAST(@counter4 AS VARCHAR), ABS(CHECKSUM(NEWID())) % 100);
  SET @counter4 = @counter4 + 1;
END;

CREATE NONCLUSTERED INDEX IX_TempTable_NameAge4 ON #TempTable4 (Name, Age);
drop INDEX IX_TempTable_NameAge4 ON #TempTable4;

INSERT top(10000) #TempTable4(Name, Age, ID) select Name, Age, ID from #TempTable4;

SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
OBJECT_ID(N'#TempTable4'), NULL, NULL, NULL) ss  JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id  WHERE name is not null;

alter table #TempTable4 drop constraint PK__#TempTab__3214EC272295455C;

drop table #TempTable4

ALTER index IX_TempTable_NameAge4 on #TempTable4 reorganize;

ALTER index IX_TempTable_NameAge4 on #TempTable4 rebuild;

-------------------задание 6-----------------------
drop INDEX IX_TempTable_NameAge4 ON #TempTable4;
CREATE NONCLUSTERED INDEX IX_TempTable_NameAge4 ON #TempTable4 (Name, Age) with (fillfactor = 65);

SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),    
OBJECT_ID(N'#TempTable4'), NULL, NULL, NULL) ss  JOIN sys.indexes ii 
ON ss.object_id = ii.object_id and ss.index_id = ii.index_id  WHERE name is not null;

---------------------для своей бд--------------------

CREATE INDEX IX_Кредит_Кредит_ID ON Кредит (Кредит_ID);

SELECT *
FROM Кредит WITH (INDEX(IX_Кредит_Кредит_ID))
WHERE Кредит_ID = 3;


--

CREATE INDEX IX_Клиент_Название_фирмы_клиента ON Клиент (Название_фирмы_клиента);

SELECT *
FROM Клиент WITH (INDEX(IX_Клиент_Название_фирмы_клиента))
WHERE Название_фирмы_клиента = 'ИП Красивый Мир';

--







































