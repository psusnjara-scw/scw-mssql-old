CREATE TABLE [dbo].[RepositoryLanguage] (
	[RepositoryLanguageID]		INTEGER IDENTITY (1,1)	NOT NULL,
	[RepositoryID]				INTEGER					NOT NULL,
	[LanguageID]				INTEGER					NOT NULL,

    CONSTRAINT PK_RepositoryLanguage PRIMARY KEY CLUSTERED ([RepositoryLanguageID]),
	CONSTRAINT FK_RepositoryLanguage_Repository_RepositoryID FOREIGN KEY (RepositoryID) REFERENCES [dbo].[Repository] (RepositoryID),
	CONSTRAINT FK_RepositoryLanguage_Language_LanguageID FOREIGN KEY (LanguageID) REFERENCES [dbo].[Language] (LanguageID)

);
