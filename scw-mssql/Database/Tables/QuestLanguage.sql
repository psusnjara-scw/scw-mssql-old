CREATE TABLE [dbo].[QuestLanguage] (
	[QuestLanguageID]	INTEGER IDENTITY (1,1)	NOT NULL,
	[QuestID]			INTEGER					NOT NULL,
	[LanguageID]		INTEGER					NOT NULL,

    CONSTRAINT PK_QuestLanguage PRIMARY KEY CLUSTERED ([QuestLanguageID]),
	CONSTRAINT FK_QuestLanguage_Quest_QuestID FOREIGN KEY (QuestID) REFERENCES [dbo].[Quest] (QuestID),
	CONSTRAINT FK_QuestLanguage_Language_LanguageID FOREIGN KEY (LanguageID) REFERENCES [dbo].[Language] (LanguageID)

);
