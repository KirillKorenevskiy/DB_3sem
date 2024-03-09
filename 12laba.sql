
--------------------------������� 1--------------------------

SET NOCOUNT ON;

IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'DBO.MyTable'))
    DROP TABLE MyTable;

DECLARE @rowCount INT, @sumValue INT, @flag char = 'c';
SET IMPLICIT_TRANSACTIONS ON;
CREATE TABLE MyTable (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    City VARCHAR(50)
);
INSERT INTO MyTable (ID, Name, Age, City)
VALUES
    (1, 'John', 25, 'New York'),
    (2, 'Alice', 30, 'London'),
    (3, 'Michael', 35, 'Paris');
SET @rowCount = (SELECT COUNT(*) FROM MyTable);
SET @sumValue = (SELECT SUM(Age) FROM MyTable);
PRINT '���������� ����� � ������� MyTable: ' + CAST(@rowCount AS VARCHAR(2));
PRINT '����� �������� ���� Age: ' + CAST(@sumValue AS VARCHAR(10));

UPDATE MyTable SET City = 'Berlin' WHERE ID = 1;
UPDATE MyTable SET Age = Age + 1;
if @flag = 'c'  commit; 
else   rollback;                                 
SET IMPLICIT_TRANSACTIONS OFF;
IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'DBO.MyTable')) PRINT '������� MyTable ����';
ELSE PRINT '������� MyTable ���';


--------------------------������� 2--------------------------
use UNIVER;

BEGIN TRY
    BEGIN TRAN;
    UPDATE AUDITORIUM_TYPE SET AUDITORIUM_TYPENAME = 'New Type' WHERE AUDITORIUM_TYPE = 'Type1';
    INSERT INTO FACULTY (FACULTY, FACULTY_NAME) VALUES ('F8', 'Faculty 1');
--	INSERT INTO FACULTY (FACULTY, FACULTY_NAME) VALUES ('F3', '���������������������������������������������������������������������������������');
    DELETE FROM TEACHER WHERE TEACHER = 'T1';
    COMMIT TRAN;
    PRINT '���������� ������� ���������.';
END TRY
BEGIN CATCH
    ROLLBACK TRAN;
    PRINT '��������� ������. ���������� ��������.';
    PRINT ERROR_MESSAGE();
END CATCH;


--------------------------������� 3--------------------------

BEGIN TRY
    BEGIN TRAN;
    SAVE TRAN MySavePoint;
    UPDATE STUDENT SET NAME = N'Kirill' WHERE NAME = '����������� ������� ��������';
    INSERT INTO GROUPS (FACULTY, YEAR_FIRST) VALUES ('���', 2011);
    DELETE FROM SUBJECT_T WHERE SUBJECT_NAME = '������������ �����';
    COMMIT TRAN;
    PRINT '���������� ������� ���������.';
END TRY

BEGIN CATCH
    IF (SELECT COUNT(*) FROM sys.sysobjects WHERE name = 'MySavePoint' AND type = 'TR') > 0
        PRINT '����������� ����� MySavePoint ����������.';
    ELSE
        PRINT '����������� ����� MySavePoint �� ����������.';

    IF PATINDEX('%Violation of PRIMARY KEY constraint%UNIQUE_CONSTRAINT_NAME%', ERROR_MESSAGE()) > 0
        PRINT '������: ������������ ������ � �������.';
    ELSE
        PRINT '������: ' + CAST(ERROR_NUMBER() AS VARCHAR(5)) + ' - ' + ERROR_MESSAGE();

    IF @@TRANCOUNT > 0
    BEGIN
        ROLLBACK TRAN MySavePoint;
    END;
    COMMIT TRAN;
    PRINT '�������� ���������, ����������� �� ����������� �����.';
END CATCH;

--------------------------������� 4--------------------------

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRANSACTION A;
SELECT @@SPID, 'select STUDENTS' 'operation', * FROM STUDENT WHERE NAME = '������� ��� ����������';
-- UPDATE STUDENTS SET NAME = '�����' WHERE NAME = '����';
SELECT @@SPID, 'select STUDENTS' 'operation', * FROM STUDENT WHERE NAME = '��������� ��������� ����������';
ROLLBACK TRANSACTION A;

--BEGIN TRANSACTION B;
--UPDATE STUDENT SET NAME = '�����2' WHERE NAME = '������� �������� ����������';
--COMMIT TRAN B;
--ROLLBACK TRANSACTION B;

--5 ���������� ������ � uncommited

--------------------------������� 6--------------------------

set transaction isolation level  REPEATABLE READ 
BEGIN TRANSACTION A;
SELECT @@SPID, 'select STUDENTS' 'operation', * FROM STUDENT WHERE NAME = '�����2';
-- UPDATE STUDENTS SET NAME = '�����' WHERE NAME = '����';
SELECT @@SPID, 'select STUDENTS' 'operation', * FROM STUDENT WHERE NAME = '����� �������';
ROLLBACK TRANSACTION A;

--BEGIN TRANSACTION B;
--INSERT INTO STUDENT (NAME) VALUES ('����� �������');
--UPDATE STUDENT SET NAME = '�����3' WHERE NAME = '��������� ��������� ����������';
--COMMIT TRAN B;
--ROLLBACK TRANSACTION B;

--------------------------������� 7--------------------------

set transaction isolation level SERIALIZABLE 
BEGIN TRANSACTION A;
SELECT @@SPID, 'select STUDENTS' 'operation', * FROM STUDENT WHERE NAME = '�����2';
-- UPDATE STUDENTS SET NAME = '�����' WHERE NAME = '����';
SELECT @@SPID, 'select STUDENTS' 'operation', * FROM STUDENT WHERE NAME = '����� �������2';
ROLLBACK TRANSACTION A;

--------------------------������� 8--------------------------

BEGIN TRANSACTION;
    INSERT INTO STUDENT (NAME) VALUES ('������ ������');
    BEGIN TRANSACTION;
        INSERT INTO STUDENT (NAME) VALUES ('���� �������');
        IF @@ERROR <> 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
    COMMIT;
    INSERT INTO STUDENT (NAME) VALUES ('���� �������');
COMMIT;














