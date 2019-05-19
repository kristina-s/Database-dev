USE [SEDC-homework]
GO

DROP TABLE IF EXISTS [dbo].Student;
DROP TABLE IF EXISTS [dbo].Teacher;
DROP TABLE IF EXISTS [dbo].GradeDetails;
DROP TABLE IF EXISTS [dbo].Course;
DROP TABLE IF EXISTS [dbo].Grade;
DROP TABLE IF EXISTS [dbo].AchievementType;
GO

CREATE TABLE [dbo].Student(
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[EnrolledDate] [date] NOT NULL,
	[Gender] [char](1) NOT NULL,
	[NationalIdNumber] [nvarchar](13) NOT NULL,
	[StudentCardNumber] [nvarchar](50) NOT NULL,	
	CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO

CREATE TABLE [dbo].Teacher(
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[AcademicRank] [nvarchar](50) NOT NULL,
	[HireDate] [date] NOT NULL,	
	CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO

CREATE TABLE [dbo].Course(
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Credit] [tinyint] NOT NULL,
	[AcademicYear] [tinyint] NOT NULL,
	[Semester] [tinyint] NOT NULL,
	CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO

CREATE TABLE [dbo].Grade(
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NOT NULL,
	[CourseId] [smallint] NOT NULL,
	[TeacherId] [smallint] NOT NULL,
	[Grade] [tinyint] NOT NULL,
	[Comment] [nvarchar](100) NULL,
	[CreatedDate] [datetime] NOT NULL,
	CONSTRAINT [PK_Grade] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO

CREATE TABLE [dbo].GradeDetails(
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GradeId] [int] NOT NULL,
	[AchievementTypeId] [tinyint] NOT NULL,
	[AchievementPoints] [tinyint] NOT NULL,
	[AchievementMaxPoints] [tinyint] NOT NULL,
	[AchievementDate] [datetime] NOT NULL,
	CONSTRAINT [PK_Grade.Details] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO

CREATE TABLE [dbo].AchievementType(
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[ParticipationRate] [tinyint] NOT NULL,
	CONSTRAINT [PK_AchievementType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO



