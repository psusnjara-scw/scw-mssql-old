CREATE TABLE [dbo].[CompanySize] (
	[CompanySizeID]			INTEGER IDENTITY (1,1)	NOT NULL,
	[CompanySizeName]		NVARCHAR(40)			NOT NULL,
	[CompanySizeDropdown]	NVARCHAR(40)			NOT NULL,

	CONSTRAINT PK_CompanySize PRIMARY KEY CLUSTERED ([CompanySizeID])
);