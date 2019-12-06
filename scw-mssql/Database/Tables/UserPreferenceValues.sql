CREATE TABLE [dbo].[UserPreferenceValues]
(
	[UserPreferenceValuesID]	INTEGER	IDENTITY(1,1)	NOT NULL,
	[UserPreferenceValue]		NVARCHAR(80)			NOT NULL,
	[UserPreferenceType]		NVARCHAR(80)			NOT NULL,

	CONSTRAINT PK_UserPreferenceValues PRIMARY KEY CLUSTERED ([UserPreferenceValuesID]),
);
