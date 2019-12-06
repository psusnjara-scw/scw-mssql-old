CREATE TABLE [dbo].[Challenge] (
    [ChallengeID]				INTEGER IDENTITY(1,1)	NOT NULL,
    [ChallengeObject_id]		NVARCHAR(40)			NOT NULL,
    [Challenge__v]				INTEGER					NULL,  -- Doesn't appear to be in the newer document structure
    [RepositoryID]				INTEGER					NULL,
	[ChallengeCategory]			NVARCHAR(40)			NOT NULL,
	[ChallengeSubCategory]		NVARCHAR(40)			NOT NULL,
    [ChallengeDescription]		NVARCHAR(200)			NOT NULL,
    [ChallengeDifficulty]		INTEGER					NOT NULL,
    [ChallengeStatus]			NVARCHAR(20)			NOT NULL,
	[VulnerabilityStatus]		NVARCHAR(20)			NOT NULL,
	[VulnerabilitySourceRef]	NVARCHAR(20)			NOT NULL,

    CONSTRAINT PK_Challenge PRIMARY KEY CLUSTERED ([ChallengeID]),
	CONSTRAINT FK_Challenge_Repository_RepositoryID FOREIGN KEY (RepositoryID) REFERENCES [dbo].[Repository] (RepositoryID)
);