USE [UNIVER]
GO

/****** Object:  StoredProcedure [dbo].[PSUBJECT_T]    Script Date: 03.12.2023 2:13:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[PSUBJECT_T] @p varchar(20) = NULL
AS
BEGIN
    CREATE TABLE #SUBJECT (
        COLUMN1 INT,
        COLUMN2 VARCHAR(50),
        COLUMN3 VARCHAR(50),
    );
    INSERT INTO #SUBJECT
    EXECUTE PSUBJECT_T @p;
    SELECT * FROM #SUBJECT;
    DROP TABLE #SUBJECT;
END;
GO
DECLARE @p varchar(20);
EXEC PSUBJECT_T @p = 'ศั่า';

