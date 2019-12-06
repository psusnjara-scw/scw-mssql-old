CREATE TABLE [dbo].[ChallengeAttemptCategory] (
    [ChallengeAttemptCategoryID]	INTEGER			NOT NULL,
	[ChallengeAttemptID]			INTEGER			NOT NULL,
	[ChallengeAttemptType]			NVARCHAR(40)	NOT NULL,
	[ChallengeAttemptDesc]			NVARCHAR(40)	NOT NULL,
	[ChallengeAttemptSubCategory]	NVARCHAR(40)	NOT NULL,

	CONSTRAINT PK_ChallengeAttemptCategory PRIMARY KEY CLUSTERED ([ChallengeAttemptCategoryID]),
	CONSTRAINT FK_ChallengeAttemptCategory_ChallengeAttempt_ChallengeAttemptID FOREIGN KEY (ChallengeAttemptID) 
				REFERENCES [dbo].[ChallengeAttempt] (ChallengeAttemptID)
)
