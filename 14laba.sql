
----------------------ЗАДАНИЕ 1-------------------------

CREATE FUNCTION COUNT_STUDENTS
(
    @faculty varchar(20)
)
RETURNS INT
AS
BEGIN
    DECLARE @count INT;
    SELECT @count = COUNT(*) 
    FROM FACULTY f
    INNER JOIN GROUPS g ON g.FACULTY = f.FACULTY
    INNER JOIN STUDENT s ON s.IDGROUP = g.IDGROUP
    WHERE f.FACULTY = @faculty;
    RETURN @count;
END;

SELECT dbo.COUNT_STUDENTS('ТОВ') AS TotalStudents;

-----

ALTER FUNCTION COUNT_STUDENTS
(
    @faculty varchar(20),
    @prof varchar(20) = NULL
)
RETURNS INT
AS
BEGIN
    DECLARE @count INT;
    SELECT @count = COUNT(*) 
    FROM FACULTY f
    INNER JOIN GROUPS g ON g.FACULTY = f.FACULTY
    INNER JOIN STUDENT s ON s.IDGROUP = g.IDGROUP
    WHERE f.FACULTY = @faculty
    AND (@prof IS NULL OR g.PROFESSION = @prof);
    RETURN @count;
END;

SELECT dbo.COUNT_STUDENTS('ХТиТ', '1-40 01 02') AS TotalStudents;


----------------------ЗАДАНИЕ 2-------------------------


CREATE FUNCTION FSUBJECTS
(
    @p varchar(20)
)
RETURNS varchar(300)
AS
BEGIN
    DECLARE @subjects varchar(300) = 'Перечень дисциплин: ';
    DECLARE @subjectName varchar(100);

    DECLARE subjectCursor CURSOR LOCAL 
	for SELECT SUBJECT_T
    FROM SUBJECT_T WHERE PULPIT = @p;

    OPEN subjectCursor;
    FETCH NEXT FROM subjectCursor INTO @subjectName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @subjects = @subjects + ', ' + RTRIM(@subjectName);
        FETCH NEXT FROM subjectCursor INTO @subjectName;
    END;

    CLOSE subjectCursor;
    DEALLOCATE subjectCursor;

    RETURN @subjects;
END;


SELECT dbo.FSUBJECTS('ТНВиОХТ') AS SubjectList;
SELECT dbo.FSUBJECTS('ИСиТ') AS SubjectList;


select PULPIT, dbo.FSUBJECTS(PULPIT) from PULPIT


----------------------ЗАДАНИЕ 3-------------------------

CREATE FUNCTION FFACPUL
(
    @facultyCode char(10) = NULL,
    @pulpitCode char(20) = NULL
)
RETURNS TABLE
AS
RETURN
(
    SELECT P.PULPIT, F.FACULTY
    FROM PULPIT P
    LEFT JOIN FACULTY F ON P.FACULTY = F.FACULTY
    WHERE (@facultyCode IS NULL OR F.FACULTY = @facultyCode)
    AND (@pulpitCode IS NULL OR P.PULPIT = @pulpitCode)
);

DROP FUNCTION FFACPUL;

select * from dbo.FFACPUL(NULL, NULL);
select * from dbo.FFACPUL('ТТЛП', NULL);
select * from dbo.FFACPUL(NULL, 'ЛМиЛЗ');
select * from dbo.FFACPUL('ТТЛП', 'ЛМиЛЗ');


----------------------ЗАДАНИЕ 4-------------------------

CREATE FUNCTION FCTEACHER
(
    @pulpitCode char(20) = NULL
)
RETURNS INT
AS
BEGIN
    DECLARE @teacherCount INT;
    IF @pulpitCode IS NULL
    BEGIN
        SELECT @teacherCount = COUNT(*)
        FROM TEACHER;
    END
    ELSE
    BEGIN
        SELECT @teacherCount = COUNT(*)
        FROM TEACHER
        WHERE PULPIT = @pulpitCode;
    END;
    RETURN @teacherCount;
END;


select PULPIT, dbo.FCTEACHER(PULPIT)[Количество преподавателей] from PULPIT; 


-----------------------------------------------

CREATE FUNCTION FACULTY_REPORT
(
    @c int
)
RETURNS @fr TABLE
(
    [Факультет] varchar(50),
    [Количество кафедр] int,
    [Количество групп] int,
    [Количество студентов] int,
    [Количество специальностей] int
)
AS
BEGIN
    DECLARE cc CURSOR STATIC FOR
        SELECT FACULTY
        FROM FACULTY
        WHERE dbo.COUNT_STUDENTS(FACULTY, DEFAULT) > @c;
    DECLARE @f varchar(30);
    OPEN cc;
    FETCH cc INTO @f;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT @fr
        SELECT
            @f,
            dbo.COUNT_PULPITS(@f),
            dbo.COUNT_GROUPS(@f),
            dbo.COUNT_STUDENTS(@f, DEFAULT),
            dbo.COUNT_SPECIALTIES(@f);
        FETCH cc INTO @f;
    END
    CLOSE cc
    DEALLOCATE cc
    RETURN;
END;

------------------------------
DECLARE @c INT = 10;

DECLARE @resultTable TABLE
(
    [Факультет] varchar(50),
    [Количество кафедр] int,
    [Количество групп] int,
    [Количество студентов] int,
    [Количество специальностей] int
);

INSERT INTO @resultTable
SELECT * FROM dbo.FACULTY_REPORT(@c);

SELECT * FROM @resultTable;

--------------------------------
CREATE FUNCTION COUNT_GROUPS
(
    @faculty varchar(50)
)
RETURNS INT
AS
BEGIN
    DECLARE @groupCount INT;

    SELECT @groupCount = COUNT(*)
    FROM GROUPS
    WHERE FACULTY = @faculty;

    RETURN @groupCount;
END;


CREATE FUNCTION COUNT_PULPITS
(
    @faculty varchar(50)
)
RETURNS INT
AS
BEGIN
    DECLARE @pulpitCount INT;

    SELECT @pulpitCount = COUNT(*)
    FROM PULPIT
    WHERE FACULTY = @faculty;

    RETURN @pulpitCount;
END;


CREATE FUNCTION COUNT_SPECIALTIES
(
    @faculty varchar(50)
)
RETURNS INT
AS
BEGIN
    DECLARE @specialtyCount INT;

    SELECT @specialtyCount = COUNT(*)
    FROM PROFESSION
    WHERE FACULTY = @faculty;

    RETURN @specialtyCount;
END;
