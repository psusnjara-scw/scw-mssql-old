CREATE TABLE [dbo].[SCWUser](
	[UserID]					INTEGER IDENTITY (1,1)	NOT NULL,
	[UsersObject_id]			NVARCHAR(40)			NOT NULL,
	[UserTeamID]				INTEGER					NOT NULL,
	[UserCompanyID]				INTEGER					NOT NULL,

    CONSTRAINT PK_SCWUser PRIMARY KEY CLUSTERED ([UserID]),
	CONSTRAINT FK_SCWUser_Company_CompanyID FOREIGN KEY (UserCompanyID) REFERENCES [dbo].[Company] (CompanyID),
	CONSTRAINT FK_SCWUser_Team_TeamID FOREIGN KEY (UserTeamID) REFERENCES [dbo].[Team] (TeamID)
);
