CREATE TABLE [dbo].[Quest] (
    [QuestID]				INTEGER IDENTITY(1,1)	NOT NULL,
    [QuestObject_id]		VARBINARY(12)			NOT NULL,
    [TournamentID]			INTEGER					NOT NULL,
	[StateID]				INTEGER					NOT NULL,
    [AppType]				NVARCHAR(20)			NULL,
    [QuestName]				NVARCHAR(60)			NOT NULL,
    [QuestDescription]		NVARCHAR(200)			NULL,
    [QuestIndex]			INTEGER					NULL,
    
	CONSTRAINT PK_Quest PRIMARY KEY CLUSTERED ([QuestID]),
	CONSTRAINT FK_Quest_Tournament_TournamentID FOREIGN KEY (TournamentID) REFERENCES [dbo].[Tournament] (TournamentID),
	CONSTRAINT FK_Quest_State_StateID FOREIGN KEY (StateID) REFERENCES [dbo].[State] (StateID)
);