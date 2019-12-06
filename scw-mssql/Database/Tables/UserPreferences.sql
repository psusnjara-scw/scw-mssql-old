CREATE TABLE [dbo].[UserPreferences]
(
	[UserPreferencesID]			INTEGER IDENTITY(1,1)	NOT NULL,
	[UserID]					INTEGER					NOT NULL,
	[UserPreferenceValuesID]	INTEGER					NOT NULL,
	
	CONSTRAINT PK_UserPreferences PRIMARY KEY CLUSTERED ([UserPreferencesID]),
	CONSTRAINT FK_UserPreferences_SCWUser_UserID FOREIGN KEY (UserID) REFERENCES [dbo].[SCWUser] (UserID),
	CONSTRAINT FK_UserPreferences_UserPreferenceValues_ValuesID FOREIGN KEY (UserPreferenceValuesID) REFERENCES dbo.UserPreferenceValues (UserPreferenceValuesID)
)
