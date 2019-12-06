CREATE TABLE [dbo].[QuestAttempt] (
    [QuestAttemptID]		INTEGER IDENTITY(1,1)	NOT NULL,
    [QuestAttemptObject_id] NVARCHAR(40)			NOT NULL,
    [QuestID]				INTEGER					NOT NULL,
	[ParticipantID]			INTEGER					NOT NULL,
    [AppType]				NVARCHAR(40)			NULL,
    [AppName]				NVARCHAR(60)			NULL,
    [CompanyName]			NVARCHAR(100)			NULL,  -- Does not appear to be a FK to company
    [AttackerType]			NVARCHAR(40)			NULL,
    [AttackingCountry]		NCHAR(2)				NULL,
    [QuestIndex]			INTEGER					NULL,
	[CreatedDate]			DATETIME2				NOT NULL, -- from properties of _id

	CONSTRAINT PK_QuestAttempt PRIMARY KEY CLUSTERED ([QuestAttemptID]),
	CONSTRAINT FK_QuestAttempt_Quest_QuestID FOREIGN KEY (QuestID) REFERENCES [dbo].[Quest] (QuestID),
	CONSTRAINT FK_QuestAttempt_Participant_ParticipantID FOREIGN KEY (ParticipantID) REFERENCES [dbo].[Participant] (ParticipantID)
    
);