CREATE TABLE [dbo].[ChallengeAttemptStageAttempt] (
    [ChallengeAttemptStageAttemptID]	INTEGER			NOT NULL,
	[ChallengeAttemptStageID]				INTEGER			NOT NULL,
	[DateTimeStarted]					DATETIME2		NOT NULL,
	[DateTimeFinished]					DATETIME2		NULL,
	[StageAttemptStatus]				NVARCHAR(40)	NOT NULL,
	[StageAttemptAnswer]				NVARCHAR(MAX)	NOT NULL,

	CONSTRAINT PK_ChallengeAttemptStageAttempt PRIMARY KEY CLUSTERED ([ChallengeAttemptStageAttemptID]),
	CONSTRAINT FK_ChallengeAttemptStageAttempt_ChallengeAttemptStage_ChallengeAttemptID FOREIGN KEY (ChallengeAttemptStageID) 
				REFERENCES [dbo].[ChallengeAttemptStage] (ChallengeAttemptStageID)
)
