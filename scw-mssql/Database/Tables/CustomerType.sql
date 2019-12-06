CREATE TABLE [dbo].[CustomerType] (
	[CustomerTypeID]		INTEGER IDENTITY (1,1)	NOT NULL,
	[CustomerTypeName]		NVARCHAR(40)			NOT NULL,
	[CustomerTypeDropdown]	NVARCHAR(40)			NOT NULL,

	CONSTRAINT PK_CustomerType PRIMARY KEY CLUSTERED ([CustomerTypeID])
);