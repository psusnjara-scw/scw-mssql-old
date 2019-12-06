CREATE TABLE [dbo].[UserAuth]
(
	[UserAuthID]			INTEGER IDENTITY(1,1)	NOT NULL,
	[UserID]				INTEGER					NOT NULL,
	[AuthenticationType]	NVARCHAR(50)			NOT NULL,
	[AuthenticationToken]	NVARCHAR(MAX)			NULL,	-- Encrypt ?
	[ActivationToken]		NVARCHAR(MAX)			NULL,	-- Encrypt ?
	[SAMLAttributes]		NVARCHAR(100)			NULL,
	[ResetTokens]			NVARCHAR(MAX)			NULL,
	[UserHash]					NVARCHAR(100)			NULL,

	CONSTRAINT PK_UserAuth PRIMARY KEY CLUSTERED ([UserAuthID]),
	CONSTRAINT FK_UserAuth_SCWUser_UserID FOREIGN KEY (UserID) REFERENCES [dbo].[SCWUser] (UserID)
)

