USE [SEDC-homework]
GO

DECLARE @FirstName nvarchar(100)
SET @FirstName = 'Antonio'
SELECT * FROM Student
WHERE FirstName = @FirstName
GO

DECLARE @StudentsTable TABLE (StudentId int, StudentName nvarchar(201), DateOfBirth date)
INSERT INTO @StudentsTable
SELECT Id, CONCAT(FirstName, N' ', LastName), DateOfBirth
FROM Student
WHERE Gender = 'F'
SELECT * FROM @StudentsTable
GO

CREATE TABLE #TableOfStudents (LastName nvarchar(100), EnrolledDate date)
INSERT INTO #TableOfStudents
SELECT LastName, EnrolledDate
FROM Student
WHERE Gender = 'M' and FirstName like 'A%'

SELECT * FROM #TableOfStudents
WHERE LEN(LastName) = 7
GO

DROP TABLE #TableOfStudents
GO
-------------------------------------
CREATE FUNCTION dbo.fn_FormatStudentName (@StudentId int)
RETURNS Nvarchar(100)
AS 
BEGIN
	DECLARE @Result Nvarchar(100)

	SELECT @Result = SUBSTRING(StudentCardNumber,4,LEN(StudentCardNumber)-2) + '-' + left(FirstName,1) + '.' + LastName
	FROM Student 
	WHERE Student.Id = @StudentId

	RETURN @Result
END
GO

SELECT *, dbo.fn_FormatStudentName(Id) as FunctionOutput FROM Student
GO
--------------------------------------
CREATE FUNCTION dbo.fn_StudentsPassedExam (@TeacherId smallint,@CourseId smallint)
RETURNS @ResultTable TABLE 
	(FirstName nvarchar(100),
	 LastName nvarchar(100),
	 Grade tinyint,
	 CreatedDateTime datetime)
AS
BEGIN
	INSERT INTO @ResultTable
	SELECT 
		s.FirstName as StudentFirstName, 
		s.LastName as StudentLastName, 
		Grade, 
		CreatedDate
	FROM dbo.Grade g
	inner join dbo.Student s on s.Id = g.StudentId
	WHERE g.TeacherId = @TeacherId
	and g.CourseId = @CourseId
	and g.Grade >= 6
	GROUP BY  
		s.FirstName,
		s.LastName,
		g.Grade,
		g.CreatedDate
	RETURN 
END
GO
DECLARE @TeacherId smallint
SET @TeacherId = 0
DECLARE @CourseId smallint
SET @CourseId = 0
SELECT * FROM dbo.fn_StudentsPassedExam(@TeacherId, @CourseId)
GO
