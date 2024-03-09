
use UNIVER;

--------------------задание 1----------------------

DECLARE curSubjects CURSOR FOR SELECT RTRIM(SUBJECT_T) FROM SUBJECT_T WHERE PULPIT = 'ИСиТ'
DECLARE @SubjectList VARCHAR(MAX) = ''
DECLARE @Subject VARCHAR(100)
OPEN curSubjects
FETCH curSubjects INTO @Subject
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SubjectList = @SubjectList + @Subject + ', '
    FETCH curSubjects INTO @Subject
END
PRINT @SubjectList
CLOSE curSubjects
DEALLOCATE curSubjects

--------------------задание 2----------------------
DECLARE  global_subject_cursor CURSOR local
FOR 
SELECT * FROM SUBJECT_T
go
OPEN global_subject_cursor 
DECLARE @subject_t char, @subject_name varchar(255), @pulpit char
FETCH NEXT FROM global_subject_cursor 
INTO @subject_t, @subject_name, @pulpit
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Subject Code: ' + @subject_t + ', Subject Name: ' + @subject_name + ', Pulpit Code: ' + @pulpit
    FETCH NEXT FROM global_subject_cursor 
    INTO @subject_t, @subject_name, @pulpit
END
CLOSE global_subject_cursor 
DEALLOCATE global_subject_cursor

--------------------задание 3----------------------

INSERT INTO SUBJECT_T (SUBJECT_T, SUBJECT_NAME, PULPIT)
VALUES ('1', 'Mathematics2', 'ИСиТ')
DECLARE static_subject_cursor CURSOR DYNAMIC
FOR SELECT * FROM SUBJECT_T
OPEN static_subject_cursor 
DECLARE @subject_t1 char, @subject_name1 varchar(255), @pulpit1 char
FETCH NEXT FROM static_subject_cursor 
INTO @subject_t1, @subject_name1, @pulpit1
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Subject Code: ' + @subject_t1 + ', Subject Name: ' + @subject_name1 + ', Pulpit Code: ' + @pulpit1
    FETCH NEXT FROM static_subject_cursor 
    INTO @subject_t1, @subject_name1, @pulpit1
END
CLOSE static_subject_cursor 
DEALLOCATE static_subject_cursor


--------------------задание 4----------------------

DECLARE @subject_t char, @subject_name varchar(255), @pulpit char, @row_number int;
DECLARE scroll_cursor CURSOR LOCAL SCROLL
FOR
SELECT ROW_NUMBER() OVER (ORDER BY SUBJECT_NAME) AS RowNumber,
       SUBJECT_T,
       SUBJECT_NAME,
       PULPIT
FROM SUBJECT_T;

OPEN scroll_cursor;
FETCH NEXT FROM scroll_cursor INTO @row_number, @subject_t, @subject_name, @pulpit;
PRINT 'NEXT ROW: ' + CAST(@row_number AS VARCHAR(3)) + ', ' + @subject_name;

FETCH FIRST FROM scroll_cursor INTO @row_number, @subject_t, @subject_name, @pulpit;
PRINT 'FIRST ROW: ' + CAST(@row_number AS VARCHAR(3)) + ', ' + @subject_name;

FETCH LAST FROM scroll_cursor INTO @row_number, @subject_t, @subject_name, @pulpit;
PRINT 'LAST ROW: ' + CAST(@row_number AS VARCHAR(3)) + ', ' + @subject_name;

FETCH PRIOR FROM scroll_cursor INTO @row_number, @subject_t, @subject_name, @pulpit;
PRINT 'PRIOR ROW: ' + CAST(@row_number AS VARCHAR(3)) + ', ' + @subject_name;

FETCH ABSOLUTE 3 FROM scroll_cursor INTO @row_number, @subject_t, @subject_name, @pulpit;
PRINT 'ABSOLUTE (3rd from start) ROW: ' + CAST(@row_number AS VARCHAR(3)) + ', ' + @subject_name;

FETCH ABSOLUTE -3 FROM scroll_cursor INTO @row_number, @subject_t, @subject_name, @pulpit;
PRINT 'ABSOLUTE (-3rd from end) ROW: ' + CAST(@row_number AS VARCHAR(3)) + ', ' + @subject_name;

FETCH PRIOR FROM scroll_cursor INTO @row_number, @subject_t, @subject_name, @pulpit; -- moving cursor to the start
FETCH RELATIVE 2 FROM scroll_cursor INTO @row_number, @subject_t, @subject_name, @pulpit;
PRINT 'RELATIVE (5th forward) ROW: ' + CAST(@row_number AS VARCHAR(3)) + ', ' + @subject_name;

FETCH RELATIVE -5 FROM scroll_cursor INTO @row_number, @subject_t, @subject_name, @pulpit;
PRINT 'RELATIVE (-5th backward) ROW: ' + CAST(@row_number AS VARCHAR(3)) + ', ' + @subject_name;

CLOSE scroll_cursor;
DEALLOCATE scroll_cursor;

--------------------задание 5----------------------

SELECT * INTO #tmp_subject_t
FROM subject_t;
SELECT * FROM #tmp_subject_t
DECLARE @subjectCursor CURSOR;
DECLARE @subjectId CHAR(10);

BEGIN
    SET @subjectCursor = CURSOR FOR
    SELECT SUBJECT_T FROM #tmp_subject_t FOR UPDATE;

    OPEN @subjectCursor;
    FETCH NEXT FROM @subjectCursor INTO @subjectId;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE #tmp_subject_t SET SUBJECT_NAME = 'New Subject Name' WHERE CURRENT OF @subjectCursor;
        FETCH NEXT FROM @subjectCursor INTO @subjectId;
    END;

    FETCH FIRST FROM @subjectCursor INTO @subjectId;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        DELETE FROM #tmp_subject_t WHERE CURRENT OF @subjectCursor;
        FETCH NEXT FROM @subjectCursor INTO @subjectId;
    END;
    CLOSE @subjectCursor;
    DEALLOCATE @subjectCursor;
END;

--------------------задание 6----------------------

SELECT *
INTO #tmp_progress FROM PROGRESS;
SELECT * FROM #tmp_progress
DECLARE @progressCursor CURSOR; 
DECLARE @studentId INT; 

BEGIN 
    SET @progressCursor = CURSOR FOR 
    SELECT p.IDSTUDENT FROM #tmp_progress p 
    INNER JOIN STUDENT s ON p.IDSTUDENT = s.IDSTUDENT
    INNER JOIN GROUPS g ON s.IDGROUP = g.IDGROUP
    WHERE p.NOTE < 5 FOR UPDATE; 

    OPEN @progressCursor; 
    FETCH NEXT FROM @progressCursor INTO @studentId; 
    WHILE @@FETCH_STATUS = 0 
    BEGIN 
        DELETE FROM #tmp_progress
        WHERE CURRENT OF @progressCursor; 
        FETCH NEXT FROM @progressCursor INTO @studentId; 
    END; 
    CLOSE @progressCursor; 
    DEALLOCATE @progressCursor; 
END;

DECLARE @progressCursor CURSOR; 
DECLARE @studentId INT = 1002;   

BEGIN 
    SET @progressCursor = CURSOR FOR 
    SELECT IDSTUDENT FROM #tmp_progress WHERE IDSTUDENT = @studentId FOR UPDATE; 

    OPEN @progressCursor;
    FETCH NEXT FROM @progressCursor INTO @studentId; 
    WHILE @@FETCH_STATUS = 0 
    BEGIN 
        UPDATE #tmp_progress SET NOTE = NOTE + 1 WHERE CURRENT OF @progressCursor; 
        FETCH NEXT FROM @progressCursor INTO @studentId; 
    END; 
    CLOSE @progressCursor; 
    DEALLOCATE @progressCursor; 
END;






































