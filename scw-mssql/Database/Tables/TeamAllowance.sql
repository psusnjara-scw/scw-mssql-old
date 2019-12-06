CREATE TABLE [dbo].[TeamAllowance] (
    [TeamAllowanceID]			INTEGER IDENTITY (1,1)	NOT NULL,
	[TeamAllowanceTypeID]		INTEGER					NOT NULL,
	[TeamID]					INTEGER					NOT NULL,
	[LicenseType]				NVARCHAR(50)			NOT NULL,
	[AvailableLicences]			INTEGER					NOT NULL,
    [GrantedLicences]			INTEGER					NOT NULL,
    [UsedLicences]				INTEGER					NOT NULL,
    [ReservedLicences]			INTEGER					NOT NULL,
    [GrantedOverrun]			INTEGER					NOT NULL,
    [AvailableOverrun]			INTEGER					NOT NULL,
    [ReservedOverrun]			INTEGER					NOT NULL,
    [UsedOverrun]				INTEGER					NOT NULL,
	
    CONSTRAINT PK_TeamAllowance PRIMARY KEY CLUSTERED ([TeamAllowanceID]),
	CONSTRAINT FK_TeamAllowance_LicenceAllowanceType_TeamAllowanceTypeID FOREIGN KEY (TeamAllowanceTypeID) REFERENCES [dbo].[LicenceAllowanceType] (LicenceAllowanceTypeID),
	CONSTRAINT FK_TeamAllowance_Team_TeamID FOREIGN KEY (TeamID) REFERENCES [dbo].[Team] (TeamID)
);
