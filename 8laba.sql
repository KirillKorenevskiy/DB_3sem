----------------задание 1----------------------

CREATE VIEW [Преподаватель] 
as SELECT TEACHER[код], TEACHER_NAME [имя], GENDER [пол], PULPIT [кафедра]
from TEACHER;

SELECT * FROM [Преподаватель]

----------------задание 2----------------------
USE UNIVER;

CREATE VIEW [Количество кафедр]
as SELECT F.FACULTY [ФАКУЛЬТЕТ],
COUNT(P.PULPIT) AS [КОЛИЧЕСТВО]
FROM FACULTY F JOIN PULPIT P
ON F.FACULTY = P.FACULTY
GROUP BY F.FACULTY

SELECT * FROM [Количество кафедр]

----------------задание 3,4----------------------

CREATE VIEW [Аудитории1]
as SELECT AUDITORIUM, AUDITORIUM_TYPE
FROM AUDITORIUM 
WHERE AUDITORIUM_TYPE like 'ЛК%'
WITH CHECK OPTION;

SELECT * FROM [Аудитории1]


INSERT INTO [Аудитории1] VALUES ('208-1', 'ЛК-К')


----------------задание 5----------------------

CREATE VIEW [Дисциплины]
as SELECT TOP(15) SUBJECT_T, SUBJECT_NAME, PULPIT
FROM SUBJECT_T 
ORDER BY SUBJECT_NAME

SELECT * FROM [Дисциплины]

----------------задание 6----------------------

CREATE VIEW [Количество кафедр1]
WITH SCHEMABINDING
AS SELECT F.FACULTY AS [ФАКУЛЬТЕТ],
COUNT(P.PULPIT) AS [КОЛИЧЕСТВО]
FROM dbo.FACULTY F JOIN dbo.PULPIT P
ON F.FACULTY = P.FACULTY
GROUP BY F.FACULTY;

SELECT * FROM [Количество кафедр1];


------------------для своей бд-------------------
use KOR3_myBase;

CREATE VIEW [даты] 
as SELECT Дата_выдачи [Дата выдачи], Дата_возврата [Дата_возврата]
from Выдача_кредита;
SELECT * FROM [даты]

CREATE VIEW [Клиенты]
as SELECT F.Клиент_ID [Клиент],
P.Сумма [КОЛИЧЕСТВО]
FROM Клиент F JOIN Выдача_кредита P
ON F.Клиент_ID = P.Клиент_ID
SELECT * FROM [Клиенты]

CREATE VIEW [Кредитт]
as SELECT Название_вида_кредита, Ставка
FROM Кредит 
WHERE Название_вида_кредита like 'Авто%'
SELECT * FROM [Кредитт]

CREATE VIEW [Кредит2]
as SELECT TOP(15) Название_вида_кредита, Ставка
FROM Кредит 
ORDER BY Название_вида_кредита
SELECT * FROM [Кредит2]

CREATE VIEW dbo.[Клиенты2]
WITH SCHEMABINDING
AS SELECT F.Клиент_ID AS [Клиент],
P.Сумма AS [КОЛИЧЕСТВО]
FROM dbo.Клиент F
JOIN dbo.Выдача_кредита P
ON F.Клиент_ID = P.Клиент_ID;
SELECT * FROM dbo.[Клиенты2];




