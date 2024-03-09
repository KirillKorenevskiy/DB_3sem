
--------------------������� 1----------------------------

create table TR_AUDIT
(
	ID int identity,
	STMT varchar(20) check (STMT in ('INS', 'DEL', 'UPD')),
	TRNAME varchar(50),
	CC varchar(300)
)

CREATE TRIGGER TR_TEACHER_INS
ON TEACHER
AFTER INSERT
AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    SELECT 'INS', 'TR_TEACHER_INS', CONCAT(TEACHER, ', ', TEACHER_NAME, ', ', GENDER, ', ', PULPIT)
    FROM inserted;
END;


INSERT into  TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT) values('������', '�����������', '�', '����');

select * from TR_AUDIT;

drop trigger TR_TEACHER_INS;


--------------------������� 2----------------------------

CREATE TRIGGER TR_TEACHER_DEL
ON TEACHER
AFTER DELETE
AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    SELECT 'DEL', 'TR_TEACHER_DEL', CONCAT(TEACHER, ', ', TEACHER_NAME, ', ', GENDER, ', ', PULPIT)
    FROM deleted;
END;

drop trigger TR_TEACHER_DEL;

DELETE FROM TEACHER WHERE TEACHER = '�������';

select * from TR_AUDIT;


--------------------������� 3----------------------------

CREATE TRIGGER TR_TEACHER_UPD
ON TEACHER
AFTER UPDATE
AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    SELECT 'UPD', 'TR_TEACHER_UPD', CONCAT(i.TEACHER, ', ', i.TEACHER_NAME, ', ', i.GENDER, ', ', i.PULPIT)
    FROM inserted i
END;

drop trigger TR_TEACHER_UPD;

UPDATE TEACHER SET TEACHER = '����', TEACHER_NAME = '�������', GENDER = '�', PULPIT = '����'
WHERE TEACHER = '�����'

DELETE FROM TEACHER WHERE TEACHER = '����';

select * from TR_AUDIT;


--------------------������� 4----------------------------

CREATE TRIGGER TR_TEACHER
ON TEACHER
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
    DECLARE @event VARCHAR(10);
    DECLARE @cc VARCHAR(300);
    
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @event = 'INS';
        SELECT @cc = TEACHER + ', ' + TEACHER_NAME + ', ' + GENDER + ', ' + PULPIT FROM inserted;
    END
    ELSE IF NOT EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @event = 'DEL';
        SELECT @cc = TEACHER + ', ' + TEACHER_NAME + ', ' + GENDER + ', ' + PULPIT FROM deleted;
    END
    ELSE IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @event = 'UPD';
        SELECT @cc = CONCAT(TEACHER, ', ', TEACHER_NAME, ', ', GENDER, ', ', PULPIT)
        FROM inserted;
    END
    
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    VALUES (@event, 'TR_TEACHER', @cc);
END;


INSERT into  TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT) values('�������', '�����������', '�', '����');
DELETE FROM TEACHER WHERE TEACHER = '�������';
UPDATE TEACHER SET TEACHER = 'dklcal', TEACHER_NAME = '�����������', GENDER = '�', PULPIT = '����'
WHERE TEACHER = '�������'

select * from TR_AUDIT;


drop trigger TR_TEACHER;


--------------------������� 5----------------------------
--�� ������� ������� ����� ��������

--------------------������� 6----------------------------

CREATE TRIGGER TR_TEACHER_DEL1
ON TEACHER
AFTER DELETE
AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    SELECT 'DEL', 'TR_TEACHER_DEL1', CONCAT('1-� �������', TEACHER, ', ', TEACHER_NAME, ', ', GENDER, ', ', PULPIT)
    FROM deleted;
END;

CREATE TRIGGER TR_TEACHER_DEL2
ON TEACHER
AFTER DELETE
AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    SELECT 'DEL', 'TR_TEACHER_DEL2', CONCAT('2-� �������', TEACHER, ', ', TEACHER_NAME, ', ', GENDER, ', ', PULPIT)
    FROM deleted;
END;

CREATE TRIGGER TR_TEACHER_DEL3
ON TEACHER
AFTER DELETE
AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    SELECT 'DEL', 'TR_TEACHER_DEL3', CONCAT('3-� �������', TEACHER, ', ', TEACHER_NAME, ', ', GENDER, ', ', PULPIT)
    FROM deleted;
END;

DELETE FROM TEACHER WHERE TEACHER = '���';
select * from TR_AUDIT;

drop trigger TR_TEACHER_DEL1;

SELECT name AS TriggerName
FROM sys.triggers
WHERE parent_id = OBJECT_ID('TEACHER')

EXEC sp_settriggerorder @triggername = 'TR_TEACHER_DEL3', @order = 'First', @stmttype = 'DELETE';
EXEC sp_settriggerorder @triggername = 'TR_TEACHER_DEL2', @order = 'Last', @stmttype = 'DELETE';


--------------------������� 7----------------------------

create trigger AUD_AFTER 
on AUDITORIUM after DELETE, UPDATE 
as
declare @c int = (select sum (AUDITORIUM_CAPACITY) from AUDITORIUM);
if (ISNULL (@c, 0) < 1900)
begin
raiserror ('����� ����������� ��������� �� ����� ���� < 1900', 10,1);
rollback; 
end; 
return;

delete AUDITORIUM where AUDITORIUM_TYPE = '��-�';

--------------------������� 8----------------------------

CREATE TRIGGER TR_FACULTY_DELETE
ON FACULTY
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('�������� ����� �� ������� FACULTY ���������.', 16, 1);
END;

DELETE FROM FACULTY WHERE FACULTY = 'NEX';


--------------------������� 9----------------------------

CREATE TRIGGER DDL_UNIVER
ON DATABASE
FOR DDL_DATABASE_LEVEL_EVENTS
AS
BEGIN
    DECLARE @EventType VARCHAR(50) = EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'VARCHAR(50)');
    DECLARE @ObjectName VARCHAR(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'VARCHAR(50)');
    DECLARE @ObjectType VARCHAR(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'VARCHAR(50)');

    IF @EventType = 'CREATE_TABLE' OR @EventType = 'DROP_TABLE'
    BEGIN
        PRINT '��� �������: ' + @EventType;
        PRINT '��� �������: ' + @ObjectName;
        PRINT '��� �������: ' + @ObjectType;
        RAISERROR(N'�������� � ��������� ���������', 16, 1);
        ROLLBACK;
    END;
END;

drop trigger DDL_UNIVER;

drop table MyTable;

