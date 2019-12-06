CREATE TABLE [dbo].[LicenceAllowanceType] (
	[LicenceAllowanceTypeID]		INTEGER IDENTITY(1,1)	NOT NULL,
	[LicenceAllowanceTypeDesc]		NVARCHAR(30)			NOT NULL,
	[LicenceAllowanceTypeDropDown]	NVARCHAR(30)			NOT NULL,

	CONSTRAINT PK_LicenceAllowanceType PRIMARY KEY CLUSTERED ([LicenceAllowanceTypeID])
);
