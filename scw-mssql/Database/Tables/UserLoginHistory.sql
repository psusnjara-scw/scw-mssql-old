CREATE TABLE [dbo].[UserLoginHistory]
(
	[UserLoginHistoryID]		INTEGER IDENTITY(1,1)			NOT NULL,
	[UserID]					INTEGER							NOT NULL,
	[LoginDate]					DATETIME2						NOT NULL,

	CONSTRAINT PK_UserLoginHistory PRIMARY KEY CLUSTERED ([UserLoginHistoryID]),
	CONSTRAINT FK_UserLoginHistory_SCWUser_UserID FOREIGN KEY (UserID) REFERENCES [dbo].[SCWUser] (UserID)
)
