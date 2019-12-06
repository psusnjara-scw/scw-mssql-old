CREATE TABLE [dbo].[State]
(
    [StateID]				INTEGER IDENTITY(1,1)	NOT NULL,
	[UserID]				INTEGER					NOT NULL,
	[RealmID]				INTEGER					NOT NULL,
	[RealmLevelID]			INTEGER					NOT NULL,
	[StateStatus]			NVARCHAR(40)			NOT NULL,

	CONSTRAINT PK_State PRIMARY KEY CLUSTERED ([StateID]),
	CONSTRAINT FK_State_SCWUser_UserID FOREIGN KEY (UserID) REFERENCES [dbo].[SCWUser] (UserID),
	CONSTRAINT FK_State_Realm_RealmID FOREIGN KEY (RealmID) REFERENCES [dbo].[Realm] (RealmID),
	CONSTRAINT FK_State_RealmLevel_RealmLevelID FOREIGN KEY (RealmLevelID) REFERENCES [dbo].[RealmLevel] (RealmLevelID)

)
