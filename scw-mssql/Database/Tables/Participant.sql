CREATE TABLE [dbo].[Participant] (	
    [ParticipantID]			INTEGER IDENTITY(1,1)	NOT NULL,
    [ParticipantObject_id]	NVARCHAR(40)			NOT NULL,
    [UserID]				INTEGER 				NOT NULL,
    [TournamentID]			INTEGER 				NOT NULL,
    [ParticipantDisabled]	BIT						NOT NULL,
    [HomeCountry]			NCHAR(2)				NULL,
    [Points]				INTEGER					NOT NULL,
	[CreatedDate]			DATETIME2				NOT NULL, -- from properties of _id
    
	CONSTRAINT PK_Participant PRIMARY KEY CLUSTERED ([ParticipantID]),
	CONSTRAINT FK_Participant_SCWUser_UserID FOREIGN KEY (UserID) REFERENCES [dbo].[SCWUser] (UserID),
	CONSTRAINT FK_Participant_Tournament_TournamentID FOREIGN KEY (TournamentID) REFERENCES [dbo].[Tournament] (TournamentID)
);

