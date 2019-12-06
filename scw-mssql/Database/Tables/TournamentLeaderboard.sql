CREATE TABLE [dbo].[TournamentLeaderboard] (
	[TournamentLeaderboardID]	INTEGER IDENTITY (1,1)	NOT NULL,
	[TournamentID]				INTEGER					NOT NULL,
	[AnonymousStatus]			BIT						NOT NULL,
    [TeamVisibility]			BIT						NOT NULL,
    [TagsVisibility]			BIT						NOT NULL,
    [HideBeforeEnd]				INTEGER					NOT NULL,
    [DisplayStatus]				BIT						NOT NULL,
	[Name]						BIT						NOT NULL,
    [Rank]						BIT						NOT NULL,
    [Points]					BIT						NOT NULL,
    [JoinDate]					BIT						NOT NULL,
    [Avatar]					BIT						NOT NULL,
    [TimeSpent]					BIT						NOT NULL,
    [Accuracy]					BIT						NOT NULL,

    CONSTRAINT PK_TournamentLeaderboard PRIMARY KEY CLUSTERED ([TournamentLeaderboardID]),
	CONSTRAINT FK_TournamentLeaderboard_Tournament_TournamentID FOREIGN KEY (TournamentID) REFERENCES [dbo].[Tournament] (TournamentID)
	
);
