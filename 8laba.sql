----------------������� 1----------------------

CREATE VIEW [�������������] 
as SELECT TEACHER[���], TEACHER_NAME [���], GENDER [���], PULPIT [�������]
from TEACHER;

SELECT * FROM [�������������]

----------------������� 2----------------------
USE UNIVER;

CREATE VIEW [���������� ������]
as SELECT F.FACULTY [���������],
COUNT(P.PULPIT) AS [����������]
FROM FACULTY F JOIN PULPIT P
ON F.FACULTY = P.FACULTY
GROUP BY F.FACULTY

SELECT * FROM [���������� ������]

----------------������� 3,4----------------------

CREATE VIEW [���������1]
as SELECT AUDITORIUM, AUDITORIUM_TYPE
FROM AUDITORIUM 
WHERE AUDITORIUM_TYPE like '��%'
WITH CHECK OPTION;

SELECT * FROM [���������1]


INSERT INTO [���������1] VALUES ('208-1', '��-�')


----------------������� 5----------------------

CREATE VIEW [����������]
as SELECT TOP(15) SUBJECT_T, SUBJECT_NAME, PULPIT
FROM SUBJECT_T 
ORDER BY SUBJECT_NAME

SELECT * FROM [����������]

----------------������� 6----------------------

CREATE VIEW [���������� ������1]
WITH SCHEMABINDING
AS SELECT F.FACULTY AS [���������],
COUNT(P.PULPIT) AS [����������]
FROM dbo.FACULTY F JOIN dbo.PULPIT P
ON F.FACULTY = P.FACULTY
GROUP BY F.FACULTY;

SELECT * FROM [���������� ������1];


------------------��� ����� ��-------------------
use KOR3_myBase;

CREATE VIEW [����] 
as SELECT ����_������ [���� ������], ����_�������� [����_��������]
from ������_�������;
SELECT * FROM [����]

CREATE VIEW [�������]
as SELECT F.������_ID [������],
P.����� [����������]
FROM ������ F JOIN ������_������� P
ON F.������_ID = P.������_ID
SELECT * FROM [�������]

CREATE VIEW [�������]
as SELECT ��������_����_�������, ������
FROM ������ 
WHERE ��������_����_������� like '����%'
SELECT * FROM [�������]

CREATE VIEW [������2]
as SELECT TOP(15) ��������_����_�������, ������
FROM ������ 
ORDER BY ��������_����_�������
SELECT * FROM [������2]

CREATE VIEW dbo.[�������2]
WITH SCHEMABINDING
AS SELECT F.������_ID AS [������],
P.����� AS [����������]
FROM dbo.������ F
JOIN dbo.������_������� P
ON F.������_ID = P.������_ID;
SELECT * FROM dbo.[�������2];




