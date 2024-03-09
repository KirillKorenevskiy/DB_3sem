USE [UNIVER]
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

