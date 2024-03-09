
-----------------������� 1----------------------

DECLARE @charVar CHAR(10) = '������',
	    @varcharVar VARCHAR(20) = '������',
		@datetimeVar DATETIME,
		@timeVar TIME,
		@intVar INT,
		@smallintVar SMALLINT,
		@tinyintVar TINYINT,
		@numericVar NUMERIC(12, 5)

select @datetimeVar = GETDATE(),
@intVar = 100,
 @smallintVar = 50

SET @timeVar = GETDATE()
 set @intVar = 100
set  @smallintVar = 50
SET @tinyintVar = 10
SET @numericVar = 123.45678

SELECT @charVar AS CharVar, @varcharVar AS VarcharVar
PRINT 'Datetime Var: ' + CONVERT(VARCHAR, @datetimeVar, 120)
PRINT 'Time Var: ' + CONVERT(VARCHAR, @timeVar, 108)
PRINT 'Int Var: ' + CAST(@intVar AS VARCHAR)
PRINT 'Smallint Var: ' + CAST(@smallintVar AS VARCHAR)
PRINT 'Tinyint Var: ' + CAST(@tinyintVar AS VARCHAR)
PRINT 'Numeric Var: ' + CAST(@numericVar AS VARCHAR)

-----------------������� 2----------------------

use UNIVER;

DECLARE @TotalCapacity INT;

SELECT @TotalCapacity = SUM(AUDITORIUM_CAPACITY) 
FROM AUDITORIUM;

IF @TotalCapacity > 200
BEGIN
    DECLARE @AverageCapacity FLOAT, 
            @LessThanAverage INT, 
            @TotalAuditoriums INT;

    SELECT @AverageCapacity = AVG(CAST(AUDITORIUM_CAPACITY AS FLOAT)), 
           @TotalAuditoriums = COUNT(*) 
    FROM AUDITORIUM;

    SELECT @LessThanAverage = COUNT(*) 
    FROM AUDITORIUM 
    WHERE AUDITORIUM_CAPACITY < @AverageCapacity;

    SELECT @TotalAuditoriums AS '����� ���������', 
           @AverageCapacity AS '�� �����������', 
           @LessThanAverage AS '��������� � ������ ��������',
       CAST(CAST(@LessThanAverage as decimal(5,2))/CAST(@TotalAuditoriums as decimal(5,2)) * 100 as numeric(5,2)) as '����'
END
ELSE
BEGIN
    PRINT '������ 200: ' + CAST(@TotalCapacity AS VARCHAR);
END

-----------------������� 3----------------------

PRINT 'ROWCOUNT: ' + CONVERT(VARCHAR, @@ROWCOUNT);
PRINT 'VERSION: ' + @@VERSION;
PRINT 'SPID: ' + CONVERT(VARCHAR, @@SPID);
PRINT 'ERROR: ' + CONVERT(VARCHAR, @@ERROR);
PRINT 'SERVERNAME: ' + @@SERVERNAME;
PRINT 'TRANCOUNT: ' + CONVERT(VARCHAR, @@TRANCOUNT);
PRINT 'FETCH_STATUS: ' + CONVERT(VARCHAR, @@FETCH_STATUS);
PRINT 'NESTLEVEL: ' + CONVERT(VARCHAR, @@NESTLEVEL);

-----------------������� 4----------------------

DECLARE @t int = 1, @x float = 0.5, @z float;
	if (@t > @x) SET @z = sin(@t) * sin(@t);
	if (@t < @x) SET @z = 4 * (@t + @x);
	if (@t = @x) SET @z = 1 - exp(@x -2);
PRINT 'z=' + CAST(@z as varchar(10));


SELECT 
    NAME, 
    LEFT(NAME, CHARINDEX(' ', NAME) - 1) + 
    ' ' + 
    UPPER(SUBSTRING(NAME, CHARINDEX(' ', NAME) + 1, 1)) + 
    '. ' + 
    UPPER(SUBSTRING(NAME, CHARINDEX(' ', NAME, CHARINDEX(' ', NAME) + 1) + 1, 1)) + 
    '.' AS ShortName 
FROM STUDENT;

SELECT 
    NAME, 
    BDAY, 
    DATEPART(YEAR, GETDATE()) - DATEPART(YEAR, BDAY) - 
        CASE 
            WHEN (DATEPART(MONTH, GETDATE()) < DATEPART(MONTH, BDAY)) OR 
                 (DATEPART(MONTH, GETDATE()) = DATEPART(MONTH, BDAY) AND DATEPART(DAY, GETDATE()) < DATEPART(DAY, BDAY)) 
            THEN 1 
            ELSE 0 
        END AS Age 
FROM STUDENT 
WHERE DATEPART(MONTH, DATEADD(MONTH, 1, GETDATE())) = DATEPART(MONTH, BDAY);


SELECT DISTINCT DATENAME(WEEKDAY, PDATE) AS ExamDayOfWeek
FROM PROGRESS 
INNER JOIN STUDENT ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
WHERE SUBJECT_T = '����' AND IDGROUP = 5;

-----------------������� 5----------------------

DECLARE @v INT = (SELECT COUNT(*) FROM AUDITORIUM);

IF @v > 7
BEGIN
    PRINT '���-�� > 5';
END
ELSE
BEGIN
    PRINT '���-�� < 5';
	return;
END;

PRINT '���������� ��������� = ' + CAST(@v AS VARCHAR(10));

-----------------������� 6----------------------

SELECT CASE 
	when NOTE between 0 and 3 then '����'
	when NOTE between 3 and 8 then '��'
	when NOTE between 8 and 10 then '�������'
	else '������� �����'
	end ������, count(*)[����������]
FROM dbo.PROGRESS
GROUP BY CASE 
	when NOTE between 0 and 3 then '����'
	when NOTE between 3 and 8 then '��'
	when NOTE between 8 and 10 then '�������'
	else '������� �����'
	end


-----------------������� 7----------------------


CREATE TABLE #VremTable
(
    ID INT,
    Name VARCHAR(50),
    Age INT
);

DECLARE @Counter INT = 1;
WHILE @Counter <= 10
BEGIN
    INSERT INTO #VremTable (ID, Name, Age)
    VALUES (@Counter, '��� ' + CAST(@Counter AS VARCHAR), @Counter * 10);
    SET @Counter = @Counter + 1;
END;

SELECT * FROM #VremTable;

DROP TABLE #VremTable;


-----------------������� 8----------------------

CREATE FUNCTION dbo.GetAverageGrade (@studentId INT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @averageGrade FLOAT;
    SET @averageGrade = 4.5;
    RETURN @averageGrade;
END;

SELECT dbo.GetAverageGrade(1) AS AverageGrade;


-----------------������� 9----------------------

use KOR3_myBase;

begin TRY 
	UPDATE dbo.������_������� set ����� = '10000000'
		where ����� = '1000'
end try 
begin CATCH
	print ERROR_NUMBER()
	print ERROR_MESSAGE()
	print ERROR_LINE()
	print ERROR_PROCEDURE()
	print ERROR_SEVERITY()
	print ERROR_STATE()
end catch