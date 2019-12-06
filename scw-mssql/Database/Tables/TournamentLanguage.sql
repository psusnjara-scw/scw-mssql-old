CREATE TABLE [dbo].[TournamentLanguage] (
	[TournamentLanguageID]		INTEGER IDENTITY (1,1)	NOT NULL,
	[TournamentID]				INTEGER					NOT NULL,
	[LanguageID]				INTEGER					NOT NULL,

    CONSTRAINT PK_TournamentLanguage PRIMARY KEY CLUSTERED ([TournamentLanguageID]),
	CONSTRAINT FK_TournamentLanguage_Tournament_TournamentID FOREIGN KEY (TournamentID) REFERENCES [dbo].[Tournament] (TournamentID),
	CONSTRAINT FK_TournamentLanguage_Language_LanguageID FOREIGN KEY (LanguageID) REFERENCES [dbo].[Language] (LanguageID)

);
