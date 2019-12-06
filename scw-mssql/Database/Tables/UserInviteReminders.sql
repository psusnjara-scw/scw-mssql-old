CREATE TABLE [dbo].[UserInviteReminder]
(
	[UserInviteReminderID]		INTEGER	IDENTITY(1,1)	NOT NULL,
	[UserID]					INTEGER					NOT NULL,
	[ReminderDate]				DATETIME2				NOT NULL,
	
	CONSTRAINT PK_UserInviteReminders PRIMARY KEY CLUSTERED ([UserInviteReminderID]),
	CONSTRAINT FK_UserInviteReminders_SCWUser_UserID FOREIGN KEY (UserID) REFERENCES [dbo].[SCWUser] (UserID)
)
