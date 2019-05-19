USE [SEDC-homework]
GO
--------------------------
SELECT * FROM Student WHERE FirstName = 'Antonio'
SELECT * FROM Student WHERE DateOfBirth > '1999-01-01'
SELECT * FROM Student WHERE Gender = 'M'
SELECT * FROM Student WHERE LastName like 'T%'
SELECT * FROM Student WHERE EnrolledDate >= '1998-01-01' and EnrolledDate < '1998-02-01'
SELECT * FROM Student WHERE EnrolledDate >= '1998-01-01' and EnrolledDate < '1998-02-01' and LastName like 'J%'
GO
--------------------------
SELECT * FROM Student WHERE FirstName = 'Antonio' ORDER BY LastName
SELECT * FROM Student ORDER BY FirstName
SELECT * FROM Student WHERE Gender = 'M' ORDER BY EnrolledDate DESC
GO
---------------------------
SELECT FirstName FROM Teacher
UNION ALL
SELECT FirstName FROM Student
GO

SELECT LastName FROM Teacher
UNION
SELECT LastName FROM Student
GO

SELECT FirstName FROM Teacher
INTERSECT
SELECT FirstName FROM Student
GO
-------------------------
ALTER TABLE GradeDetails WITH CHECK
ADD CONSTRAINT DF_GradeDetails_AchievementMaxPoints 
DEFAULT 100 FOR [AchievementMaxPoints]
GO

ALTER TABLE GradeDetails WITH CHECK
ADD CONSTRAINT CHK_GradeDetails_AchievementPoints 
CHECK (AchievementPoints <= AchievementMaxPoints);
GO

ALTER TABLE AchievementType WITH CHECK
ADD CONSTRAINT UC_AchievementType_Name UNIQUE (Name)
GO
----------------------------
ALTER TABLE Grade WITH CHECK
ADD CONSTRAINT FK_Grade_StudentId
FOREIGN KEY (StudentId)
REFERENCES Student (Id)
GO
ALTER TABLE Grade WITH CHECK
ADD CONSTRAINT FK_Grade_CourseId
FOREIGN KEY (CourseId)
REFERENCES Course (Id)
GO
ALTER TABLE Grade WITH CHECK
ADD CONSTRAINT FK_Grade_TeacherId
FOREIGN KEY (TeacherId)
REFERENCES Teacher (Id)
GO

ALTER TABLE GradeDetails WITH CHECK
ADD CONSTRAINT FK_GradeDetails_GradeId
FOREIGN KEY (GradeId)
REFERENCES Grade (Id)
GO
ALTER TABLE GradeDetails WITH CHECK
ADD CONSTRAINT FK_GradeDetails_AchievementTypeId
FOREIGN KEY (AchievementTypeId)
REFERENCES AchievementType (Id)
GO
----------------------------
SELECT c.Name as CourseName, a.Name as AchievementName
FROM Course c CROSS JOIN AchievementType a
GO

SELECT DISTINCT t.*
FROM Grade g INNER JOIN Teacher t ON t.Id = g.TeacherId
GO

SELECT DISTINCT t.* FROM Teacher t
LEFT JOIN Grade g ON t.Id = g.TeacherId 
WHERE g.TeacherId is null
GO

SELECT s.*
FROM Grade g RIGHT JOIN Student s ON g.StudentId = s.Id
WHERE g.StudentId is null
GO
