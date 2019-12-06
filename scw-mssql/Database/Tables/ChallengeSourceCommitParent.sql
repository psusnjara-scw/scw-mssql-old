CREATE TABLE [dbo].[ChallengeSourceCommitParent]
(
	[ChallengeSourceCommitParentID] INTEGER IDENTITY(1,1)	NOT NULL,
	[ChallengeSourceCommitID]		INTEGER 				NOT NULL,
	[ParentID]						NVARCHAR(80)			NOT NULL,

	CONSTRAINT PK_ChallengeSourceCommitParent PRIMARY KEY CLUSTERED ([ChallengeSourceCommitParentID]),
	CONSTRAINT FK_ChallengeSourceCommitParent_ChallengeSourceCommitID_ChallengeSourceCommitID 
		FOREIGN KEY (ChallengeSourceCommitID) REFERENCES [dbo].[ChallengeSourceCommit] (ChallengeSourceCommitID)
);
