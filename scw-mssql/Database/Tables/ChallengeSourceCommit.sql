CREATE TABLE [dbo].[ChallengeSourceCommit] (
    [ChallengeSourceCommitID]	INTEGER IDENTITY(1,1)	NOT NULL,
	[ChallengeID]				INTEGER					NOT NULL,
	[CommitID]					NVARCHAR(60)			NOT NULL,
    [Title]						NVARCHAR(60)			NOT NULL,
    [Message]					NVARCHAR(80)			NOT NULL,
    [ShortID]					NVARCHAR(20)			NOT NULL,
    [CreatedDate]				DATETIME2				NOT NULL,
    [AuthorName]				NVARCHAR(60)			NOT NULL,
    [AuthorEmail]				NVARCHAR(80)			NOT NULL,
    [AuthoredDate]				DATETIME2				NOT NULL,
    [CommittedDate]				DATETIME2				NOT NULL,
    [CommitterName]				NVARCHAR(40)			NOT NULL,
    [CommitterEmail]			NVARCHAR(80)			NOT NULL,

    CONSTRAINT PK_ChallengeSourceCommit PRIMARY KEY CLUSTERED ([ChallengeSourceCommitID]),
	CONSTRAINT FK_ChallengeSourceCommit_Challenge_ChallengeID FOREIGN KEY (ChallengeID) REFERENCES [dbo].[Challenge] (ChallengeID)

);

