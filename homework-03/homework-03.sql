USE [SEDC-homework]
GO

SELECT 
	COUNT(Grade) AS TotalGrades
FROM 
	Grade
GO

SELECT 
	TeacherId, 
	COUNT(Grade) AS GradeCount
FROM
	Grade
GROUP BY
	TeacherId
ORDER BY
	TeacherId
GO

SELECT 
	TeacherId, 
	COUNT(Grade) AS GradeCount
FROM
	Grade
WHERE 
	StudentId < 100
GROUP BY
	TeacherId
ORDER BY
	TeacherId
GO

SELECT
	StudentId,
	MAX(Grade) AS  MaxGrade,
	AVG(Grade) AS AverageGrade
FROM
	Grade
GROUP BY
	StudentId
ORDER BY
	StudentId
GO
--------------------------------
SELECT
	TeacherId,
	COUNT(Grade) AS GradeCount
FROM 
	Grade
GROUP BY
	TeacherId
HAVING
	COUNT(Grade) > 200
ORDER BY
	TeacherId
GO

SELECT
	TeacherId,
	COUNT(Grade) AS GradeCount
FROM 
	Grade
WHERE
	StudentId < 100
GROUP BY
	TeacherId
HAVING
	COUNT(Grade) > 50
ORDER BY
	TeacherId
GO

-- requirement 3 & 4 are here
SELECT
	StudentId,
	s.FirstName AS FirstName,
	s.LastName AS  LastName,
	COUNT(Grade) AS GradeCount,
	MAX(Grade) AS  MaxGrade,
	AVG(Grade) AS AverageGrade
FROM 
	Grade as g
	INNER JOIN Student as s ON g.StudentId = s.Id
GROUP BY
	StudentId,
	s.FirstName,
	s.LastName
HAVING
	MAX(Grade) = AVG(Grade)
ORDER BY
	StudentId
GO
----------------------------------
CREATE VIEW vv_StudentGrades
AS
SELECT
	StudentId,
	COUNT(Grade) AS GradeCount
FROM
	Grade
GROUP BY
	StudentId
GO

ALTER VIEW vv_StudentGrades
AS
SELECT
	s.FirstName,
	s.LastName,
	COUNT(Grade) AS GradeCount
FROM
	Grade AS g
	INNER JOIN Student AS s ON g.StudentId = s.Id
GROUP BY
	s.FirstName,
	s.LastName
GO

SELECT * FROM vv_StudentGrades
ORDER BY
	GradeCount
GO

CREATE VIEW vv_StudentGradeDetails
AS
SELECT
	s.FirstName,
	s.LastName,
	COUNT(CourseID) AS CourseCount,
	STRING_AGG(c.Name, ',') AS CourseName
FROM
	Grade AS g
	INNER JOIN Student AS s ON g.StudentId = s.Id
	INNER JOIN Course AS c ON g.CourseId = c.Id
GROUP BY
	s.FirstName,
	s.LastName
GO

SELECT * FROM vv_StudentGradeDetails
GO