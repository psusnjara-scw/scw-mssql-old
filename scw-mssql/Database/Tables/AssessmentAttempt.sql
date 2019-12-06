CREATE TABLE [dbo].[AssessmentAttempt]
(
	[AssessmentAttemptID]				INTEGER IDENTITY(1,1)	NOT NULL,
    [AssessmentID]						INTEGER 				NOT NULL,
	[AssessmentAttemptObject_id]		NVARCHAR(40)			NOT NULL,
	[UserID]							INTEGER					NOT NULL,
	[OwnerID]							INTEGER					NOT NULL,
	[AuthorID]							INTEGER					NOT NULL,
	[AssessmentStatus]					NVARCHAR(40)			NOT NULL,
	[AssessmentStartDate]				DATETIME2				NOT NULL,
	[AssessmentEndDate]					DATETIME2				NULL,
	[MaxPoints]							INTEGER					NOT NULL,
	[EarnedPoints]						INTEGER					NOT NULL,
	[CorrectAnswers]					INTEGER					NOT NULL,
	[IncorrectAnswers]					INTEGER					NOT NULL,
	[Completed]							INTEGER					NOT NULL,
	[NoChallenges]						INTEGER					NOT NULL,
	[Deadline]							DATETIME2				NULL,
	[SuccessRatio]						INTEGER					NOT NULL,
	[InviteSent]						DATETIME2				NULL,
	[isRetry]							BIT						NULL,
	[AssessmentFlag]					BIT						NULL,

	CONSTRAINT PK_AssessmentAttempt PRIMARY KEY CLUSTERED ([AssessmentAttemptID]),
	CONSTRAINT FK_AssessmentAttempt_Assessment_AssessmentID FOREIGN KEY (AssessmentID) REFERENCES [dbo].[Assessment] (AssessmentID),
	CONSTRAINT FK_AssessmentAttempt_SCWUser_UserID FOREIGN KEY (UserID) REFERENCES [dbo].[SCWUser] (UserID),
	CONSTRAINT FK_AssessmentAttempt_SCWUser_OwnerID FOREIGN KEY (OwnerID) REFERENCES [dbo].[SCWUser] (UserID),
	CONSTRAINT FK_AssessmentAttempt_SCWUser_AuthorID FOREIGN KEY (AuthorID) REFERENCES [dbo].[SCWUser] (UserID)

)
