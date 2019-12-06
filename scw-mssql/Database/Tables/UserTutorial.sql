CREATE TABLE [dbo].[UserTutorial]
(
	[UserTutorialID]				INTEGER IDENTITY(1,1)		NOT NULL,
	[UserID]						INTEGER						NOT NULL,
	[UserTutorialStatus]			BIT							NOT NULL,
	[VulnerabilityTutorialStatus]	BIT							NOT NULL,
	[HunksTutorialStatus]			BIT							NOT NULL,
	[LinesTutorialStatus]			BIT							NOT NULL,
	[SolutionTutorialStatus]		BIT							NOT NULL,
	[WorldMapStatus]				BIT							NOT NULL,
		
	CONSTRAINT PK_UserTutorial PRIMARY KEY CLUSTERED ([UserTutorialID]),
	CONSTRAINT FK_UserTutorial_SCWUser_UserID FOREIGN KEY (UserID) REFERENCES [dbo].[SCWUser] (UserID)
)
