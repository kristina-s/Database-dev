USE [SEDC-homework]
GO

CREATE OR ALTER PROCEDURE usp_CreateGrade
(
	@StudentId int,
	@CourseId smallint,
	@TeacherId smallint,
	@Grade tinyint,
	@CreatedDate datetime)
AS
BEGIN
	INSERT INTO Grade(StudentId, CourseId, TeacherId, Grade, CreatedDate)
	VALUES(@StudentId, @CourseId, @TeacherId, @Grade, @CreatedDate)

	SELECT COUNT(*) as AllGrades FROM Grade
	WHERE StudentId = @StudentId

	SELECT MAX(Grade) as MaxGrade FROM Grade
	WHERE StudentId = @StudentId AND TeacherId = @TeacherId

END
EXEC usp_CreateGrade
	@StudentId = 5,
	@CourseId = 2,
	@TeacherId = 1,
	@Grade = 9,
	@CreatedDate = '2019-06-02'
GO
---------------------------
CREATE OR ALTER PROCEDURE usp_CreateGradeDetails
(
	@GradeID int,
	@AchievementTypeID tinyint,
	@AchievementPoints tinyint,
	@AchievementMaxPoints tinyint = 100,
	@AchievementDate datetime
	)
AS
BEGIN
	DECLARE @ParticipationRate tinyint
	DECLARE @GradePoints tinyint
	

	SELECT @ParticipationRate = ParticipationRate FROM AchievementType WHERE Id = @AchievementTypeID
	BEGIN TRY
	INSERT INTO GradeDetails(GradeId, AchievementTypeId, AchievementPoints, AchievementMaxPoints, AchievementDate)
	VALUES(@GradeID, @AchievementTypeID, @AchievementPoints, @AchievementMaxPoints, @AchievementDate)
	
	SELECT @GradePoints = @AchievementPoints / @AchievementMaxPoints * @ParticipationRate  

	SELECT SUM(@GradePoints) as GradePointsSum
	FROM Grade g
	INNER JOIN GradeDetails gd ON g.Id = gd.GradeId
	WHERE g.Id = @GradeID
	END TRY	
	BEGIN CATCH
		SELECT
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() AS ErrorState,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage
	END CATCH
END
GO

SELECT * FROM Grade ORDER BY Id DESC
GO

EXEC usp_CreateGradeDetails
	@GradeId = 20124,
	@AchievementTypeId = 22,
	@AchievementPoints = 75,
	@AchievementDate = '2019-06-02'
GO

SELECT * FROM GradeDetails ORDER BY Id DESC
GO