CREATE TABLE [dbo].[ChallengeAttempt] (
    [ChallengeAttemptID]			INTEGER			NOT NULL,
    [ChallengeAttemptObject_id]		NVARCHAR(40)	NOT NULL,
	[ChallengeID]					INTEGER			NOT NULL,
    [QuestAttemptID]				INTEGER			NOT NULL,
    [cbl]							NVARCHAR(40)	NOT NULL,
	[TotalHints]					INTEGER			NOT NULL,
	[_questAttemptChallenge]		NVARCHAR(MAX),
    [_challenge]					NVARCHAR(MAX),

    [hints_fk]						INTEGER,
    [shuffledSolutionsIdx]			NVARCHAR(MAX),
    [removedSolutions]				NVARCHAR(MAX),
    
	CONSTRAINT PK_ChallengeAttempt PRIMARY KEY CLUSTERED ([ChallengeAttemptID]),
	CONSTRAINT FK_ChallengeAttempt_Challenge_ChallengeID FOREIGN KEY (ChallengeID) REFERENCES [dbo].[Challenge] (ChallengeID)
);