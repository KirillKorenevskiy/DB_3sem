
------------------ЗАДАНИЕ 1-----------------------

CREATE PROCEDURE PSUBJECT_T
AS
BEGIN
    DECLARE @row_count INT;
    SELECT * INTO #result FROM SUBJECT_T;
    SELECT @row_count = COUNT(*) FROM #result;
    SELECT * FROM #result;
    SELECT @row_count AS row_count;
    DROP TABLE #result;
END;

EXEC PSUBJECT_T;

------------------ЗАДАНИЕ 2-----------------------
GO

/****** Object:  StoredProcedure [dbo].[PSUBJECT_T]    Script Date: 03.12.2023 1:34:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[PSUBJECT_T] @p varchar(20) = NULL, @c INT OUTPUT
AS
BEGIN
    SELECT * INTO #result FROM SUBJECT_T where PULPIT = @p;
	SET @c = (SELECT COUNT(*) FROM SUBJECT_T WHERE PULPIT = @p)
	SELECT * FROM #result;
    DROP TABLE #result;
	RETURN @c;
END;
GO

declare @p varchar(20), @c INT, @r INT = 0;
EXEC PSUBJECT_T @p = 'ИСиТ', @c = @r output;
print 'кол-во строк результирующего набора: ' + cast(@r as varchar(3));


------------------ЗАДАНИЕ 3-----------------------

CREATE PROCEDURE PSUBJECT_T1 @p varchar(20) = NULL
AS
BEGIN
    SELECT * FROM SUBJECT_T where PULPIT = @p;
END;

CREATE TABLE #SUBJECT (
        Subject_t VARCHAR(50),
        Subj_name VARCHAR(50),
        Pulpit VARCHAR(50),
);

INSERT #SUBJECT exec PSUBJECT_T1 @p = 'ТНВиОХТ';
INSERT #SUBJECT exec PSUBJECT_T1 @p = 'ИСиТ';
select * from #SUBJECT;


------------------ЗАДАНИЕ 4-----------------------


CREATE PROCEDURE PAUDITORIUM_INSERT
    @a CHAR(20),
    @n VARCHAR(50),
    @c INT = 0,
    @t CHAR(10)
AS 
declare @rc int = 1;
BEGIN
    BEGIN TRY
        INSERT INTO AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE)
        VALUES (@a, @n, @c, @t);
		return @rc;
    END TRY
    BEGIN CATCH
		print 'сообщение :' + error_message();
		print 'уровень: ' + cast(error_severity() as varchar(6));
		print 'метка: ' + cast(error_state() as varchar(8));
		print 'номер строки: ' + cast(error_line() as varchar(8));
		if ERROR_PROCEDURE() is not null
			print 'имя процедуры: ' + ERROR_PROCEDURE();
			return -1;
    END CATCH;
END;


EXECUTE PAUDITORIUM_INSERT @a = '433-4' , @n = 'лекционка', @c = 27, @t = 'ЛК';


------------------ЗАДАНИЕ 5-----------------------

CREATE PROCEDURE SUBJECT_REPORT
    @p CHAR(10)
AS
BEGIN
    DECLARE @rc INT = 0;
    BEGIN TRY
        DECLARE @subjectName CHAR(20), @subjectList CHAR(300) = ' ';
        DECLARE SubjectCursor CURSOR FOR
            SELECT SUBJECT_T FROM SUBJECT_T WHERE PULPIT = @p;
        IF NOT EXISTS (SELECT SUBJECT_T FROM SUBJECT_T WHERE PULPIT = @p)
        BEGIN
            RAISERROR('Ошибка: Дисциплины не найдены для указанной кафедры.', 11, 1);
        END
        ELSE
        BEGIN
            OPEN SubjectCursor;
            FETCH NEXT FROM SubjectCursor INTO @subjectName;
            PRINT 'Список дисциплин:';
            WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @subjectList = RTRIM(@subjectName) + ', ' + @subjectList;
                SET @rc = @rc + 1;
                FETCH NEXT FROM SubjectCursor INTO @subjectName;
            END;
            PRINT @subjectList;
            CLOSE SubjectCursor;
        END;
        RETURN @rc;
    END TRY
    BEGIN CATCH
        PRINT 'Ошибка в параметрах.';
        IF ERROR_PROCEDURE() IS NOT NULL
            PRINT 'Имя процедуры: ' + ERROR_PROCEDURE();
        RETURN @rc;
    END CATCH;
END;


DECLARE @disciplineCount INT;
EXECUTE @disciplineCount = SUBJECT_REPORT @p = 'ИСиТ';
PRINT 'Количество дисциплин, отображенных в отчете: ' + CAST(@disciplineCount AS NVARCHAR(10));


------------------ЗАДАНИЕ 6-----------------------

CREATE PROCEDURE PAUDITORIUM_INSERTX
    @a CHAR(20),
    @n VARCHAR(50),
    @c INT = 0,
    @t CHAR(10),
    @tn VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @rc INT = -1;
    BEGIN TRY
		set transaction isolation level SERIALIZABLE;   
		begin tran;
		INSERT INTO AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME) VALUES (@t, @tn);        
        EXECUTE @rc = PAUDITORIUM_INSERT @a, @n, @c, @t;
        IF @rc = -1
        BEGIN
            ROLLBACK TRAN;
            RETURN -1;
        END
        COMMIT TRAN;
        RETURN 1;
    END TRY
    BEGIN CATCH
        PRINT 'Сообщение: ' + ERROR_MESSAGE();
        PRINT 'Уровень: ' + CAST(ERROR_SEVERITY() AS VARCHAR(6));
        PRINT 'Метка: ' + CAST(ERROR_STATE() AS VARCHAR(8));
        PRINT 'Номер строки: ' + CAST(ERROR_LINE() AS VARCHAR(8));
        IF ERROR_PROCEDURE() IS NOT NULL
            PRINT 'Имя процедуры: ' + ERROR_PROCEDURE();
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;
        RETURN -1;
    END CATCH;
END;

--DROP PROCEDURE PAUDITORIUM_INSERTX;


DECLARE @result INT;
EXECUTE @result = PAUDITORIUM_INSERTX @a = '188-3' , @n = 'лекционка', @c = 102, @t = 'ЛК-р',  @tn = 'Lecture';
IF @result = 1
    PRINT 'Процедура PAUDITORIUM_INSERTX выполнена успешно.';
ELSE
    PRINT 'Произошла ошибка при выполнении процедуры PAUDITORIUM_INSERTX.';








