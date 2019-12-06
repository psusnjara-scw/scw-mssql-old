CREATE TABLE [dbo].[ChallengeAttemptStage] (
    [ChallengeAttemptStageID]		INTEGER			NOT NULL,
	[ChallengeAttemptID]			INTEGER			NOT NULL,
	[MaxPoints]						INTEGER			NOT NULL,
	[EarnedPoints]					INTEGER			NOT NULL,
	[MaxForAttempt]					INTEGER			NOT NULL,
	[TotalPointsPenalised]			INTEGER			NOT NULL,
	[UsedHints]						INTEGER			NOT NULL,
	[Difficulty]					NVARCHAR(40)	NOT NULL,
	[IsCorrect]						BIT				NOT NULL,
	[IsComplex]						BIT				NOT NULL,
	[MaxAttempts]					INTEGER			NOT NULL,
	[Base]							INTEGER			NOT NULL,
	[AppScaling]					INTEGER			NOT NULL,
	[DiffScaling]					INTEGER			NOT NULL,
	[FailedAttempts]				INTEGER			NOT NULL,
	[FailedAttemptScaling]			INTEGER			NOT NULL,
	[HintsGiven]					INTEGER			NOT NULL,
	[HintsGivenScaling]				INTEGER			NOT NULL,


	CONSTRAINT PK_ChallengeAttemptStage PRIMARY KEY CLUSTERED ([ChallengeAttemptStageID]),
	CONSTRAINT FK_ChallengeAttemptStage_ChallengeAttempt_ChallengeAttemptID FOREIGN KEY (ChallengeAttemptID) 
				REFERENCES [dbo].[ChallengeAttempt] (ChallengeAttemptID)
)