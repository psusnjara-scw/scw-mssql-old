CREATE TABLE [dbo].[RealmLevel]
(
    [RealmLevelID]			INTEGER IDENTITY(1,1)	NOT NULL,
	[RealmID]				INTEGER					NOT NULL,
	[RealmLevelDesc]		NVARCHAR(40)			NOT NULL,

	CONSTRAINT PK_RealmLevel PRIMARY KEY CLUSTERED ([RealmLevelID]),
	CONSTRAINT FK_RealmLevel_Realm_RealmID FOREIGN KEY (RealmID) REFERENCES [dbo].[Realm] (RealmID)

)

