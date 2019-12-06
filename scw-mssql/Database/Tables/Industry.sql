CREATE TABLE [dbo].[Industry] (
	[IndustryID]		INTEGER IDENTITY (1,1)	NOT NULL,
	[IndustryName]		NVARCHAR(40)			NOT NULL,
	[IndustryDropdown]	NVARCHAR(40)			NOT NULL,

	CONSTRAINT PK_Industry PRIMARY KEY CLUSTERED ([IndustryID])
);