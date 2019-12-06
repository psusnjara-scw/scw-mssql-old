CREATE TABLE [dbo].[Language] (
	[LanguageID]				INTEGER IDENTITY(1,1)	NOT NULL,
	[LanguageName]				NVARCHAR(40)			NOT NULL,
	[LanguageFramework]			NVARCHAR(40)			NOT NULL,
	[LanguageNameDropdown]		NVARCHAR(40)			NOT NULL,
	[LanguageFrameworkDropdown] NVARCHAR(40)			NOT NULL,

	CONSTRAINT PK_Language PRIMARY KEY CLUSTERED ([LanguageID])
);