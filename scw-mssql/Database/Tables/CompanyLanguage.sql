CREATE TABLE [dbo].[CompanyLanguage] (
	[CompanyLanguageID]		INTEGER IDENTITY (1,1)	NOT NULL,
	[CompanyID]				INTEGER					NOT NULL,
	[LanguageID]			INTEGER					NOT NULL,

    CONSTRAINT PK_CompanyLanguage PRIMARY KEY CLUSTERED ([CompanyLanguageID]),
	CONSTRAINT FK_CompanyLanguage_Company_CompanyID FOREIGN KEY (CompanyID) REFERENCES [dbo].[Company] (CompanyID),
	CONSTRAINT FK_CompanyLanguage_Language_LanguageID FOREIGN KEY (LanguageID) REFERENCES [dbo].[Language] (LanguageID)

);
