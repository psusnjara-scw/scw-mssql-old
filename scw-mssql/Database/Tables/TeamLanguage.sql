CREATE TABLE [dbo].[TeamLanguage] (
	[TeamLanguageID]	INTEGER IDENTITY (1,1)	NOT NULL,
	[TeamID]			INTEGER					NOT NULL,
	[LanguageID]		INTEGER					NOT NULL,

    CONSTRAINT PK_TeamLanguage PRIMARY KEY CLUSTERED ([TeamLanguageID]),
	CONSTRAINT FK_TeamLanguage_Team_TeamID FOREIGN KEY (TeamID) REFERENCES [dbo].[Team] (TeamID),
	CONSTRAINT FK_TeamLanguage_Language_TeamLanguageID FOREIGN KEY (TeamLanguageID) REFERENCES [dbo].[Language] (LanguageID)
	
);
