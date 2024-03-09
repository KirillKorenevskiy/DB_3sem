
--------------------ЗАДАНИЕ 1----------------------------

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


INSERT into  TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT) values('КРНВСК', 'Кореневский', 'Т', 'ИСиТ');

select * from TR_AUDIT;

drop trigger TR_TEACHER_INS;


--------------------ЗАДАНИЕ 2----------------------------

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

DELETE FROM TEACHER WHERE TEACHER = 'КРНВСКЙ';

select * from TR_AUDIT;


--------------------ЗАДАНИЕ 3----------------------------

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

UPDATE TEACHER SET TEACHER = 'ХНВЧ', TEACHER_NAME = 'Юхневич', GENDER = 'м', PULPIT = 'ИСиТ'
WHERE TEACHER = 'ЗВГЦВ'

DELETE FROM TEACHER WHERE TEACHER = 'ХНВЧ';

select * from TR_AUDIT;


--------------------ЗАДАНИЕ 4----------------------------

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


INSERT into  TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT) values('КРНВСКЙ', 'Кореневский', 'м', 'ИСиТ');
DELETE FROM TEACHER WHERE TEACHER = 'КРНВСКЙ';
UPDATE TEACHER SET TEACHER = 'dklcal', TEACHER_NAME = 'Кореневский', GENDER = 'м', PULPIT = 'ИСиТ'
WHERE TEACHER = 'КРНВСКЙ'

select * from TR_AUDIT;


drop trigger TR_TEACHER;


--------------------ЗАДАНИЕ 5----------------------------
--на примере первого можно показать

--------------------ЗАДАНИЕ 6----------------------------

CREATE TRIGGER TR_TEACHER_DEL1
ON TEACHER
AFTER DELETE
AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    SELECT 'DEL', 'TR_TEACHER_DEL1', CONCAT('1-й триггер', TEACHER, ', ', TEACHER_NAME, ', ', GENDER, ', ', PULPIT)
    FROM deleted;
END;

CREATE TRIGGER TR_TEACHER_DEL2
ON TEACHER
AFTER DELETE
AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    SELECT 'DEL', 'TR_TEACHER_DEL2', CONCAT('2-й триггер', TEACHER, ', ', TEACHER_NAME, ', ', GENDER, ', ', PULPIT)
    FROM deleted;
END;

CREATE TRIGGER TR_TEACHER_DEL3
ON TEACHER
AFTER DELETE
AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    SELECT 'DEL', 'TR_TEACHER_DEL3', CONCAT('3-й триггер', TEACHER, ', ', TEACHER_NAME, ', ', GENDER, ', ', PULPIT)
    FROM deleted;
END;

DELETE FROM TEACHER WHERE TEACHER = 'РЖК';
select * from TR_AUDIT;

drop trigger TR_TEACHER_DEL1;

SELECT name AS TriggerName
FROM sys.triggers
WHERE parent_id = OBJECT_ID('TEACHER')

EXEC sp_settriggerorder @triggername = 'TR_TEACHER_DEL3', @order = 'First', @stmttype = 'DELETE';
EXEC sp_settriggerorder @triggername = 'TR_TEACHER_DEL2', @order = 'Last', @stmttype = 'DELETE';


--------------------ЗАДАНИЕ 7----------------------------

create trigger AUD_AFTER 
on AUDITORIUM after DELETE, UPDATE 
as
declare @c int = (select sum (AUDITORIUM_CAPACITY) from AUDITORIUM);
if (ISNULL (@c, 0) < 1900)
begin
raiserror ('Общая вместимость аудиторий не может быть < 1900', 10,1);
rollback; 
end; 
return;

delete AUDITORIUM where AUDITORIUM_TYPE = 'ЛБ-К';

--------------------ЗАДАНИЕ 8----------------------------

CREATE TRIGGER TR_FACULTY_DELETE
ON FACULTY
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('Удаление строк из таблицы FACULTY запрещено.', 16, 1);
END;

DELETE FROM FACULTY WHERE FACULTY = 'NEX';


--------------------ЗАДАНИЕ 9----------------------------

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
        PRINT 'Тип события: ' + @EventType;
        PRINT 'Имя объекта: ' + @ObjectName;
        PRINT 'Тип объекта: ' + @ObjectType;
        RAISERROR(N'Операции с таблицами запрещены', 16, 1);
        ROLLBACK;
    END;
END;

drop trigger DDL_UNIVER;

drop table MyTable;

