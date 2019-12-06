CREATE TABLE [dbo].[AssessmentAttemptLanguage] (
	[AssessmentAttemptLanguageID]	INTEGER IDENTITY (1,1)	NOT NULL,
	[AssessmentAttemptID]			INTEGER					NOT NULL,
	[LanguageID]					INTEGER					NOT NULL,

    CONSTRAINT PK_AssessmentAttemptLanguage PRIMARY KEY CLUSTERED ([AssessmentAttemptLanguageID]),
	CONSTRAINT FK_AssessmentAttemptLanguage_AssessmentAttempt_AssessmentAttemptID FOREIGN KEY (AssessmentAttemptID) 
		REFERENCES [dbo].[AssessmentAttempt] (AssessmentAttemptID),
	CONSTRAINT FK_AssessmentAttemptLanguage_Language_LanguageID FOREIGN KEY (LanguageID) REFERENCES [dbo].[Language] (LanguageID)

);
