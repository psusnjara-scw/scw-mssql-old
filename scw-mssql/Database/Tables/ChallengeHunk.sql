CREATE TABLE [dbo].[ChallengeHunk] (
    [ChallengeHunkID]		INTEGER IDENTITY(1,1)	NOT NULL,
	[ChallengeID]			INTEGER					NOT NULL,
	[ChallengeHunkType]		NVARCHAR(20)			NOT NULL,
	[HunkDescription]		NVARCHAR(60)			NOT NULL,

    CONSTRAINT PK_ChallengeHunk PRIMARY KEY CLUSTERED ([ChallengeHunkID]),
	CONSTRAINT FK_ChallengeHunk_Challenge_ChallengeID FOREIGN KEY (ChallengeID) REFERENCES [dbo].[Challenge] (ChallengeID)

);

