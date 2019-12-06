CREATE TABLE [dbo].[CompanyAllowance] (
    [CompanyAllowanceID]		INTEGER IDENTITY (1,1)	NOT NULL,
	[CompanyAllowanceTypeID]	INTEGER					NOT NULL,
	[CompanyID]					INTEGER					NOT NULL,
	[AvailableLicences]			INTEGER					NOT NULL CONSTRAINT DF_CompanyAllowance_AvailableLicences DEFAULT (0),
    [GrantedLicences]			INTEGER					NOT NULL,
    [UsedLicences]				INTEGER					NOT NULL CONSTRAINT DF_CompanyAllowance_UsedLicences DEFAULT (0),
    [ReservedLicences]			INTEGER					NOT NULL CONSTRAINT DF_CompanyAllowance_ReservedLicences DEFAULT (0),
    [LicenseType]				NVARCHAR(50)			NOT NULL CONSTRAINT DF_CompanyAllowance_LicenseType DEFAULT ('unlimited'), -- should this be in a reference table ?
    [TolerantStatus]			BIT						NOT NULL,
    [GrantedOverrun]			INTEGER					NOT NULL,
    [AvailableOverrun]			INTEGER					NOT NULL,
    [ReservedOverrun]			INTEGER					NOT NULL,
    [UsedOverrun]				INTEGER					NOT NULL,
	
    CONSTRAINT PK_CompanyAllowance PRIMARY KEY CLUSTERED ([CompanyAllowanceID]),
	CONSTRAINT FK_CompanyAllowance_Company_CompanyID FOREIGN KEY (CompanyID) REFERENCES [dbo].[Company] (CompanyID),
	CONSTRAINT FK_CompanyAllowance_LicenceAllowanceType_CompanyAllowanceTypeID FOREIGN KEY (CompanyAllowanceTypeID) REFERENCES [dbo].[LicenceAllowanceType] (LicenceAllowanceTypeID)
);
