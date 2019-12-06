CREATE TABLE [dbo].[Game_013_log]
(
    [Game_013_logID]			INTEGER IDENTITY(1,1)	NOT NULL,
    [Game_013_logObject_id]		NVARCHAR(40)			NOT NULL,
	[Game_013_userObject_id]	NVARCHAR(40)			NULL,
	[Realm_id]					NVARCHAR(40)			NULL,
	[Level_id]					NVARCHAR(40)			NULL,
	[Quest_desc]				NVARCHAR(40)			NULL,
	[QuestAttempt_id]			NVARCHAR(40)			NULL,
	[Repository_id]				NVARCHAR(40)			NULL,
	[ChallengeObject_id]		NVARCHAR(40)			NULL,
	[cbl]						NVARCHAR(40)			NULL,
	[StartedDate]				DATETIME2				NULL,
	[CompletedDate]				DATETIME2				NULL,
	[TimeSpent]					DECIMAL(14,1)			NULL,
	[Points]					INTEGER					NULL,
	[MaxPoints]					INTEGER					NULL,
	[AttemptIndex]				NVARCHAR(40)			NULL,
	[Status]					NVARCHAR(40)			NULL,
	[isAssessment]				BIT						NULL,
	[TotalHints]				INTEGER					NULL, 
	[LanguageName]				NVARCHAR(40)			NULL,
	[LanguageFramework]			NVARCHAR(40)			NULL,
	[WasOvercomeBefore]			BIT						NULL,

    CONSTRAINT PK_Game_013_log PRIMARY KEY CLUSTERED ([Game_013_logID]),

);

